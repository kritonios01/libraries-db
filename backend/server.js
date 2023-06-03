const schema = 'libraries';
const port = 3000;

//Dependencies
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const db = require('mariadb');
const mysqldump = require('mysqldump');
const ejs = require('ejs');
const multer = require('multer');
const fs = require("fs");
//Authentivation dependencies
const session = require('express-session');
const passport = require('passport');
const authStrategy = require('passport-local');
const bcrypt = require('bcrypt');

//root_path constant for all later uses
const root_path = path.resolve(__dirname, '..');

//Multer init
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

//Express init | use bodyParser for post requests | set ejs as the view engine | use a public folder for requests
const app = express();
app.use(express.static(`${root_path}/frontend/public`));
app.use(bodyParser.urlencoded({ extended: true }));
app.set('views', `${root_path}/frontend/views`);
app.set('view engine', 'ejs');

//Authentication init
app.use(session({
    secret: 'pampridism',//to be set with an env var
    resave: false,
    saveUninitialized: false,
}));
app.use(passport.initialize());
app.use(passport.session());
const saltRounds = 10;


//MariaDB Pool init
const pool = db.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: schema,
    connectionLimit: 10
});

/* --------------------------------------------------------------------------------------------------- */
//Functions for authentication
passport.use(new authStrategy(async (username, password, done) => {
    let conn = await pool.getConnection();
    try {
        let user = await conn.query("SELECT * FROM User WHERE Username = ?", [username]);
        conn.end();
        if (Object.keys(user).length === 0) {
            console.log('User not found');
            return done(null, false, { message: 'Incorrect username' });
        } else {
            bcrypt.compare(password, user[0].Password, (err, res) => {
                if (err) {
                    console.log('Hashing error')
                    return done(err);
                }
                if (!res) {
                    return done(null, false, { message: 'Incorrect password' });
                }
                else {
                    return done(null, user[0]);
                }
            });
        }
    } catch (err) {
        console.log('DB Error');
        conn.end();
        return done(err);
    } finally {
        if (conn) conn.end();
    }
}));

passport.serializeUser((user, done) => {
    process.nextTick(() => {
        return done(null, {
            username: user.Username,
            name: user.Name,
            age: user.Age,
            type: user.Usertype
        });
    });
});

passport.deserializeUser((user, done) => {
    process.nextTick(() => {
        return done(null, user);
    });
});

/* ------------------------------------------------------------------------------------------- */
//Routes
app.get('/', (req, res) => { //home route
    //if(req.user) console.log(req.user);
    res.sendFile(`${root_path}/frontend/index.html`);
});

app.get('/dashboard', (req, res) => {
    if (req.user) {
        switch (req.user.type) {
            case 'Admin':
                res.render('admin', { user:req.user });
                break;
            case 'Student':
                res.render();
                break;
            case 'Teacher':
                res.render();
                break;
        }
    } else {
        res.send('Error: You are not authorized to view this page');
    }

});

app.get('/dashboardf', (req, res) => {
    if(req.session.messages) res.render('dashboardf', { message: req.session.messages.pop() });
    else res.render('dashboardf', { message: '' });
});

app.get('/dashboardsuc', (req, res) => {
    if(req.session.messages) res.render('dashboardsuc', { message: req.session.messages.pop() });
    else res.render('dashboardsuc', { message: '' });
});

app.post('/password', async (req, res) => {
    bcrypt.hash(req.body.password, saltRounds, async (err, hash) => {
        if (err) throw err
        let conn;
        try {
            conn = await pool.getConnection();
            await conn.query("UPDATE User SET Password = ? WHERE Username = ?", [hash, req.user.username]);
            conn.end();
            req.session.messages = ['Password change successful'];
            res.redirect('/dashboardsuc');
        } catch (err) {
            if (conn) {
                console.log('DB Query Error');
                conn.end();
            } else {
                console.log('Hashing error');
            }
            req.session.messages = ['Password not changed!'];
            res.redirect('/dashboardf');
        }
    });
});

app.get('/dbbackup', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        await mysqldump({
            connection: {
                host: 'localhost',
                user: 'root',
                password: '',
                database: schema,
            },
            dumpToFile: `${root_path}/backups/backup.sql`,
        });
        res.download(`${root_path}/backups/backup.sql`);  
    } else {
        res.redirect('/');
    }
});

app.get('/books', async (req, res) => { //show books 
    let emptyCover = fs.readFileSync(`${root_path}/frontend/public/images/no-book-cover.jpg`);


    let conn;
    try {
        conn = await pool.getConnection();
        let books = await conn.query("SELECT * FROM Book");

        for (var book of books) {
            if (book.Image === null) book.Image = emptyCover.toString('base64');
        }

        res.render('books', { books: books, total_books: Object.keys(books).length, user: req.user });
    } catch (err) {
        console.log('DB Error');
    } finally {
        if (conn) return conn.end();
    }
});

app.get('/addBook', (req, res) => { //add book form route
    res.sendFile(`${root_path}/frontend/addBook.html`);
});

app.post('/addBook', upload.single('image'), async (req, res) => { //submit form route

    let data;
    if (req.file === undefined) {
        data = [
            req.body.title, req.body.publisher, Number(req.body.isbn), req.body.author,
            Number(req.body.pages), req.body.summary, Number(req.body.copies), null,
            req.body.category, req.body.language, req.body.keywords
        ];
    } else {
        data = [
            req.body.title, req.body.publisher, Number(req.body.isbn), req.body.author,
            Number(req.body.pages), req.body.summary, Number(req.body.copies), req.file.buffer,
            req.body.category, req.body.language, req.body.keywords
        ];
    }

    let conn;
    try {
        conn = await pool.getConnection();
        // let books = await conn.query(
        //     "INSERT INTO Book(Title, Publisher, ISBN, Author, Pages, Summary, Copies, Image, Category, Language, Keywords) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        //     [data.title, data.publisher, data.isbn, data.author, data.pages, data.summary, data.copies, data.image, data.category, data.language, data.keywords]); //returns json
        let books = await conn.query(
            "INSERT INTO Book(Title, Publisher, ISBN, Author, Pages, Summary, Copies, Image, Category, Language, Keywords) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            data);
        res.redirect('/success');
    } catch (err) {
        console.log('DB Error');
        res.redirect('/addBookf');
    } finally {
        if (conn) return conn.end();
    }
});

app.get('/addBookf', (req, res) => { //get failure page for adding book
    res.sendFile(`${root_path}/frontend/addBookf.html`);
});

app.get('/success', (req, res) => { //get success page
    res.sendFile(`${root_path}/frontend/success.html`);
});


/* -------------------------------------------------------------------------------------------------------------- */
//Sign-in/out/up Routes
app.get('/signin', (req, res) => { //get signin page
    if (req.isAuthenticated()) res.redirect('/');
    else res.sendFile(`${root_path}/frontend/signin.html`);
});

app.post('/signin',
    passport.authenticate('local', { failureRedirect: '/signinf', failureMessage: true }),
    (req, res) => {
        res.redirect('/');
    }
);

app.post('/signout', (req, res) => {
    req.logout(err => {
        if (err) console.log('Error signing out!');
        else res.redirect('/');
    });

});


app.get('/signup', (req, res) => { //get signup page
    res.sendFile(`${root_path}/frontend/signup.html`);
});

// bcrypt.hash('12345', saltRounds, function(err, hash) {
//     console.log(hash);
// });

app.get('/signinf', (req, res) => {
    if(req.session.messages) res.render('signinf', { message: req.session.messages.pop() });
    else res.render('signinf', { message: '' });
});







app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});