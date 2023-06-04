CREATE TABLE IF NOT EXISTS School (
    School_id INT AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(20) NOT NULL,
    Phone VARCHAR(10) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    PRIMARY KEY(School_id),
    CHECK(Email REGEXP ".+@.+(\.com|\.gr)$")
);

CREATE TABLE IF NOT EXISTS User (
	User_id INT AUTO_INCREMENT,
    Username VARCHAR(20) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Age INT NOT NULL,
    Usertype ENUM("Admin", "Library Operator", "Director", "Student", "Teacher") NOT NULL,
    School_id INT,
    PRIMARY KEY(User_id),
    FOREIGN KEY(School_id) REFERENCES School(School_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Book (
	Book_id INT AUTO_INCREMENT,
    Title VARCHAR(80) NOT NULL,
    Publisher VARCHAR(50) NOT NULL,
    ISBN VARCHAR(13) NOT NULL,
    Pages INT(4),
    Summary VARCHAR(1000),
    Image MEDIUMBLOB,
    Language ENUM ('Greek', 'English', 'French', 'German', 'Russian', 'Spanish', 'Italian', 'Chinese') NOT NULL,
    PRIMARY KEY(Book_id),
    CHECK(PAGES BETWEEN 1 AND 9999),
    CHECK(CHAR_LENGTH(ISBN) = 13)
);

CREATE TABLE IF NOT EXISTS Book_Copies (
    Book_id INT,
    School_id INT,
    Copies INT(2) NOT NULL,
    PRIMARY KEY(Book_id, School_id),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY (School_id) REFERENCES School(School_id) ON DELETE CASCADE,
    CHECK(COPIES BETWEEN 0 AND 99)
);

CREATE TABLE IF NOT EXISTS Author (
    Author_id INT AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    PRIMARY KEY(Author_id)
);

CREATE TABLE IF NOT EXISTS Book_authors (
    Book_id INT,
    Author_id INT,
    PRIMARY KEY(Book_id, Author_id),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY (Author_id) REFERENCES Author(Author_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Category (
    Category_id INT AUTO_INCREMENT,
    Category ENUM (
        'Action and Adventure', 'Art', 'Biography', 'Business and Economics', 
        'Comics and Graphic Novels', 'Computing and Technology', 'Cookbooks and Food', 
        'Crafts and Hobbies', 'Crime and Mystery', 'Drama', 'Education and Teaching', 
        'Fantasy', 'Fiction', 'Health and Wellness', 'Historical Fiction', 'History', 
        'Horror', 'Humor', 'Inspirational and Motivational', 'LGBTQ+', 'Literary Fiction', 
        'Music', 'Parenting and Family', 'Philosophy', 'Poetry', 'Politics and Social Sciences', 
        'Religion and Spirituality', 'Romance', 'Science', 'Science Fiction', 
        'Self-Help and Personal Development', 'Sports', 'Thriller', 'Travel', 
        'True Crime', 'Western'
    ) NOT NULL,
    PRIMARY KEY(Category_id)
);

CREATE TABLE IF NOT EXISTS Book_categories (
    Book_id INT,
    Category_id INT,
    PRIMARY KEY(Book_id, Category_id),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY (Category_id) REFERENCES Category(Category_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Keyword (
    Keyword_id INT AUTO_INCREMENT,
    Keyword VARCHAR(30) NOT NULL,
    PRIMARY KEY(Keyword_id)
);

CREATE TABLE IF NOT EXISTS Book_keywords (
    Book_id INT,
    Keyword_id INT,
    PRIMARY KEY(Book_id, Keyword_id),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY (Keyword_id) REFERENCES Keyword(Keyword_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS booksearch_idx
ON Book(Title, ISBN); -- prepei na ginei ena index gia tous authors

CREATE TABLE IF NOT EXISTS Loan (
	Loan_id INT,
    Date_out DATE NOT NULL,
    Due_date DATE NOT NULL,
    Return_date DATE NOT NULL,
    Status ENUM("BORROWED", "RETURNED", "LATE"),
    Book_id INT,
    User_id INT,
    PRIMARY KEY(Loan_id, Book_id, User_id),
	FOREIGN KEY(Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY(User_id) REFERENCES User(User_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Reservation (
	Reservation_id INT,
    Date_ DATE NOT NULL,
    Book_id INT,
    User_id INT,
    PRIMARY KEY(Reservation_id, Book_id, User_id),
	FOREIGN KEY(Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY(User_id) REFERENCES User(User_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Review (
	Review_id INT,
    Rating TINYINT(1) NOT NULL,
    Review VARCHAR(200),
    Book_id INT NOT NULL,
    User_id INT NULL, -- this means "nullable", not null by default + (it can't be part of PK)
    PRIMARY KEY(Review_id, Book_id),
    FOREIGN KEY(Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY(User_id) REFERENCES User(User_id) ON DELETE SET NULL,
    CHECK(Rating BETWEEN 1 AND 5)
);

-- Automatically subtract 1 from copies when a new loan is requested
CREATE TRIGGER IF NOT EXISTS subtract_copies_after_loan
AFTER INSERT ON Loan FOR EACH ROW
	UPDATE Book_Copies b INNER JOIN User u ON u.User_id = NEW.User_id
    SET b.Copies = b.Copies - 1 
    WHERE b.Book_id = NEW.Book_id AND b.School_id = u.School_id;

/*
CREATE TRIGGER  add_copy_after_return
AFTER UPDATE ON Loan FOR EACH ROW
    IF NEW.Status = 'RETURNED' AND OLD.Status <> 'RETURNED' THEN
        UPDATE Book_Copies b INNER JOIN User u ON u.User_id = NEW.User_id
        SET b.Copies = b.Copies - 1 
        WHERE b.Book_id = NEW.Book_id AND b.School_id = u.School_id;
    END IF;

CREATE EVENT IF NOT EXISTS delete_expired_reservation
ON SCHEDULE EVERY 1 HOUR
DO
    BEGIN
        DELETE FROM Reservation
        WHERE Date_ < DATEADD(day, -7, GETDATE());
    END;

CREATE EVENT IF NOT EXISTS set_delayed_loan
ON SCHEDULE EVERY 1 HOUR
DO
    BEGIN
        UPDATE Loan l
        SET l.Status = 'LATE';
        WHERE L.Due_date > GETDATE() AND l.Status = 'BORROWED';
    END;*/

-- DROP VIEW Books_Summary;

CREATE VIEW Books_Summary AS
SELECT Book_Copies.School_id, Book.Title, Book.Publisher, Book.ISBN, Book.Pages, Book.Summary, Book.Image, Book.Language, Book_Copies.Copies, GROUP_CONCAT(DISTINCT Author.Name SEPARATOR ', ') AS Authors, GROUP_CONCAT(DISTINCT Category.Category SEPARATOR ', ') AS Categories, GROUP_CONCAT(DISTINCT Keyword.Keyword SEPARATOR ', ') AS Keywords
FROM Book
JOIN Book_Copies ON Book.Book_id = Book_Copies.Book_id
JOIN Book_authors ON Book.Book_id = Book_authors.Book_id
JOIN Author ON Book_authors.Author_id = Author.Author_id
JOIN Book_categories ON Book.Book_id = Book_categories.Book_id
JOIN Category ON Book_categories.Category_id = Category.Category_id
JOIN Book_keywords ON Book.Book_id = Book_keywords.Book_id
JOIN Keyword ON Book_keywords.Keyword_id = Keyword.Keyword_id
GROUP BY Book.Book_id, Book_Copies.School_id;