const schema = 'school_libraries_db';
const port = 3000;

//Dependencies
//const http = require('http');
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const db = require('mariadb');
let ejs = require('ejs');
//const { type } = require('os');

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
    connectionLimit: 1
});

app.get('/', (req,res) => {
    res.sendFile(`${root_path}/frontend/index.html`);
});
/*
app.get('/books', (req,res) => {
    res.sendFile(`${root_path}/frontend/Books.html`);
});*/

app.get('/books', async(req,res) => {
    let conn;
    try {
        conn = await pool.getConnection();
        let books = await conn.query("SELECT * FROM Book"); //returns json

        res.render('books', {books:books, total_books:Object.keys(books).length});
    } catch (err) {
        console.log('Problem with the DB');
    } finally {
        if (conn) return conn.end(); //this should maybe execute after all queries
    }
});

app.get('/addBook', (req,res) => {
    res.sendFile(`${root_path}/frontend/addBook.html`);
});

app.post('/addBook', async(req,res) => {
    let data = [
        req.body.title, req.body.publisher, Number(req.body.isbn), req.body.author,
        Number(req.body.pages), req.body.summary, Number(req.body.copies), req.body.image,
        req.body.category, req.body.language, req.body.keywords
    ];
    
    let conn;
    try {
        conn = await pool.getConnection();
        // let books = await conn.query(
        //     "INSERT INTO Book(Title, Publisher, ISBN, Author, Pages, Summary, Copies, Image, Category, Language, Keywords) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        //     [data.title, data.publisher, data.isbn, data.author, data.pages, data.summary, data.copies, data.image, data.category, data.language, data.keywords]); //returns json
        let books = await conn.query(
            "INSERT INTO Book(Title, Publisher, ISBN, Author, Pages, Summary, Copies, Image, Category, Language, Keywords) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            data); //returns json
        res.redirect('/success');
    } catch (err) {
        res.redirect('/addBookf');
    } finally {
        if (conn) return conn.end();
    }
});

app.get('/addBookf', (req,res) => {
    res.sendFile(`${root_path}/frontend/addBookf.html`);
});

app.get('/success', (req,res) => {
    res.sendFile(`${root_path}/frontend/success.html`);
});

app.get('/signin', (req,res) => {
    res.sendFile(`${root_path}/frontend/signin.html`);
});



app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});