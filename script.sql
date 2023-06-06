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
    Publisher VARCHAR(100) NOT NULL,
    ISBN VARCHAR(13) NOT NULL,
    Pages INT(4) NOT NULL,
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
    Name VARCHAR(50) UNIQUE NOT NULL,
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
ON Book(Title, ISBN);

CREATE INDEX IF NOT EXISTS usersearch_idx
ON User(Username, Password);

CREATE INDEX IF NOT EXISTS authorsearch_idx
ON Author(Name);

CREATE INDEX IF NOT EXISTS categorysearch_idx
ON Category(Category);

CREATE INDEX IF NOT EXISTS usersearch_idx
ON User(Username, Password);

CREATE TABLE IF NOT EXISTS Loan (
	Loan_id INT AUTO_INCREMENT,
    Date_out DATE,
    Due_date DATE,
    Return_date DATE,
    Status ENUM("REQUESTED", "BORROWED", "RETURNED", "LATE"),
    Book_id INT,
    User_id INT,
    PRIMARY KEY(Loan_id, Book_id, User_id),
	FOREIGN KEY(Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY(User_id) REFERENCES User(User_id) ON DELETE CASCADE,
    CHECK (Date_out < Due_date),
    CHECK (Date_out < Return_date)
);

CREATE TABLE IF NOT EXISTS Reservation (
	Reservation_id INT AUTO_INCREMENT,
    Date_ DATE NOT NULL,
    Book_id INT,
    User_id INT,
    PRIMARY KEY(Reservation_id, Book_id, User_id),
	FOREIGN KEY(Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY(User_id) REFERENCES User(User_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Review (
	Review_id INT AUTO_INCREMENT,
    Rating TINYINT(1) NOT NULL,
    Review VARCHAR(200),
    Book_id INT NOT NULL,
    User_id INT NULL, -- this means "nullable", not null by default + (it can't be part of PK)
    PRIMARY KEY(Review_id, Book_id),
    FOREIGN KEY(Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE,
    FOREIGN KEY(User_id) REFERENCES User(User_id) ON DELETE SET NULL,
    CHECK(Rating BETWEEN 1 AND 5)
);

-- Automatically subtract 1 from copies when a book is borrowed
DELIMITER //
CREATE TRIGGER IF NOT EXISTS subtract_copies_after_loan
AFTER INSERT ON Loan FOR EACH ROW
    IF NEW.Status = 'BORROWED' THEN
	    UPDATE Book_Copies b INNER JOIN User u ON u.User_id = NEW.User_id
        SET b.Copies = b.Copies - 1
        WHERE b.Book_id = NEW.Book_id AND b.School_id = u.School_id;
    END IF;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER IF NOT EXISTS subtract_copies_after_loan_granted
AFTER UPDATE ON Loan FOR EACH ROW
    IF OLD.Status = 'REQUESTED' AND NEW.Status = 'BORROWED' THEN
	    UPDATE Book_Copies b INNER JOIN User u ON u.User_id = NEW.User_id
        SET b.Copies = b.Copies - 1
        WHERE b.Book_id = NEW.Book_id AND b.School_id = u.School_id;
    END IF;
//
DELIMITER ;

-- Automatically add 1 to copies when a book is returned
DELIMITER //
CREATE TRIGGER IF NOT EXISTS add_copy_after_return
AFTER UPDATE ON Loan FOR EACH ROW
    IF NEW.Status = 'RETURNED' AND OLD.Status <> 'RETURNED' THEN
        UPDATE Book_Copies b INNER JOIN User u ON u.User_id = NEW.User_id
        SET b.Copies = b.Copies - 1
        WHERE b.Book_id = NEW.Book_id AND b.School_id = u.School_id;
    END IF;
//
DELIMITER ;

DELIMITER //
CREATE EVENT IF NOT EXISTS delete_expired_reservation
ON SCHEDULE EVERY 12 HOUR
DO
    BEGIN
        DELETE FROM Reservation
        WHERE Date_ < DATEADD(day, -7, GETDATE());
    END;
//
DELIMITER ;

DELIMITER //
CREATE EVENT IF NOT EXISTS set_delayed_loan
ON SCHEDULE EVERY 12 HOUR
DO
    BEGIN
        UPDATE Loan l
        SET l.Status = 'LATE'
        WHERE l.Due_date < GETDATE() AND l.Status = 'BORROWED';
    END;
//
DELIMITER ;

-- VIEWS FOR COMMON SERVER QUERIES ---------------------------------

-- GET BOOKS DATA
CREATE VIEW IF NOT EXISTS Books_summary AS
SELECT Book.Book_id, Book_Copies.School_id, Book.Title, Book.Publisher, Book.ISBN, Book.Pages, Book.Summary, Book.Image, Book.Language, Book_Copies.Copies, GROUP_CONCAT(DISTINCT Author.Name SEPARATOR ', ') AS Authors, GROUP_CONCAT(DISTINCT Category.Category SEPARATOR ', ') AS Categories, GROUP_CONCAT(DISTINCT Keyword.Keyword SEPARATOR ', ') AS Keywords
FROM Book
JOIN Book_Copies ON Book.Book_id = Book_Copies.Book_id
JOIN Book_authors ON Book.Book_id = Book_authors.Book_id
JOIN Author ON Book_authors.Author_id = Author.Author_id
LEFT JOIN Book_categories ON Book.Book_id = Book_categories.Book_id
LEFT JOIN Category ON Book_categories.Category_id = Category.Category_id
LEFT JOIN Book_keywords ON Book.Book_id = Book_keywords.Book_id
LEFT JOIN Keyword ON Book_keywords.Keyword_id = Keyword.Keyword_id
GROUP BY Book.Book_id, Book_Copies.School_id;

-- QUERY 1
CREATE VIEW IF NOT EXISTS LoansPerMonth AS
SELECT s.Name AS School_Name, YEAR(l.Date_out) AS Loan_Year, MONTH(l.Date_out) AS Loan_Month, COUNT(l.Loan_id) AS Total_Loans
FROM Loan l
JOIN User u ON l.User_id = u.User_id
JOIN School s ON u.School_id = s.School_id
GROUP BY s.School_id, Loan_Year, Loan_Month;

--  QUERY 2.1
CREATE VIEW IF NOT EXISTS CategoryAuthors AS
SELECT C.Category, Group_Concat(A.Name SEPARATOR ', ') AS Authors FROM
Category C
JOIN Book_categories BC ON C.Category_id = BC.Category_id
JOIN Book_authors BA ON BC.Book_id = BA.Book_id
JOIN Author A ON A.Author_id = BA.Author_id
GROUP BY C.Category_id;

-- QUERY 2.2
CREATE VIEW IF NOT EXISTS CategoryTeachers AS
SELECT C.Category, Group_Concat(T.Name SEPARATOR ', ') AS Teachers FROM
Category C
JOIN Book_categories BC ON C.Category_id = BC.Category_id
JOIN Loan L ON BC.Book_id = L.Book_id
JOIN User T ON T.User_id = L.User_id
WHERE T.Usertype = 'Teacher'
AND DATE_ADD(L.Date_Out, INTERVAL 1 YEAR) > CURDATE()
GROUP BY C.Category_id;

-- QUERY 3
CREATE VIEW IF NOT EXISTS YoungTeachers AS
SELECT U.Name AS Teachers, COUNT(*) AS NumBooksBorrowed
FROM User U
JOIN Loan L ON U.User_id = L.User_id
WHERE U.Usertype = 'Teacher' AND U.Age < 40
GROUP BY U.User_id
HAVING COUNT(*) = (
  SELECT COUNT(*) 
  FROM Loan l JOIN User u ON l.User_id = u.User_id
  WHERE u.Usertype = 'Teacher' AND u.Age < 40
  GROUP BY u.User_id 
  ORDER BY COUNT(*) DESC 
  LIMIT 1
);

-- QUERY 4
CREATE VIEW IF NOT EXISTS AuthorWithoutLoans AS
SELECT DISTINCT A.Name AS AuthorName
FROM Author A
EXCEPT
SELECT DISTINCT A.Name AS AuthorName
FROM Author A
JOIN Book_authors BA ON A.Author_id = BA.Author_id
JOIN Loan L ON BA.Book_id = L.Book_id;

-- QUERY 5
CREATE VIEW IF NOT EXISTS Operators20Loans AS
SELECT GROUP_CONCAT(Name SEPARATOR ', ') AS Operators, LoanedBooks FROM (
SELECT OP.Name, COUNT(*) As LoanedBooks
FROM User OP
JOIN User U ON U.School_id = OP.School_id
JOIN Loan L ON L.User_id = U.User_id
WHERE OP.Usertype = 'Library Operator'
  AND DATE_ADD(L.Date_Out, INTERVAL 1 YEAR) > CURDATE()
GROUP BY OP.Name) AS SUBQUERY
WHERE LoanedBooks > 20
GROUP BY LoanedBooks;

-- QUERY 6
CREATE VIEW IF NOT EXISTS Top3pairs AS
SELECT C1.Category AS Category1, C2.Category AS Category2, COUNT(*) AS Borrowings
FROM Loan L
JOIN Book_categories BC1 ON BC1.Book_id = L.Book_id
JOIN Book_categories BC2 ON BC2.Book_id = L.Book_id
JOIN Category C1 ON C1.Category_id = BC1.Category_id
JOIN Category C2 ON C2.Category_id = BC2.Category_id
WHERE C1.Category_id < C2.Category_id
GROUP BY C1.Category, C2.Category
ORDER BY COUNT(*) DESC
LIMIT 3;

-- QUERY 7
CREATE VIEW IF NOT EXISTS AuthorsFewBooks AS
SELECT A.Name AS Authors
FROM Author A
JOIN Book_authors BA ON BA.Author_id = A.Author_id 
GROUP BY A.Author_id
HAVING COUNT(*) + 4 < 
  (SELECT COUNT(*)
   FROM Author A2
   JOIN Book_authors BA2 ON BA2.Author_id = A2.Author_id 
   GROUP BY A2.Author_id
   ORDER BY COUNT(*) DESC
   LIMIT 1);





-- LIB_OP VIEW LOAN REQUESTS
CREATE VIEW IF NOT EXISTS LoanRequests AS
SELECT Loan.Loan_id, Loan.Date_out, Loan.Due_date, Loan.Status, Book_Copies.Copies, User.School_id, User.Name, User.Username, Book.Title
FROM Loan
JOIN User ON User.User_id = Loan.User_id
JOIN Book ON Book.Book_id = Loan.Book_id
JOIN Book_Copies ON Book_Copies.Book_id = Loan.Book_id AND Book_Copies.School_id = User.School_id;

-- LIB_OP VIEW LATE BOOKS
CREATE VIEW IF NOT EXISTS LateLoans AS
SELECT U.Name, DATEDIFF(CURDATE(), L.Due_date) AS DelayDays
FROM User U
JOIN Loan L ON L.User_id = U.User_id
WHERE L.Status = 'Late';

-- LIB_OP VIEW AVERAGE RATING PER BORROWER
CREATE VIEW IF NOT EXISTS AvgBorrower AS
SELECT U.Name AS Borrower, AVG(R.Rating) AS AverageRating
FROM Review R
JOIN User U ON U.User_id = R.User_id
GROUP BY U.User_id
ORDER BY U.Name;

-- LIB_OP VIEW AVERAGE RATING PER CATEGORY
CREATE VIEW IF NOT EXISTS AvgCat AS
SELECT C.Category, AVG(R.Rating) AS AverageRating
FROM Review R
JOIN Book_categories BC ON BC.Book_id = R.Book_id
JOIN Category C ON C.Category_id = BC.Category_id
GROUP BY C.Category_id
ORDER BY C.Category;