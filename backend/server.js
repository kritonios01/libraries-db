const schema = 'libraries';
const port = 3000;

//Dependencies
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const db = require('mariadb');
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
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(`${root_path}/frontend/public`));
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

/* ---------------------------------------------------------- */
//Functions for authentication
passport.use(new authStrategy( async(username, password, done) => {

    //console.log('ddd');
    console.log(username, password);

    let conn = await pool.getConnection();
    try{
        let user = await conn.query("SELECT * FROM User WHERE Username = ?", [username]);
        if (Object.keys(user).length === 0) {
            conn.end();
            console.log('User not found');
            return done(null, false, { message: 'Incorrect username' });
        } else {
            conn.end();
            console.log('User found!')
            bcrypt.compare(password, user[0].Password, (err, res) => {
                //console.log(user[0].Password, res);
                if (err) {
                    console.log('Hashing error')
                    return done(err);
                }
                if (!res) {
                    return done(null, false, { message: 'Incorrect password' });
                }
                else {
                    return done(null, user);
                }
            });
        }
    } catch (err) {
        console.log('DB Error');
        conn.end();
        return done(err);
    } finally {
        conn.end();
    }


    /*if (Object.keys(user).length === 0) {
        conn.end();
        return cb(null, false, { message: 'Incorrect username or password.' });
    }
    bcrypt.compare(user[0].Password, password

} catch (err) {
    console.log('DB Error');
    return cb(err);
} finally {
    if (conn) return conn.end();
}*/

}));

passport.serializeUser( (user, done) => {
    process.nextTick( () => {
        return done(null, {
            username: user.Username
        });
    });
});

passport.deserializeUser(function (user, done) {
    process.nextTick(function () {
        return done(null, user);
    });
});

/* ---------------------------------------------------------- */

//Routes
app.get('/', (req, res) => { //home route
    res.sendFile(`${root_path}/frontend/index.html`);
    if(req.session.messages) { console.log(req.session.messages)};
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

        res.render('books', { books: books, total_books: Object.keys(books).length });
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

app.get('/signin', (req, res) => { //get signin page
    res.sendFile(`${root_path}/frontend/signin.html`);
});

app.post('/signin', 
    passport.authenticate('local', {failureRedirect: '/', failureMessage: true}),
    (req, res) => {
        //console.log(req.body);
        res.send(`Signed in as ${JSON.stringify(req.user)}`);
    }
);

app.get('/signup', (req, res) => { //get signup page
    res.sendFile(`${root_path}/frontend/signup.html`);
});

// bcrypt.hash('12345', saltRounds, function(err, hash) {
//     console.log(hash);
// });








app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});