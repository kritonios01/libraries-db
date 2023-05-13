CREATE TABLE IF NOT EXISTS User (
	User_id INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(20) NOT NULL,
    Password VARCHAR(20),
    Name VARCHAR(30),
    Usertype VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS School (
    School_id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Phone VARCHAR(10) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Head_id INT NOT NULL,
    Library_op_id INT NOT NULL,
    FOREIGN KEY(Head_id) REFERENCES User(User_id),
    FOREIGN KEY(Library_op_id) REFERENCES User(User_id)
);

-- index?
CREATE TABLE IF NOT EXISTS Book (
	Book_id INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100),
    Publisher VARCHAR(50),
    ISBN INT,
    Author VARCHAR(50),
    Pages INT,
    Summary VARCHAR(100),
    Copies INT,
    Image VARCHAR(20),
    Category VARCHAR(10),
    Language VARCHAR(2),
    Keywords VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS Loan (
	Loan_id INT,
    Book_id INT,
    User_id INT,
    DateOut DATE,
    DueDate DATE,
    ReturnDate DATE,
    Status ENUM("BORROWED", "FREE"),
    PRIMARY KEY(Loan_id, Book_id, User_id),
	FOREIGN KEY(Book_id) REFERENCES Book(Book_id),
    FOREIGN KEY(User_id) REFERENCES User(User_id)
);

CREATE TABLE IF NOT EXISTS Review (
	Review_id INT,
	Book_id INT,
    Rating INT,
    Review VARCHAR(200),
    CHECK (Rating BETWEEN 1 AND 5),
    PRIMARY KEY(Review_id),
    FOREIGN KEY(Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE
);

show tables;