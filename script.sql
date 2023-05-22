CREATE TABLE IF NOT EXISTS User (
	User_id INT AUTO_INCREMENT,
    Username VARCHAR(20) NOT NULL,
    Password VARCHAR(20) NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Usertype ENUM("Admin", "Librarian", "Student", "Teacher") NOT NULL,
    PRIMARY KEY(User_id)
);

CREATE TABLE IF NOT EXISTS School (
    School_id INT AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(20) NOT NULL,
    Phone VARCHAR(10) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    Head_id INT NOT NULL,
    Library_op_id INT NOT NULL,
    PRIMARY KEY(School_id),
    FOREIGN KEY(Head_id) REFERENCES User(User_id),
    FOREIGN KEY(Library_op_id) REFERENCES User(User_id),
    CHECK(Email REGEXP ".+@.+(\.com|\.gr)$")
);

CREATE TABLE IF NOT EXISTS Book (
	Book_id INT AUTO_INCREMENT,
    Title VARCHAR(80) NOT NULL,
    Publisher VARCHAR(30) NOT NULL,
    ISBN VARCHAR(13) NOT NULL,
    Pages INT(4),
    Summary VARCHAR(1000),
    Copies INT(2) NOT NULL,
    Image MEDIUMBLOB,
    Language ENUM ('Greek', 'English', 'French', 'German', 'Russian', 'Spanish', 'Italian', 'Chinese'),
    PRIMARY KEY(Book_id),
    CHECK(PAGES BETWEEN 1 AND 9999),
    CHECK(COPIES BETWEEN 1 AND 99),
    CHECK(CHAR_LENGTH(ISBN) = 13)
);

CREATE TABLE IF NOT EXISTS Author (
    Author_id INT AUTO_INCREMENT,
    First_name VARCHAR(20) NOT NULL,
    Last_name VARCHAR(25) NOT NULL,
    PRIMARY KEY(Author_id)
)

CREATE TABLE IF NOT EXISTS Book_authors (
    Book_id INT,
    Author_id INT,
    PRIMARY KEY(Book_id, Author_id),
    FOREIGN KEY Book_id REFERENCES Book(Book_id),
    FOREIGN KEY Author_id REFERENCES Author(Author_id)
)

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
)

CREATE TABLE IF NOT EXISTS Book_categories (
    Book_id INT,
    Category_id INT,
    PRIMARY KEY(Book_id, Category_id),
    FOREIGN KEY Book_id REFERENCES Book(Book_id),
    FOREIGN KEY Category_id REFERENCES Category(Category_id)
)

CREATE TABLE IF NOT EXISTS Keyword (
    Keyword_id INT AUTO_INCREMENT,
    Keyword VARCHAR(30) NOT NULL,
    PRIMARY KEY(Keyword_id)
)

CREATE TABLE IF NOT EXISTS Book_keywords (
    Book_id INT,
    Keyword_id INT,
    PRIMARY KEY(Book_id, Keyword_id),
    FOREIGN KEY Book_id REFERENCES Book(Book_id),
    FOREIGN KEY Keyword_id REFERENCES Keyword(Keyword_id)
)

CREATE INDEX IF NOT EXISTS booksearch_idx
ON Book(Title, Author, Publisher, ISBN);

CREATE TABLE IF NOT EXISTS Loan (
	Loan_id INT,
    Date_out DATE NOT NULL,
    Due_date DATE NOT NULL,
    Return_date DATE NOT NULL,
    Status ENUM("BORROWED", "ON HOLD", "RETURNED", "LATE"),
    Book_id INT,
    User_id INT,
    PRIMARY KEY(Loan_id, Book_id, User_id),
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
CREATE TRIGGER subtract_copies_after_loan
AFTER INSERT ON Loan FOR EACH ROW
UPDATE Book
SET Copies = Copies - 1 WHERE Book_ID = NEW.Book_id;
