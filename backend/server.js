const schema = 'school_libraries_db';
const port = 3000;

//Dependencies
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const db = require('mariadb');
const ejs = require('ejs');
const multer = require('multer');
const fs = require("fs");

//Multer init
const storage = multer.memoryStorage();
const upload = multer({storage: storage});

//Express init and use bodyParser for post requests
const app = express();
app.use(bodyParser.urlencoded({extended: false}));
app.set('view engine', 'ejs');
app.use(express.static('public'));

//root_path constant for all later uses
const root_path = path.resolve(__dirname, '..');

//Init MariaDB Pool
const pool = db.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: schema,
    connectionLimit: 10
});

app.get('/', (req,res) => { //home route
    res.sendFile(`${root_path}/frontend/index.html`);
});

app.get('/books', async(req,res) => { //show books 
    let emptyCover = fs.readFileSync(`${root_path}/backend/public/images/no-book-cover.jpg`);

    let conn;
    try {
        conn = await pool.getConnection();
        let books = await conn.query("SELECT * FROM Book");

        for (var book of books) {
            if(book.Image === null) book.Image = emptyCover.toString('base64');
        }

        res.render('books', {books:books, total_books:Object.keys(books).length});
    } catch (err) {
        console.log('DB Error');
    } finally {
        if (conn) return conn.end();
    }
});

app.get('/addBook', (req,res) => { //add book form route
    res.sendFile(`${root_path}/frontend/addBook.html`);
});

app.post('/addBook', upload.single('image'), async(req,res) => { //submit form route

    let data;
    if(req.file === undefined){
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

app.get('/addBookf', (req,res) => { //get failure page for adding book
    res.sendFile(`${root_path}/frontend/addBookf.html`);
});

app.get('/success', (req,res) => { //get success page
    res.sendFile(`${root_path}/frontend/success.html`);
});

app.get('/signin', (req,res) => { //get signin page
    res.sendFile(`${root_path}/frontend/signin.html`);
});





app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});