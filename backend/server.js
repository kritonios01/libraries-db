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
const strftime = require('strftime');
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
app.use(express.json());
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
            type: user.Usertype,
            school: user.School_id
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
    //if (req.user) req.logout(err => { if (err) console.log('Error signing out!'); });
    res.render('home', { user: req.user });
});

/* ------------------------------------------------------------------------------------------- */
//Basic Dashboard Routes: Main Page, Success-Failure redirects, Username-Password change requests, 
app.get('/dashboard', async (req, res) => {
    if (req.user) {
        let conn;
        let school;
        try {
            conn = await pool.getConnection();
            school = await conn.query("SELECT (Name) FROM School WHERE School_id = ?", [req.user.school]);
        } catch (err) {
            console.log('DB Error');
        } finally {
            if (conn) conn.end();
        }

        switch (req.user.type) {
            case 'Admin':
                res.render('admin', { user: req.user });
                break;
            case 'Library Operator':
                res.render('library-op', { user: req.user, school: school[0].Name });
                break;
            case 'Student':
                res.render('student', { user: req.user, school: school[0].Name });
                break;
            case 'Teacher':
                res.render('teacher', { user: req.user, school: school[0].Name });
                break;
            case 'Director':
                res.render('teacher', { user: req.user, school: school[0].Name });
                break;
        }
    } else {
        res.send('Error: You are not authorized to view this page');
    }

});

app.get('/dashboardf', (req, res) => {
    if (req.session.messages) res.render('dashboardf', { message: req.session.messages.pop(), user: req.user });
    else res.render('dashboardf', { message: '', user: req.user });
});

app.get('/dashboardsuc', (req, res) => {
    if (req.session.messages) res.render('dashboardsuc', { message: req.session.messages.pop(), user: req.user });
    else res.render('dashboardsuc', { message: '', user: req.user });
});

app.post('/password-change', async (req, res) => {
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

app.post('/username-change', async (req, res) => {
    let conn;
    try {
        conn = await pool.getConnection();
        await conn.query("UPDATE User SET Username = ? WHERE Username = ?", [req.body.username, req.user.username]);
        conn.end();
        req.logout(err => {
            if (err) console.log('Error signing out!');
            else {
                req.session.messages = ['Username change successful'];
                res.redirect('/homesuc');
            }
        });
    } catch (err) {
        if (conn) {
            console.log('DB Query Error');
            conn.end();
        }
        req.session.messages = ['Username not changed!'];
        res.redirect('/dashboardf');
    }
});





app.get('/books', async (req, res) => { //show books
    if (req.isAuthenticated() &&
           (req.user.type === 'Student'  ||
            req.user.type === 'Teacher'  ||
            req.user.type === 'Director' ||
            req.user.type === 'Library Operator')) {

        let emptyCover = fs.readFileSync(`${root_path}/frontend/public/images/no-book-cover.jpg`);
        let conn;
        try {
            conn = await pool.getConnection();
            let books = await conn.query("SELECT * FROM Books_summary WHERE School_id = ?", [req.user.school]);
            for (var book of books) {
                if (book.Image === null) book.Image = emptyCover.toString('base64');
            }

            res.render('books', { books: books, total_books: Object.keys(books).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
        } finally {
            if (conn) return conn.end();
        }
    } else {
        res.send('Error: You are not authorized to view this page'); // na dialagei o admin sxoleio kai na vlepei ta vivlia tou
    }
});

app.get('/homesuc', (req, res) => { //get home success page
    if (req.session.messages) res.render('homesuc', { message: req.session.messages.pop(), user: req.user });
    else res.render('homesuc', { message: '', user: req.user });
});

app.get('/homef', (req, res) => { //get home failure page
    if (req.session.messages) res.render('homef', { message: req.session.messages.pop(), user: req.user });
    else res.render('homef', { message: '', user: req.user });
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
        // if (req.user.Usertype === 'Admin' || req.user.Usertype === 'Library Operator') res.redirect('/dashboard')
        // else res.redirect('/books');
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
    if (req.session.messages) res.render('signinf', { message: req.session.messages.pop(), user: req.user });
    else res.render('signinf', { message: '', user: req.user });
});




/* --------------------------------------------------------------------------------------------------------------------------------------------- */
// Admin Queries Routes

//Create backup
app.get('/dbbackup', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        await mysqldump({
            connection: {
                host: 'localhost',
                user: 'root',
                password: '',
                database: schema
            },
            dumpToFile: `${root_path}/backups/backup.sql`,
        });
        res.download(`${root_path}/backups/backup.sql`);
    } else {
        res.redirect('/');
    }
});

//Add School
app.post('/admin-add-school', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        school_data = [req.body.name, req.body.address, req.body.city, req.body.phone, req.body.mail];

        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("INSERT INTO School(Name, Address, City, Phone, Email) VALUES (?, ?, ?, ?, ?)", school_data);
            conn.end();

            req.session.messages = ['Registered school successfully'];
            res.redirect('/dashboardsuc');
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();

            req.session.messages = ['School not registered!'];
            res.redirect('/dashboardf');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Request 1: Total Loans per school
app.post('/admin-loans', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        let conn;
        try {
            conn = await pool.getConnection();
            let school_loans;
            if (req.body.my === '') {
                school_loans = await conn.query("SELECT School_Name, SUM(Total_Loans) AS Total_Loans " +
                    "FROM LoansPerMonth " +
                    "GROUP BY School_Name " +
                    "ORDER BY School_Name");
            } else {
                const [year, month] = req.body.my.split('-');
                school_loans = await conn.query("SELECT * FROM LoansPerMonth WHERE Loan_Year = ? AND Loan_Month = ?", [year, month]);
            }
            conn.end();
            let school_names = [];
            let loans = [];
            for (item of school_loans) {
                school_names.push(item.School_Name);
                loans.push(item.Total_Loans)
            }
            res.render('admin-queries', { message: 'View loans per school', left_items: school_names, right_items: loans, total_items: Object.keys(school_loans).length, user: req.user })
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Request 2.1: Authors belonging to a category
app.post('/admin-author-categories', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM CategoryAuthors WHERE Category = ?", [req.body.category]);
            conn.end();

            let length = Object.keys(data).length;
            if (length === 0) {
                res.render('admin-queries', { message: 'No authors in this category', left_items: '', right_items: '', total_items: length, user: req.user });
            } else {
                res.render('admin-queries', { message: 'View authors per category', left_items: [data[0].Category], right_items: [data[0].Authors], total_items: length, user: req.user });
            }
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Request 2.2: Teachers who have rented books of a category the last year
app.post('/admin-teacher-categories', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM CategoryTeachers WHERE Category = ?", [req.body.category]);
            conn.end();

            let length = Object.keys(data).length;
            if (length === 0) {
                res.render('admin-queries', { message: `No teachers have rented books this year in the category ${req.body.category}`, left_items: '', right_items: '', total_items: length, user: req.user });
            } else {
                res.render('admin-queries', { message: 'View teachers who have rented books this year per category', left_items: [data[0].Category], right_items: [data[0].Teachers], total_items: length, user: req.user });
            }
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Request 3: 
app.get('/admin-young-teachers', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM YoungTeachers");
            conn.end();

            let teachers = [];
            for (item of data) teachers.push(item.Teachers);
            let teachers_str = teachers.join(', ');

            if (Object.keys(data).length === 0) {
                res.render('admin-queries', { message: `No teachers have rented books yet`, left_items: '', right_items: '', total_items: 0, user: req.user });
            } else {
                res.render('admin-queries', { message: 'View the young (<40) teachers who have rented the most books', left_items: [teachers_str], right_items: [data[0].NumBooksBorrowed], total_items: 1, user: req.user });
            }
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Request 4:
app.get('/admin-authors-noloans', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM AuthorWithoutLoans");
            conn.end();

            let authors = []
            for (item of data) authors.push(item.AuthorName);

            res.render('admin-queries', { message: 'View authors whose books have not been rented yet', left_items: authors, right_items: '', total_items: Object.keys(data).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Request 5:
app.get('/admin-ops-20loans', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM Operators20Loans");
            conn.end();

            let length = Object.keys(data).length;
            if (length === 0) {
                res.render('admin-queries', { message: `No operators have approved more than 20 books in the last year`, left_items: '', right_items: '', total_items: 0, user: req.user });
            } else {
                let ops = [];
                let numberBooks = []
                for (item of data) {
                    ops.push(item.Operators);
                    numberBooks.push(item.LoanedBooks);
                }

                res.render('admin-queries', { message: 'View operators who have approved more than 20 books in the last year', left_items: ops, right_items: numberBooks, total_items: length, user: req.user });
            }
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Request 6
app.get('/admin-top3-cat', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM Top3pairs");
            conn.end();

            let length = Object.keys(data).length;
            if (length === 0) {
                res.render('admin-queries', { message: `There haven't been enough loans yet`, left_items: '', right_items: '', total_items: 0, user: req.user });
            } else {
                let categories = [];
                let loans = []
                for (item of data) {
                    categories.push(`${item.Category1} - ${item.Category2}`);
                    loans.push(item.Borrowings);
                }

                res.render('admin-queries', { message: 'View top-3 category pairs which have appeared in loans', left_items: categories, right_items: loans, total_items: length, user: req.user });
            }
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Request 7
app.get('/admin-5books-less', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Admin') {
        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM AuthorsFewBooks");
            conn.end();

            let length = Object.keys(data).length;
            if (length === 0) {
                res.render('admin-queries', { message: `There are no authors with at least 5 books less than the author with the most books`, left_items: '', right_items: '', total_items: 0, user: req.user });
            } else {
                let authors = []
                for (item of data) {
                    authors.push(item.Authors);
                }

                res.render('admin-queries', { message: 'View authors with at least 5 books less than the author with the most books', left_items: authors, right_items: '', total_items: length, user: req.user });
            }
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});




/* --------------------------------------------------------------------------------------------------------------------------------------------- */
// Library Operator Queries Routes

//Add Book
app.post('/libop-add-book', upload.single('image'), async (req, res) => { //prepei na dexetai comma-seperated values
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {
    
        for(field in req.body) {
            if (req.body[field] === '') req.body[field] = null;
            else req.body[field] = req.body[field].trimEnd();
        }

        let conn;
        try {
            conn = await pool.getConnection();

            if (req.file === undefined) {
                var book = await conn.query("INSERT INTO Book(Title, Publisher, ISBN, Pages, Summary, Image, Language) VALUES (?, ?, ?, ?, ?, ?, ?)",
                [req.body.title, req.body.publisher, req.body.isbn, req.body.pages, req.body.summary, null, req.body.lang]);
            } else {
                var book = await conn.query("INSERT INTO Book(Title, Publisher, ISBN, Pages, Summary, Image, Language) VALUES (?, ?, ?, ?, ?, ?, ?)",
                [req.body.title, req.body.publisher, req.body.isbn, req.body.pages, req.body.summary, req.file.buffer, req.body.lang]);
            }

            await conn.query("INSERT INTO Book_Copies(Copies, Book_id, School_id) VALUES (?, ?, ?)", [req.body.copies, book.insertId, req.user.school]);

            var author = await conn.query("SELECT * FROM Author WHERE Name = ?", [req.body.authors]);
            if (Object.keys(author).length !== 0) {
                await conn.query("INSERT INTO Book_authors(Book_id, Author_id) VALUES (?, ?)", [book.insertId, author[0].Author_id]);
            } else {
                let author = await conn.query("INSERT INTO Author(Name) VALUES (?)", [req.body.authors]);
                await conn.query("INSERT INTO Book_authors(Book_id, Author_id) VALUES (?, ?)", [book.insertId, author.insertId]);
            }

            if (req.body.category !== null) {
                let category = await conn.query("SELECT Category_id FROM Category WHERE Category = ?", [req.body.category]);
                await conn.query("INSERT INTO Book_categories(Book_id, Category_id) VALUES (?, ?)", [book.insertId, category[0].Category_id]);
            }
            
            if(req.body.keywords !== null) {
                var keyword = await conn.query("SELECT * FROM Keyword WHERE Keyword = ?", [req.body.keywords]);
                if (Object.keys(keyword).length !== 0) {
                    await conn.query("INSERT INTO Book_keywords(Book_id, Keyword_id) VALUES (?, ?)", [book.insertId, keyword[0].Keyword_id]);
                } else {
                    let keyword = await conn.query("INSERT INTO Keyword(Keyword) VALUES (?)", [req.body.keywords]);
                    await conn.query("INSERT INTO Book_keywords(Book_id, Keyword_id) VALUES (?, ?)", [book.insertId, keyword.insertId]);
                }
            }

            req.session.messages = ['Registered book successfully'];
            res.redirect('/dashboardsuc');
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();

            console.log(err);

            req.session.messages = ['Book not registered!'];
            res.redirect('/dashboardf');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//View Loan requests
app.get('/libop-view-req', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {
        let conn;
        try {
            conn = await pool.getConnection();
            let loans = await conn.query("SELECT * FROM LoanRequests WHERE School_id = ? AND Status = 'REQUESTED'", [req.user.school]);
            conn.end();

            for (var loan of loans) {
                loan.Date_out = strftime('%d-%m-%Y', new Date(loan.Date_out));
            }

            res.render('libop-queries', { message: 'View loan requests in your school', loans: loans, total_items: Object.keys(loans).length, user: req.user });

        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            req.session.messages = ['There was an error with the Database'];
            res.redirect('/dashboardf');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Accept a loan request
app.post('/libop-acc-req', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {

        const dueDate = new Date();
        dueDate.setDate(dueDate.getDate() + 7);

        let conn;
        try {
            conn = await pool.getConnection();
            await conn.query("UPDATE Loan SET Status = 'BORROWED', Due_date = ? WHERE Loan_id = ?", [dueDate, req.body.loanid]);
            conn.end();

            req.session.messages = ['Loan for this book granted!'];
            res.redirect('/dashboardsuc');
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            req.session.messages = ['There was an error with the Database'];
            res.redirect('/dashboardf');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Search for late books
app.post('/libop-late', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {

        let conn;
        try {
            conn = await pool.getConnection();
            let loans = await conn.query("SELECT * FROM LateLoans");
            conn.end();

            let names = [];
            let days = []
            for (var loan of loans) {
                names.push(loan.Name);
                days.push(loan.DelayDays);
            }

            res.render('admin-queries', { message: 'View all borrowers who have delayed the return of a book', left_items: names, right_items: days, total_items: Object.keys(loans).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Search for late books by first name
app.post('/libop-late-fname', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {

        let conn;
        try {
            conn = await pool.getConnection();
            let loans = await conn.query("SELECT * FROM LateLoans WHERE Name LIKE ?", [`${req.body.fname}%`]);
            conn.end();

            let names = [];
            let days = []
            for (var loan of loans) {
                names.push(loan.Name);
                days.push(loan.DelayDays);
            }

            res.render('admin-queries', { message: 'View all borrowers who have delayed the return of a book', left_items: names, right_items: days, total_items: Object.keys(loans).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Search for late books by last name
app.post('/libop-late-lname', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {

        let conn;
        try {
            conn = await pool.getConnection();
            let loans = await conn.query("SELECT * FROM LateLoans WHERE Name LIKE ?", [`%${req.body.lname}`]);
            conn.end();

            let names = [];
            let days = []
            for (var loan of loans) {
                names.push(loan.Name);
                days.push(loan.DelayDays);
            }

            res.render('admin-queries', { message: 'View all borrowers who have delayed the return of a book', left_items: names, right_items: days, total_items: Object.keys(loans).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Search for late books by days
app.post('/libop-late-days', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {

        let conn;
        try {
            conn = await pool.getConnection();
            let loans = await conn.query("SELECT * FROM LateLoans WHERE DelayDays = ?", [req.body.days]);
            conn.end();

            let names = [];
            let days = []
            for (var loan of loans) {
                names.push(loan.Name);
                days.push(loan.DelayDays);
            }

            res.render('admin-queries', { message: 'View all borrowers who have delayed the return of a book', left_items: names, right_items: days, total_items: Object.keys(loans).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Average ratings per user
app.post('/libop-avg-user', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {

        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM AvgBorrower");
            conn.end();

            let names = [];
            let rating = []
            for (var row of data) {
                names.push(row.Borrower);
                rating.push(row.AverageRating);
            }

            res.render('admin-queries', { message: 'View average rating per borrower', left_items: names, right_items: rating, total_items: Object.keys(data).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Average ratings per user - search
app.post('/libop-avg-user-name', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {

        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM AvgBorrower WHERE Borrower = ?", [req.body.name]);
            conn.end();

            let names = [];
            let rating = []
            for (var row of data) {
                names.push(row.Borrower);
                rating.push(row.AverageRating);
            }

            res.render('admin-queries', { message: 'View average rating per borrower', left_items: names, right_items: rating, total_items: Object.keys(data).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Average ratings per category
app.post('/libop-avg-cat', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {

        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM AvgCat");
            conn.end();

            let cats = [];
            let rating = []
            for (var row of data) {
                cats.push(row.Category);
                rating.push(row.AverageRating);
            }

            res.render('admin-queries', { message: 'View average rating per category', left_items: cats, right_items: rating, total_items: Object.keys(data).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Average ratings per category - search
app.post('/libop-avg-cat-name', async (req, res) => {
    if (req.isAuthenticated() && req.user.type === 'Library Operator') {

        let conn;
        try {
            conn = await pool.getConnection();
            let data = await conn.query("SELECT * FROM AvgCat WHERE Category = ?", [req.body.category]);
            conn.end();

            let cats = [];
            let rating = []
            for (var row of data) {
                cats.push(row.Category);
                rating.push(row.AverageRating);
            }

            res.render('admin-queries', { message: 'View average rating per category', left_items: cats, right_items: rating, total_items: Object.keys(data).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            res.redirect('/dashboard');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});



/* --------------------------------------------------------------------------------------------------------------------------------------------- */
// Student Queries Routes

//Rent a book
app.post('/student-rent', async (req, res) => {
    if (req.isAuthenticated() && 
            (req.user.type === 'Student'   ||
             req.user.type === 'Teacher'   ||
             req.user.type === 'Director')) {

        const curDate = new Date();

        let conn;
        try {
            conn = await pool.getConnection();
            let user = await conn.query("SELECT User_id FROM User WHERE Username = ?", [req.user.username])
            await conn.query("INSERT INTO Loan(Date_out, Due_date, Status, Book_id, User_id) VALUES (?, ?, ?, ?, ?)", [curDate, null, 'REQUESTED', req.body.Book_id, user[0].User_id]);
            conn.end();

            req.session.messages = ['Loan request sent successfully! Now you must wait for your library operator to accept it.'];
            res.redirect('/homesuc');
        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            req.session.messages = ['There was an error with the Database'];
            res.redirect('/homef');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});





/* --------------------------------------------------------------------------------------------------------------------------------------------- */
// User Queries Routes

//Book search by title
app.post('/books-search-title', async (req, res) => {
    if (req.isAuthenticated() && 
            (req.user.type === 'Student'   ||
             req.user.type === 'Teacher'   ||
             req.user.type === 'Director'  ||
             req.user.type === 'Library Operator')) {

        let emptyCover = fs.readFileSync(`${root_path}/frontend/public/images/no-book-cover.jpg`);
        let conn;
        try {
            conn = await pool.getConnection();
            let books = await conn.query("SELECT * FROM Books_summary WHERE Title = ? AND School_id = ?", [req.body.title, req.user.school]);
            conn.end();

            for (var book of books) {
                if (book.Image === null) book.Image = emptyCover.toString('base64');
            }

            res.render('books', { books: books, total_books: Object.keys(books).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            req.session.messages = ['There was an error with the Database'];
            res.redirect('/homef');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Book search by category
app.post('/books-search-category', async (req, res) => {
    if (req.isAuthenticated() && 
            (req.user.type === 'Student'   ||
             req.user.type === 'Teacher'   ||
             req.user.type === 'Director'  ||
             req.user.type === 'Library Operator')) {

        let emptyCover = fs.readFileSync(`${root_path}/frontend/public/images/no-book-cover.jpg`);
        let conn;
        try {
            conn = await pool.getConnection();
            let books = await conn.query("SELECT * FROM Books_summary WHERE Categories LIKE ? AND School_id = ?", [`%${req.body.category}%`, req.user.school]);
            conn.end();

            for (var book of books) {
                if (book.Image === null) book.Image = emptyCover.toString('base64');
            }

            res.render('books', { books: books, total_books: Object.keys(books).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            req.session.messages = ['There was an error with the Database'];
            res.redirect('/homef');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Book search by author
app.post('/books-search-author', async (req, res) => {
    if (req.isAuthenticated() && 
            (req.user.type === 'Student'   ||
             req.user.type === 'Teacher'   ||
             req.user.type === 'Director'  ||
             req.user.type === 'Library Operator')) {

        let emptyCover = fs.readFileSync(`${root_path}/frontend/public/images/no-book-cover.jpg`);
        let conn;
        try {
            conn = await pool.getConnection();
            let books = await conn.query("SELECT * FROM Books_summary WHERE Authors LIKE ? AND School_id = ?", [`%${req.body.author}%`, req.user.school]);
            conn.end();

            for (var book of books) {
                if (book.Image === null) book.Image = emptyCover.toString('base64');
            }

            res.render('books', { books: books, total_books: Object.keys(books).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            req.session.messages = ['There was an error with the Database'];
            res.redirect('/homef');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//Book search by copies
app.post('/books-search-copies', async (req, res) => {
    if (req.isAuthenticated() && 
            (req.user.type === 'Student'   ||
             req.user.type === 'Teacher'   ||
             req.user.type === 'Director'  ||
             req.user.type === 'Library Operator')) {

        let emptyCover = fs.readFileSync(`${root_path}/frontend/public/images/no-book-cover.jpg`);
        let conn;
        try {
            conn = await pool.getConnection();
            let books = await conn.query("SELECT * FROM Books_summary WHERE Copies = ? AND School_id = ?", [req.body.copies, req.user.school]);
            conn.end();

            for (var book of books) {
                if (book.Image === null) book.Image = emptyCover.toString('base64');
            }

            res.render('books', { books: books, total_books: Object.keys(books).length, user: req.user });
        } catch (err) {
            console.log('DB Error');
            if (conn) conn.end();
            req.session.messages = ['There was an error with the Database'];
            res.redirect('/homef');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});

//View loans
app.get('/view-loans', async (req, res) => {
    if (req.isAuthenticated() &&
           (req.user.type === 'Student'   ||
            req.user.type === 'Teacher'   ||
            req.user.type === 'Director')) {
        let conn;
        try {
            conn = await pool.getConnection();
            let loans = await conn.query("SELECT * FROM LoanRequests WHERE Username = ? AND School_id = ?", [req.user.username, req.user.school]);
            conn.end();

            for (var loan of loans) {
                loan.Date_out = strftime('%d-%m-%Y', new Date(loan.Date_out));
                loan.Due_date = strftime('%d-%m-%Y', new Date(loan.Due_date));
            }

            res.render('user-queries', { message: 'View your loan history', loans: loans, total_items: Object.keys(loans).length, user: req.user });

        } catch (err) {
            console.log('DB Error');
            console.log(err);
            if (conn) conn.end();
            req.session.messages = ['There was an error with the Database'];
            res.redirect('/dashboardf');
        }
    } else {
        res.send('You are not authorized to view this content');
    }
});











app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});