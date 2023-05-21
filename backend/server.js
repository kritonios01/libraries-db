//Dependencies
//const http = require('http');
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const db = require('mariadb');
const { type } = require('os');

//Express init and use bodyParser for post requests
const app = express();
app.use(bodyParser.urlencoded({extended: false}));
const port = 3000;

//root_path constant for all later uses
const root_path = path.resolve(__dirname, '..');

//Init MariaDB Pool
const pool = db.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'school_libraries_db',
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
        res.send(books);
    } catch (err) {
        throw err;
    } finally {
        if (conn) return conn.end(); //this should maybe execute after all queries
    }
});

app.get('/addBook', (req,res) => {
    res.sendFile(`${root_path}/frontend/addBook.html`);
});

app.post('/addBook', async(req,res) => {
    //res.sendFile(`${root_path}/frontend/addBook.html`); --> go to  success page
    //console.log(req.body)
    // let data = {
    //     title: req.body.title,
    //     publisher: req.body.publisher,
    //     isbn: Number(req.body.isbn),
    //     author: req.body.author,
    //     pages: Number(req.body.pages),
    //     summary: req.body.summary,
    //     copies: Number(req.body.copies),
    //     image: req.body.image,
    //     category: req.body.category,
    //     language: req.body.language,
    //     keywords: req.body.keywords
    // };

    let data = [
        req.body.title,
        req.body.publisher,
        Number(req.body.isbn),
        req.body.author,
        Number(req.body.pages),
        req.body.summary,
        Number(req.body.copies),
        req.body.image,
        req.body.category,
        req.body.language,
        req.body.keywords
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
        console.log(books);
    } catch (err) {
        console.log(err);

        throw err;
        
    } finally {
        if (conn) return conn.end();
    }
});




app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});