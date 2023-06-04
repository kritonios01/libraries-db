/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Author
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Author` (
  `Author_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Author_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 51 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book` (
  `Book_id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(80) NOT NULL,
  `Publisher` varchar(100) NOT NULL,
  `ISBN` varchar(13) NOT NULL,
  `Pages` int(4) DEFAULT NULL,
  `Summary` varchar(1000) DEFAULT NULL,
  `Image` mediumblob DEFAULT NULL,
  `Language` enum(
  'Greek',
  'English',
  'French',
  'German',
  'Russian',
  'Spanish',
  'Italian',
  'Chinese'
  ) NOT NULL,
  PRIMARY KEY (`Book_id`),
  KEY `booksearch_idx` (`Title`, `ISBN`),
  CONSTRAINT `CONSTRAINT_1` CHECK (
  `Pages` between 1
  and 9999
  ),
  CONSTRAINT `CONSTRAINT_2` CHECK (char_length(`ISBN`) = 13)
) ENGINE = InnoDB AUTO_INCREMENT = 138 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book_Copies
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book_Copies` (
  `Book_id` int(11) NOT NULL,
  `School_id` int(11) NOT NULL,
  `Copies` int(2) NOT NULL,
  PRIMARY KEY (`Book_id`, `School_id`),
  KEY `School_id` (`School_id`),
  CONSTRAINT `book_copies_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `book_copies_ibfk_2` FOREIGN KEY (`School_id`) REFERENCES `School` (`School_id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (
  `Copies` between 0
  and 99
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book_authors
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book_authors` (
  `Book_id` int(11) NOT NULL,
  `Author_id` int(11) NOT NULL,
  PRIMARY KEY (`Book_id`, `Author_id`),
  KEY `Author_id` (`Author_id`),
  CONSTRAINT `book_authors_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `book_authors_ibfk_2` FOREIGN KEY (`Author_id`) REFERENCES `Author` (`Author_id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book_categories
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book_categories` (
  `Book_id` int(11) NOT NULL,
  `Category_id` int(11) NOT NULL,
  PRIMARY KEY (`Book_id`, `Category_id`),
  KEY `Category_id` (`Category_id`),
  CONSTRAINT `book_categories_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `book_categories_ibfk_2` FOREIGN KEY (`Category_id`) REFERENCES `Category` (`Category_id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book_keywords
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book_keywords` (
  `Book_id` int(11) NOT NULL,
  `Keyword_id` int(11) NOT NULL,
  PRIMARY KEY (`Book_id`, `Keyword_id`),
  KEY `Keyword_id` (`Keyword_id`),
  CONSTRAINT `book_keywords_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `book_keywords_ibfk_2` FOREIGN KEY (`Keyword_id`) REFERENCES `Keyword` (`Keyword_id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Category
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Category` (
  `Category_id` int(11) NOT NULL AUTO_INCREMENT,
  `Category` enum(
  'Action and Adventure',
  'Art',
  'Biography',
  'Business and Economics',
  'Comics and Graphic Novels',
  'Computing and Technology',
  'Cookbooks and Food',
  'Crafts and Hobbies',
  'Crime and Mystery',
  'Drama',
  'Education and Teaching',
  'Fantasy',
  'Fiction',
  'Health and Wellness',
  'Historical Fiction',
  'History',
  'Horror',
  'Humor',
  'Inspirational and Motivational',
  'LGBTQ+',
  'Literary Fiction',
  'Music',
  'Parenting and Family',
  'Philosophy',
  'Poetry',
  'Politics and Social Sciences',
  'Religion and Spirituality',
  'Romance',
  'Science',
  'Science Fiction',
  'Self-Help and Personal Development',
  'Sports',
  'Thriller',
  'Travel',
  'True Crime',
  'Western'
  ) NOT NULL,
  PRIMARY KEY (`Category_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 37 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Keyword
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Keyword` (
  `Keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `Keyword` varchar(30) NOT NULL,
  PRIMARY KEY (`Keyword_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Loan
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Loan` (
  `Loan_id` int(11) NOT NULL,
  `Date_out` date NOT NULL,
  `Due_date` date NOT NULL,
  `Return_date` date NOT NULL,
  `Status` enum('BORROWED', 'RETURNED', 'LATE') DEFAULT NULL,
  `Book_id` int(11) NOT NULL,
  `User_id` int(11) NOT NULL,
  PRIMARY KEY (`Loan_id`, `Book_id`, `User_id`),
  KEY `Book_id` (`Book_id`),
  KEY `User_id` (`User_id`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `User` (`User_id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Reservation
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Reservation` (
  `Reservation_id` int(11) NOT NULL,
  `Date_` date NOT NULL,
  `Book_id` int(11) NOT NULL,
  `User_id` int(11) NOT NULL,
  PRIMARY KEY (`Reservation_id`, `Book_id`, `User_id`),
  KEY `Book_id` (`Book_id`),
  KEY `User_id` (`User_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `User` (`User_id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Review
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Review` (
  `Review_id` int(11) NOT NULL,
  `Rating` tinyint(1) NOT NULL,
  `Review` varchar(200) DEFAULT NULL,
  `Book_id` int(11) NOT NULL,
  `User_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`Review_id`, `Book_id`),
  KEY `Book_id` (`Book_id`),
  KEY `User_id` (`User_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `User` (`User_id`) ON DELETE
  SET
  NULL,
  CONSTRAINT `CONSTRAINT_1` CHECK (
    `Rating` between 1
    and 5
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: School
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `School` (
  `School_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `City` varchar(20) NOT NULL,
  `Phone` varchar(10) NOT NULL,
  `Email` varchar(30) NOT NULL,
  PRIMARY KEY (`School_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`Email` regexp '.+@.+(.com|.gr)$')
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: User
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `User` (
  `User_id` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Age` int(11) NOT NULL,
  `Usertype` enum(
  'Admin',
  'Library Operator',
  'Director',
  'Student',
  'Teacher'
  ) NOT NULL,
  `School_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`User_id`),
  UNIQUE KEY `Username` (`Username`),
  KEY `School_id` (`School_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`School_id`) REFERENCES `School` (`School_id`) ON DELETE
  SET
  NULL
) ENGINE = InnoDB AUTO_INCREMENT = 70 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: books_summary
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `books_summary` AS
select
  `book_copies`.`School_id` AS `School_id`,
  `book`.`Title` AS `Title`,
  `book`.`Publisher` AS `Publisher`,
  `book`.`ISBN` AS `ISBN`,
  `book`.`Pages` AS `Pages`,
  `book`.`Summary` AS `Summary`,
  `book`.`Image` AS `Image`,
  `book`.`Language` AS `Language`,
  `book_copies`.`Copies` AS `Copies`,
  group_concat(distinct `author`.`Name` separator ', ') AS `Authors`,
  group_concat(distinct `category`.`Category` separator ', ') AS `Categories`,
  group_concat(distinct `keyword`.`Keyword` separator ', ') AS `Keywords`
from
  (
  (
    (
    (
      (
      (
        (
        `book`
        join `book_copies` on(`book`.`Book_id` = `book_copies`.`Book_id`)
        )
        join `book_authors` on(`book`.`Book_id` = `book_authors`.`Book_id`)
      )
      join `author` on(
        `book_authors`.`Author_id` = `author`.`Author_id`
      )
      )
      join `book_categories` on(`book`.`Book_id` = `book_categories`.`Book_id`)
    )
    join `category` on(
      `book_categories`.`Category_id` = `category`.`Category_id`
    )
    )
    join `book_keywords` on(`book`.`Book_id` = `book_keywords`.`Book_id`)
  )
  join `keyword` on(
    `book_keywords`.`Keyword_id` = `keyword`.`Keyword_id`
  )
  )
group by
  `book`.`Book_id`,
  `book_copies`.`School_id`;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Author
# ------------------------------------------------------------

INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (1, 'Paulo Coelho');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (2, 'Jane Austen');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (3, 'Harper Lee');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (4, 'George Orwell');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (5, 'F. Scott Fitzgerald');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (6, 'Herman Melville');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (7, 'J.D. Salinger');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (8, 'Charlotte Bronte');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (9, 'Penguin Classics');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (10, 'Aldous Huxley');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (11, 'J.R.R. Tolkien');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (12, 'J.K. Rowling');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (13, 'C.S. Lewis');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (14, 'George Orwell');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (15, 'Dan Brown');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (16, 'Margaret Mitchell');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (17, 'Suzanne Collins');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (18, 'John Green');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (19, 'Khaled Hosseini');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (20, 'Paula Hawkins');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (21, 'Stephen King');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (22, 'Oscar Wilde');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (23, 'Emily Bronte');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (24, 'Markus Zusak');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (25, 'James Dashner');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (26, 'Kathryn Stockett');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (27, 'Lois Lowry');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (28, 'Stieg Larsson');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (29, 'Sue Monk Kidd');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (30, 'Alice Walker');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (31, 'Ray Bradbury');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (32, 'Homer');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (33, 'Kurt Vonnegut');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (34, 'Alexandre Dumas');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (35, 'William Golding');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (36, 'Albert Camus');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (37, 'Victor Hugo');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (38, 'Antoine de Saint-Exupery');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (39, 'Gustave Flaubert');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (40, 'Charles Baudelaire');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (41, 'Emile Zola');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (42, 'Voltaire');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (43, 'Stendhal');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (44, 'Pierre Choderlos de Laclos');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (45, 'Alain-Fournier');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (46, 'Guy de Maupassant');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (47, 'Louis-Ferdinand Celine');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (48, 'Jean-Paul Sartre');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (49, 'Francoise Sagan');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (50, 'Jules Verne');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book
# ------------------------------------------------------------

INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    1,
    'The Alchemist',
    'HarperOne',
    '9780062315007',
    208,
    'A story about following your dreams and finding your purpose in life.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    2,
    'Pride and Prejudice',
    'Penguin Books',
    '9780141439518',
    432,
    'A classic romantic novel by Jane Austen.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    3,
    'To Kill a Mockingbird',
    'Harper Perennial',
    '9780060935467',
    336,
    'A powerful story of racial injustice and the loss of innocence.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    4,
    '1984',
    'Signet Classics',
    '9780451524935',
    328,
    'A dystopian novel depicting a totalitarian society ruled by Big Brother.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    5,
    'The Great Gatsby',
    'Scribner',
    '9780743273565',
    180,
    'A tragic love story set in the Jazz Age.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    6,
    'Moby Dick',
    'Penguin Classics',
    '9780142437247',
    720,
    'A novel about a sea captains obsession with hunting a white whale.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    7,
    'The Catcher in the Rye',
    'Little, Brown and Company',
    '9780316769488',
    234,
    'A coming-of-age novel by J.D. Salinger.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    8,
    'Jane Eyre',
    'Penguin Classics',
    '9780141441146',
    624,
    'A Gothic novel by Charlotte Bronte.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    9,
    'Brave New World',
    'Harper Perennial',
    '9780060850524',
    288,
    'A dystopian novel by Aldous Huxley.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    10,
    'The Lord of the Rings',
    'Mariner Books',
    '9780544003415',
    1216,
    'An epic fantasy trilogy by J.R.R. Tolkien.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    11,
    'Harry Potter and the Sorcerers Stone',
    'Scholastic',
    '9780590353427',
    320,
    'The first book in the Harry Potter series by J.K. Rowling.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    12,
    'The Hobbit',
    'Mariner Books',
    '9780547928227',
    400,
    'A fantasy novel by J.R.R. Tolkien.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    13,
    'The Chronicles of Narnia',
    'HarperCollins',
    '9780066238500',
    767,
    'A series of fantasy novels by C.S. Lewis.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    14,
    'Animal Farm',
    'Signet Classics',
    '9780451526342',
    112,
    'A satirical novella by George Orwell.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    15,
    'The Da Vinci Code',
    'Anchor',
    '9780307474278',
    597,
    'A thriller novel by Dan Brown.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    16,
    'Gone with the Wind',
    'Grand Central Publishing',
    '9781451635621',
    960,
    'A historical novel by Margaret Mitchell.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    17,
    'The Hunger Games',
    'Scholastic',
    '9780439023481',
    384,
    'A dystopian novel by Suzanne Collins.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    18,
    'The Fault in Our Stars',
    'Dutton Books',
    '9780525478812',
    313,
    'A young adult novel by John Green.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    19,
    'The Kite Runner',
    'Riverhead Books',
    '9781594631931',
    371,
    'A novel by Khaled Hosseini.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    20,
    'The Girl on the Train',
    'Riverhead Books',
    '9781594634024',
    323,
    'A psychological thriller novel by Paula Hawkins.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    21,
    'The Shining',
    'Anchor',
    '9780345806789',
    688,
    'A horror novel by Stephen King.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    22,
    'The Picture of Dorian Gray',
    'Penguin Classics',
    '9780141439570',
    272,
    'A philosophical novel by Oscar Wilde.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    23,
    'Wuthering Heights',
    'Penguin Classics',
    '9780141439556',
    416,
    'A Gothic novel by Emily Bronte.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    24,
    'The Book Thief',
    'Knopf Books for Young Readers',
    '9780375842207',
    584,
    'A historical novel by Markus Zusak.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    25,
    'The Maze Runner',
    'Delacorte Press',
    '9780385737951',
    400,
    'A young adult dystopian novel by James Dashner.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    26,
    'The Help',
    'Penguin Books',
    '9780143118233',
    544,
    'A novel by Kathryn Stockett.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    27,
    'The Giver',
    'HMH Books for Young Readers',
    '9780544340688',
    240,
    'A young adult dystopian novel by Lois Lowry.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    28,
    'The Girl with the Dragon Tattoo',
    'Vintage Crime/Black Lizard',
    '9780307454546',
    672,
    'A crime thriller novel by Stieg Larsson.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    29,
    'The Lion, the Witch, and the Wardrobe',
    'HarperCollins',
    '9780064404990',
    208,
    'A fantasy novel by C.S. Lewis.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    30,
    'The Secret Life of Bees',
    'Penguin Books',
    '9780142001745',
    336,
    'A novel by Sue Monk Kidd.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    31,
    'The Color Purple',
    'Mariner Books',
    '9780156028356',
    288,
    'A novel by Alice Walker.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    32,
    'Fahrenheit 451',
    'Simon & Schuster',
    '9781451673319',
    249,
    'A dystopian novel by Ray Bradbury.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    33,
    'The Odyssey',
    'Penguin Classics',
    '9780140268867',
    560,
    'An ancient Greek epic poem attributed to Homer.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    34,
    'The Catcher in the Rye',
    'Little, Brown and Company',
    '9780316769488',
    234,
    'A coming-of-age novel by J.D. Salinger.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    35,
    'One Hundred Years of Solitude',
    'Harper Perennial',
    '9780060883287',
    417,
    'A novel by Gabriel Garcia Marquez.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    36,
    'Slaughterhouse-Five',
    'Dial Press',
    '9780385333849',
    275,
    'A science fiction-infused anti-war novel by Kurt Vonnegut.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    37,
    'The Count of Monte Cristo',
    'Penguin Classics',
    '9780140449266',
    1276,
    'An adventure novel by Alexandre Dumas.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    38,
    'Lord of the Flies',
    'Penguin Books',
    '9780140283334',
    224,
    'A novel by William Golding.',
    NULL,
    'English'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    39,
    'LÃ‰tranger',
    'Gallimard',
    '9782070360024',
    186,
    'Un roman de labsurde Ã©crit par Albert Camus.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    40,
    'Les MisÃ©rables',
    'A. Lacroix, Verboeckhoven & Cie',
    '9780140444308',
    1488,
    'Un roman Ã©pique de Victor Hugo sur la vie des personnages pauvres et marginalisÃ©s en France du 19e siÃ¨cle.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    41,
    'Le Petit Prince',
    'Gallimard',
    '9782070612758',
    96,
    'Un conte philosophique de Antoine de Saint-ExupÃ©ry.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    42,
    'Madame Bovary',
    'Michel LÃ©vy FrÃ¨res',
    '9780199535651',
    368,
    'Un roman rÃ©aliste de Gustave Flaubert sur la vie dEmma Bovary.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    43,
    'Les Fleurs du Mal',
    'Auguste Poulet-Malassis et de Broise',
    '9780199535651',
    324,
    'Un recueil de poÃ¨mes de Charles Baudelaire.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    44,
    'Le Comte de Monte-Cristo',
    'PÃ©tion',
    '9781406792194',
    464,
    'Un roman daventures de Alexandre Dumas sur la vengeance.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    45,
    'Les Trois Mousquetaires',
    'Baudry',
    '9781406793269',
    704,
    'Un roman daventures de Alexandre Dumas sur les mousquetaires.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    46,
    'Germinal',
    'Charpentier',
    '9782253004223',
    624,
    'Un roman de Ã‰mile Zola sur la vie des mineurs en France.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    47,
    'Candide',
    'Cramer',
    '9780486266893',
    144,
    'Un conte philosophique de Voltaire.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    48,
    'Le Rouge et le Noir',
    'Levasseur',
    '9782253010699',
    576,
    'Un roman psychologique de Stendhal sur lascension sociale.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    49,
    'Les Liaisons dangereuses',
    'Durand',
    '9780486278957',
    400,
    'Un roman Ã©pistolaire de Pierre Choderlos de Laclos sur les jeux de sÃ©duction.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    50,
    'Le Grand Meaulnes',
    'Fasquelle',
    '9782080703111',
    256,
    'Un roman dinitiation de Alain-Fournier.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    51,
    'La Peste',
    'Gallimard',
    '9782070200610',
    288,
    'Un roman allÃ©gorique de Albert Camus sur une Ã©pidÃ©mie de peste.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    52,
    'Le Horla',
    'Fasquelle',
    '9782253093838',
    112,
    'Un recueil de nouvelles fantastiques de Guy de Maupassant.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    53,
    'Voyage au bout de la nuit',
    'DenoÃ«l et Steele',
    '9782070360284',
    464,
    'Un roman de Louis-Ferdinand CÃ©line sur la condition humaine.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    54,
    'Bel-Ami',
    'Ollendorff',
    '9782080703968',
    432,
    'Un roman rÃ©aliste de Guy de Maupassant sur lascension sociale.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    55,
    'La NausÃ©e',
    'Gallimard',
    '9782070368075',
    240,
    'Un roman existentialiste de Jean-Paul Sartre sur labsurditÃ© de lexistence.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    56,
    'Les Chants de Maldoror',
    'LÃ©on Genonceaux',
    '9782253004575',
    304,
    'Un poÃ¨me en prose de Comte de LautrÃ©amont.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    57,
    'Les Fourmis',
    'Albin Michel',
    '9782226057940',
    352,
    'Un roman de science-fiction de Bernard Werber.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    58,
    'Le Parfum',
    'Fayard',
    '9782253174872',
    318,
    'Un roman de Patrick SÃ¼skind sur un tueur en sÃ©rie obsÃ©dÃ© par les odeurs.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    59,
    'Au Bonheur des Dames',
    'Charpentier',
    '9782253004155',
    496,
    'Un roman rÃ©aliste de Ã‰mile Zola sur les grands magasins.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    60,
    'LAssommoir',
    'Charpentier',
    '9782253004179',
    480,
    'Un roman rÃ©aliste de Ã‰mile Zola sur la vie ouvriÃ¨re Ã  Paris.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    61,
    'Les Enfants Terribles',
    'Gallimard',
    '9782070360802',
    160,
    'Un roman de Jean Cocteau sur une relation toxique entre frÃ¨re et sÅ“ur.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    62,
    'Le Ravissement de Lol V. Stein',
    'Gallimard',
    '9782070368136',
    256,
    'Un roman de Marguerite Duras sur la passion et la perte.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    63,
    'Huis clos',
    'Gallimard',
    '9782070368075',
    160,
    'Une piÃ¨ce de thÃ©Ã¢tre de Jean-Paul Sartre sur lenfer des relations humaines.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    64,
    'Bonjour tristesse',
    'Ã‰ditions du Seuil',
    '9782253004117',
    192,
    'Un roman de FranÃ§oise Sagan sur ladolescence et le dÃ©sir.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    65,
    'Le Tour du monde en quatre-vingts jours',
    'Pierre-Jules Hetzel',
    '9782253004155',
    256,
    'Un roman daventures de Jules Verne sur un voyage autour du monde.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    66,
    'Les Contemplations',
    'Charles Gosselin',
    '9782253010507',
    688,
    'Un recueil de poÃ¨mes de Victor Hugo.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    67,
    'Les RÃªveries du promeneur solitaire',
    'Garnier-Flammarion',
    '9782080711826',
    192,
    'Une Å“uvre autobiographique de Jean-Jacques Rousseau.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    68,
    'Les Paradis artificiels',
    'Michel LÃ©vy FrÃ¨res',
    '9782253083150',
    256,
    'Un essai sur lusage des drogues de Charles Baudelaire.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    69,
    'La PoupÃ©e',
    'Fasquelle',
    '9782253011351',
    144,
    'Un roman de fiction de Pierre LouÃ¿s.',
    NULL,
    'French'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    70,
    'ÎŸ Î‘Î»Ï‡Î·Î¼Î¹ÏƒÏ„Î®Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604537876',
    224,
    'ÎˆÎ½Î± Î²Î¹Î²Î»Î¯Î¿ Ï€Î¿Ï… Î¼Î¹Î»Î¬ÎµÎ¹ Î³Î¹Î± Ï„Î± ÏŒÎ½ÎµÎ¹ÏÎ± ÎºÎ±Î¹ Ï„Î¿Î½ ÎµÎ½Ï„Î¿Ï€Î¹ÏƒÎ¼ÏŒ Ï„Î¿Ï… Ï€ÏÎ±Î³Î¼Î±Ï„Î¹ÎºÎ¿Ï Î½Î¿Î®Î¼Î±Ï„Î¿Ï‚ Ï„Î·Ï‚ Î¶Ï‰Î®Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    71,
    'Î¤Î¿ ÎÎ·ÏƒÎ¯',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ­Î´ÏÎ¿Ï‚',
    '9789600425036',
    456,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î’Î¯ÎºÏ„Î¿Ï Î Î­Î»ÎµÎ²Î¹Î½ Ï€Î¿Ï… Ï€ÎµÏÎ¹Î³ÏÎ¬Ï†ÎµÎ¹ Ï„Î· Î¶Ï‰Î® ÎµÎ½ÏŒÏ‚ Î±Î½Î¸ÏÏŽÏ€Î¿Ï… ÏƒÎµ Î­Î½Î± Î±Ï€Î¿Î¼Î¿Î½Ï‰Î¼Î­Î½Î¿ Î½Î·ÏƒÎ¯.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    72,
    'ÎŸ Î›ÏŒÏÎ´Î¿Ï‚ Ï„Ï‰Î½ ÎœÏ…Î³ÏŽÎ½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601612189',
    256,
    'ÎˆÎ½Î± Î±Î»Î»Î·Î³Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎŸÏ…Î¯Î»Î¹Î±Î¼ Î“ÎºÏŒÎ»Î½Ï„Î¹Î½Î³Îº Î³Î¹Î± Ï„Î·Î½ ÎµÎ¾Î­Î»Î¹Î¾Î· Ï„Î·Ï‚ ÎºÎ¿Î¹Î½Ï‰Î½Î¯Î±Ï‚ ÎºÎ±Î¹ Ï„Î· Ï†ÏÏƒÎ· Ï„Î¿Ï… Î±Î½Î¸ÏÏŽÏ€Î¿Ï….',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    73,
    'ÎŸ Î”ÏÎ¬ÎºÎ¿Ï…Î»Î±Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ»ÎµÎ¹Î´Î¬ÏÎ¹Î¸Î¼Î¿Ï‚',
    '9789602090646',
    432,
    'ÎˆÎ½Î± Î³Î¿Ï„Î¸Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎœÏ€ÏÎ±Î¼ Î£Ï„ÏŒÎºÎµÏ Î³Î¹Î± Ï„Î¿Î½ Î²ÏÎ¹ÎºÏŒÎ»Î±ÎºÎ± Î”ÏÎ¬ÎºÎ¿Ï…Î»Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    74,
    'Î— ÎŸÎ´ÏÏƒÏƒÎµÎ¹Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÏƒÏ„Î¯Î±',
    '9789600515900',
    544,
    'ÎˆÏ€Î¿Ï‚ Ï„Î¿Ï… ÎŒÎ¼Î·ÏÎ¿Ï… Ï€Î¿Ï… Ï€ÎµÏÎ¹Î³ÏÎ¬Ï†ÎµÎ¹ Ï„Î·Î½ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹Î± Ï„Î¿Ï… ÎŸÎ´Ï…ÏƒÏƒÎ­Î± ÎºÎ±Ï„Î¬ Ï„Î¿Î½ ÎµÏ€Î¹ÏƒÏ„ÏÎ¿Ï†Î® Ï„Î¿Ï… Î±Ï€ÏŒ Ï„Î¿Î½ Î¤ÏÏ‰Î¹ÎºÏŒ Ï€ÏŒÎ»ÎµÎ¼Î¿.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    75,
    'ÎŸ Î™Î»Î¹Î¬Î´Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÏƒÏ„Î¯Î±',
    '9789600515603',
    608,
    'ÎˆÏ€Î¿Ï‚ Ï„Î¿Ï… ÎŒÎ¼Î·ÏÎ¿Ï… Ï€Î¿Ï… Ï€ÎµÏÎ¹Î³ÏÎ¬Ï†ÎµÎ¹ Ï„Î¿Î½ Î¤ÏÏ‰Î¹ÎºÏŒ Ï€ÏŒÎ»ÎµÎ¼Î¿ ÎºÎ±Î¹ Ï„Î¹Ï‚ Î¼Î¬Ï‡ÎµÏ‚ Ï„Ï‰Î½ Î±ÏÏ‡Î±Î¯Ï‰Î½ Î·ÏÏŽÏ‰Î½.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    76,
    'Î¤Î± ÎœÎµÏ„Î±Î¼Î¿ÏÏ†Ï‰Î¼Î­Î½Î± Î¤ÎµÏƒÏ„Î¬Î¼ÎµÎ½Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ¬ÎºÏ„Î¿Ï‚',
    '9789603824330',
    224,
    'ÎœÎ¹Î± ÏƒÏ…Î»Î»Î¿Î³Î® Î±Ï€ÏŒ Ï€Î±ÏÎ±Î¼ÏÎ¸Î¹Î± Ï„Î¿Ï… Î‘Î½Ï„ÏŽÎ½Î· Î£Î±Î¼Î±ÏÎ¬.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    77,
    'ÎŸ Î¤Î¶Î¿ÏÎ»Î¹Î¿Ï…Ï‚ ÎšÎ±Î¯ÏƒÎ±Ï',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î’Î¹Î²Î»Î¹Î¿Ï€Ï‰Î»ÎµÎ¯Î¿Î½ Ï„Î·Ï‚ Î•ÏƒÏ„Î¯Î±Ï‚',
    '9789600514453',
    368,
    'ÎˆÎ½Î± Î²Î¹Î¿Î³ÏÎ±Ï†Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎŸÏ…Î¯Î»Î¹Î±Î¼ Î£Î±Î¯Î¾Ï€Î·Ï Î³Î¹Î± Ï„Î¿Î½ Î¡Ï‰Î¼Î±Î¯Î¿ Î·Î³Î­Ï„Î· Î™Î¿ÏÎ»Î¹Î¿ ÎšÎ±Î¯ÏƒÎ±Ï.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    78,
    'Î¤Î± Î Î±Î¹Î´Î¹Î¬ Ï„Î·Ï‚ Î‘Î³Î¬Ï€Î·Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604533540',
    416,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ Î•Î»Î¯Ï† Î£Î±Ï†Î¬Îº Ï€Î¿Ï… ÎµÎ¾ÎµÏÎµÏ…Î½Î¬ Ï„Î·Î½ Î±Î³Î¬Ï€Î· ÎºÎ±Î¹ Ï„Î·Î½ Ï„Î±Ï…Ï„ÏŒÏ„Î·Ï„Î± ÏƒÏ„Î·Î½ Î¤Î¿Ï…ÏÎºÎ¯Î± Ï„Î¿Ï… 20Î¿Ï Î±Î¹ÏŽÎ½Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    79,
    'ÎŸ ÎœÎ¹ÎºÏÏŒÏ‚ Î ÏÎ¯Î³ÎºÎ¹Ï€Î±Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î©ÎºÎµÎ±Î½Î¯Î´Î±',
    '9789604101087',
    96,
    'ÎˆÎ½Î± Ï†Î¹Î»Î¿ÏƒÎ¿Ï†Î¹ÎºÏŒ Ï€Î±ÏÎ±Î¼ÏÎ¸Î¹ Ï„Î¿Ï… Î‘Î½Ï„Î¿Ï…Î¬Î½ Î½Ï„Îµ Î£Î±Î¹Î½Ï„-Î•Î¾Ï…Ï€ÎµÏÏ.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    80,
    'Î¤Î¿ ÎˆÎ³ÎºÎ»Î·Î¼Î± Ï„Î¿Ï… Î›ÏŒÏÎµÎ½Ï‚ Î“Î¹Î±ÏÎ½Ï„Î¯Î½ÎµÏ',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601602821',
    208,
    'ÎˆÎ½Î± Î±ÏƒÏ„Ï…Î½Î¿Î¼Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î†Î³ÎºÎ±Î¸Î± ÎšÏÎ¯ÏƒÏ„Î¹ Î³Î¹Î± Î¼Î¹Î± Î´Î¿Î»Î¿Ï†Î¿Î½Î¯Î± ÏƒÎµ Î¼Î¹Î± Ï€Î¿Î»Ï…Ï„ÎµÎ»Î® Î­Ï€Î±Ï…Î»Î·.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    81,
    'Î— Î£Ï…Î¼Î¼Î¿ÏÎ¯Î± Ï„Ï‰Î½ ÎœÎµÏ„Î±Î½Î±ÏƒÏ„ÏŽÎ½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ­Î´ÏÎ¿Ï‚',
    '9789600427306',
    352,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î’Î¯ÎºÏ„Î¿Ï Î Î­Î»ÎµÎ²Î¹Î½ Î³Î¹Î± Î¼Î¹Î± ÏƒÏ…Î¼Î¼Î¿ÏÎ¯Î± ÎºÎ»ÎµÏ†Ï„ÏŽÎ½ Ï„Î·Ï‚ Î´ÎµÎºÎ±ÎµÏ„Î¯Î±Ï‚ Ï„Î¿Ï… 1920.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    82,
    'ÎŸ ÎšÏŒÎºÎºÎ¹Î½Î¿Ï‚ Î”ÏÎ¬ÎºÎ¿Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601610864',
    464,
    'ÎˆÎ½Î± Î±ÏƒÏ„Ï…Î½Î¿Î¼Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¤ÏŒÎ¼Î±Ï‚ Î§Î¬ÏÎ¹Ï‚ Î³Î¹Î± Ï„Î¿Î½ Î´Î¿Î»Î¿Ï†ÏŒÎ½Î¿ Î£ÎµÏÎ¹Î¬Î» ÎšÎ¯Î»ÎµÏ.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    83,
    'Î¤Î¿ ÎŒÎ½Î¿Î¼Î± Ï„Î¿Ï… Î‘Î½Î­Î¼Î¿Ï…',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604537388',
    464,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î Î¬Ï„ÏÎ¹Îº Î¡ÏŒÎ¸Ï†Î¿Ï…Ï‚ Î³Î¹Î± Î­Î½Î±Î½ Î¬Î½Î´ÏÎ± Ï€Î¿Ï… Î±Î½Î±Î¶Î·Ï„Î¬ Ï„Î·Î½ Î±Î»Î®Î¸ÎµÎ¹Î± Ï€Î¯ÏƒÏ‰ Î±Ï€ÏŒ Ï„Î·Î½ Ï„ÏÎ±Î³Ï‰Î´Î¯Î± Ï€Î¿Ï… Î­Î¶Î·ÏƒÎµ.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    84,
    'Î— Î‘Î»Î¯ÎºÎ· ÏƒÏ„Î· Î§ÏŽÏÎ± Ï„Ï‰Î½ Î˜Î±Ï…Î¼Î¬Ï„Ï‰Î½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î£Î±Î²Î²Î¬Î»Î±Ï‚',
    '9789601637823',
    208,
    'ÎˆÎ½Î± Ï€Î±ÏÎ±Î¼Ï…Î¸Î­Î½Î¹Î¿ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î›Î¹Î¿ÏÎ¹Ï‚ ÎšÎ¬ÏÎ¿Î» Î³Î¹Î± Ï„Î¹Ï‚ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹ÎµÏ‚ Ï„Î·Ï‚ Î‘Î»Î¯ÎºÎ·Ï‚ ÏƒÎµ Î­Î½Î±Î½ Ï€Î±ÏÎ¬Î¾ÎµÎ½Î¿ ÎºÏŒÏƒÎ¼Î¿.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    85,
    'Î¤Î¿ ÎœÎµÎ³Î¬Î»Î¿ Î¤ÎµÎ¯Ï‡Î¿Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÎºÎ¬Ï„Î·',
    '9789604251962',
    432,
    'ÎˆÎ½Î± ÎµÏ€Î¹ÏƒÏ„Î·Î¼Î¿Î½Î¹ÎºÎ¿-Ï†Î±Î½Ï„Î±ÏƒÏ„Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¤Î¶Î¿Î½ Î£Î¼Î¯Î¸ Î³Î¹Î± Î­Î½Î± Î¼ÎµÎ³Î¬Î»Î¿ Ï„ÎµÎ¯Ï‡Î¿Ï‚ Ï€Î¿Ï… Ï€ÏÎ¿ÏƒÏ„Î±Ï„ÎµÏÎµÎ¹ Ï„Î·Î½ Î±Î½Î¸ÏÏ‰Ï€ÏŒÏ„Î·Ï„Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    86,
    'ÎŸ Î¥Ï€Î¿Î²ÏÏÏ‡Î¹Î¿Ï‚ ÎšÏŒÏƒÎ¼Î¿Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î©ÎºÎµÎ±Î½Î¯Î´Î±',
    '9789604103722',
    368,
    'ÎˆÎ½Î± Î±ÏÎ¹ÏƒÏ„Î¿ÏÏÎ³Î·Î¼Î± Ï„Î¿Ï… Î–Î¹Î» Î’Î­ÏÎ½ Î³Î¹Î± Ï„Î·Î½ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹Î± ÎºÎ¬Ï„Ï‰ Î±Ï€ÏŒ Ï„Î·Î½ ÎµÏ€Î¹Ï†Î¬Î½ÎµÎ¹Î± Ï„Ï‰Î½ Ï‰ÎºÎµÎ±Î½ÏŽÎ½.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    87,
    'ÎŸ ÎœÎ¹ÎºÏÏŒÏ‚ Î ÏÎ¯Î³ÎºÎ¹Ï€Î±Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ­Î´ÏÎ¿Ï‚',
    '9789600423001',
    112,
    'ÎˆÎ½Î± Ï†Î¹Î»Î¿ÏƒÎ¿Ï†Î¹ÎºÏŒ Ï€Î±ÏÎ±Î¼ÏÎ¸Î¹ Ï„Î¿Ï… Î‘Î½Ï„Î¿Ï…Î¬Î½ Î½Ï„Îµ Î£Î±Î¹Î½Ï„-Î•Î¾Ï…Ï€ÎµÏÏ.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    88,
    'Î— Î•Ï€Î¹ÏƒÏ„ÏÎ¿Ï†Î® Ï„Î¿Ï… Î£ÎµÏÎ¯Ï†Î·',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604539788',
    352,
    'ÎˆÎ½Î± Î±ÏƒÏ„Ï…Î½Î¿Î¼Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎÏ„Î­Î¹Î²Î¹Î½Ï„ ÎœÏ€Î±Î»Î½Ï„Î¬Ï„ÏƒÎ¹ Î³Î¹Î± Ï„Î¿Î½ Î±Ï€Î¿Ï†Ï…Î»Î±ÎºÎ¹ÏƒÎ¼Î­Î½Î¿ Ï€ÏÏŽÎ·Î½ ÏƒÎµÏÎ¯Ï†Î· Î¤Î¶Î¿Î½ Î¡Î­Î¹Î½Î¿Î»Î½Ï„Ï‚ Ï€Î¿Ï… Î±Î½Î±Î¶Î·Ï„Î¬ Î´Î¹ÎºÎ±Î¯Ï‰ÏƒÎ·.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    89,
    'Î— Î ÏŒÎ»Î· Ï„Ï‰Î½ ÎšÎ±Ï„Î±ÏÎ±Î¼Î­Î½Ï‰Î½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ»ÎµÎ¹Î´Î¬ÏÎ¹Î¸Î¼Î¿Ï‚',
    '9789602090813',
    608,
    'ÎˆÎ½Î± Ï†Î±Î½Ï„Î±ÏƒÏ„Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎšÎ­Î»ÏƒÎµÏ‹ ÎÏ„ÏÎ­Î¹Îº Î³Î¹Î± Î¼Î¹Î± Ï€ÏŒÎ»Î· ÏŒÏ€Î¿Ï… Î¿Î¹ ÎºÎ¬Ï„Î¿Î¹ÎºÎ¿Î¹ ÎµÎ¯Î½Î±Î¹ ÎºÎ±Ï„Î±ÏÎ±Î¼Î­Î½Î¿Î¹ Î½Î± Î¶Î¿Ï…Î½ ÎºÎ¬Ï„Ï‰ Î±Ï€ÏŒ Ï„Î·Î½ Î¸Î¬Î»Î±ÏƒÏƒÎ±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    90,
    'Î¤Î¿ Î£ÏŽÎ¼Î± Ï„Î·Ï‚ Î‘Î¸Î·Î½Î¬Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601611618',
    208,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎœÎ¬Î½Ï„Î±Ï‚ Î¤ÏƒÎ¹ÎºÎ»Î®ÏÎ· Î³Î¹Î± Î¼Î¹Î± Î¿Î¼Î¬Î´Î± Î±ÏÏ‡Î±Î¹Î¿Î»ÏŒÎ³Ï‰Î½ Ï€Î¿Ï… Î±Î½Î±ÎºÎ±Î»ÏÏ€Ï„Î¿Ï…Î½ Î­Î½Î± Î¼Ï…ÏƒÏ„Î®ÏÎ¹Î¿ Î±ÏÏ‡Î±Î¯Î¿ Î¸Î·ÏƒÎ±Ï…ÏÏŒ.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    91,
    'ÎŸ Î•ÏÎ±ÏƒÏ„Î®Ï‚ Ï„Î·Ï‚ Î›Î±Î¯Î´Î·Ï‚ Î¤ÏƒÎ±Ï„Î»Î¯Î½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604541095',
    464,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ Î¡ÏŒÎ¼Ï€Î¹Î½ ÎœÏ€Î­ÏÎ½Ï‚ Î³Î¹Î± Ï„Î· Î¶Ï‰Î® Ï„Î¿Ï… Î¤Î¶ÏŒÏÏ„Î¶ Î¤ÏƒÎ¬ÏÎ»ÎµÏ‚ Î“ÎºÏŒÏÎ½Ï„Î¿Î½ ÎœÏ€Î¬ÏŠÏÎ¿Î½, Ï„Î¿Ï… Î´Î¹Î¬ÏƒÎ·Î¼Î¿Ï… Ï€Î¿Î¹Î·Ï„Î® Ï„Î¿Ï… 19Î¿Ï… Î±Î¹ÏŽÎ½Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    92,
    'ÎŸ ÎÎ±Ï…Î±Î³ÏŒÏ‚ Ï„Ï‰Î½ Î Î±Î³ÎµÏ„ÏŽÎ½Ï‰Î½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ»ÎµÎ¹Î´Î¬ÏÎ¹Î¸Î¼Î¿Ï‚',
    '9789602090721',
    352,
    'ÎˆÎ½Î± Ï€ÎµÏÎ¹Ï€ÎµÏ„ÎµÎ¹ÏŽÎ´ÎµÏ‚ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¤Î¶Î¿ÏÎ»Ï‚ Î’Î­ÏÎ½ Î³Î¹Î± Î­Î½Î± Î½Î±Ï…Î¬Î³Î¹Î¿ ÏƒÎµ Î­Î½Î±Î½ Î±Ï€Î¿Î¼Î¿Î½Ï‰Î¼Î­Î½Î¿ Ï€Î±Î³ÎµÏ„ÏŽÎ½Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    93,
    'ÎŸ ÎœÎ±Î­ÏƒÏ„ÏÎ¿Ï‚ ÎºÎ±Î¹ Î· ÎœÎ±ÏÎ³Î±ÏÎ¯Ï„Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î£Î±Î²Î²Î¬Î»Î±Ï‚',
    '9789601637557',
    512,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎœÎ¹Ï‡Î±Î®Î» ÎœÏ€Î¿Ï…Î»Î³ÎºÎ¬ÎºÏ‰Ï† Î³Î¹Î± Ï„Î¿Î½ ÏƒÏ…Î½Î¬Î½Ï„Î·ÏƒÎ· Ï„Î¿Ï… ÎÏ„Î¹Î¬Î²Î¿Î»Î¿Ï… Î¼Îµ Ï„Î¿Î½ ÎœÎ±Î­ÏƒÏ„ÏÎ¿ ÏƒÏ„Î· ÎœÏŒÏƒÏ‡Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    94,
    'Î— ÎšÎ±Î»ÏÎ²Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÏƒÏ„Î¯Î±',
    '9789600514606',
    256,
    'ÎˆÎ½Î± Ï€Î½ÎµÏ…Î¼Î±Ï„ÏŽÎ´ÎµÏ‚ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î“Î¹Î¬Î½Î½Î· ÎžÎµÎ½Î¬ÎºÎ· Î³Î¹Î± Ï„Î·Î½ Î±Î½Î¸ÏÏŽÏ€Î¹Î½Î· ÏˆÏ…Ï‡Î® ÎºÎ±Î¹ Ï„Î·Î½ Î±Î½Î±Î¶Î®Ï„Î·ÏƒÎ· Ï„Î¿Ï… Î½Î¿Î®Î¼Î±Ï„Î¿Ï‚ Ï„Î·Ï‚ Î¶Ï‰Î®Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    95,
    'ÎŸÎ¹ Î‘Î´ÎµÎ»Ï†Î¿Î¯ ÎšÎ±ÏÎ±Î¼Î±Î¶ÏŒÏ†',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ¬ÎºÏ„Î¿Ï‚',
    '9789603823166',
    672,
    'ÎˆÎ½Î± ÎºÎ»Î±ÏƒÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¦Î¹ÏŒÎ½Ï„Î¿Ï ÎÏ„Î¿ÏƒÏ„Î¿Î³Î¹Î­Ï†ÏƒÎºÎ¹ Î³Î¹Î± Ï„Î¹Ï‚ Ï€Î¿Î»Î¹Ï„Î¹ÎºÎ­Ï‚ ÎºÎ±Î¹ Î·Î¸Î¹ÎºÎ­Ï‚ Î´Î¹Î»Î®Î¼Î¼Î±Ï„Î± Ï„Î¿Ï… ÎÏ„Î¼Î¯Ï„ÏÎ¹ ÎšÎ±ÏÎ±Î¼Î±Î¶ÏŒÏ†.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    96,
    'Î¤Î¿ Î‘Ï†ÎµÎ½Ï„Î¹ÎºÏŒ Ï„Ï‰Î½ ÎœÏ…ÏÎ¼Î·Î³ÎºÎ¹ÏŽÎ½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601610871',
    176,
    'ÎˆÎ½Î± Ï€Î±ÏÎ±Î¼Ï…Î¸Î­Î½Î¹Î¿ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎœÎ±ÏÏÎ¿Ï… Î£ÎµÎ»Î·Î½Î¿Ï†ÏŽÏ„Î· Î³Î¹Î± Ï„Î·Î½ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹Î± ÎµÎ½ÏŒÏ‚ Î±Î³Î¿ÏÎ¹Î¿Ï Ï€Î¿Ï… Î²ÏÎ¯ÏƒÎºÎµÏ„Î±Î¹ ÏƒÏ„Î¿Î½ ÎºÏŒÏƒÎ¼Î¿ Ï„Ï‰Î½ Î¼Ï…ÏÎ¼Î·Î³ÎºÎ¹ÏŽÎ½.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    97,
    'Î¤Î¿ Î‘Î½Ï„Î¯Î¸ÎµÏ„Î¿ Ï„Î·Ï‚ Î‘Î³Î¬Ï€Î·Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604539832',
    352,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎšÎ­Î»ÏƒÎµÏ‹ ÎÏ„ÏÎ­Î¹Îº Î³Î¹Î± Î¼Î¹Î± Î³Ï…Î½Î±Î¯ÎºÎ± Ï€Î¿Ï… Î±Î½Î±ÎºÎ±Î»ÏÏ€Ï„ÎµÎ¹ Ï„Î·Î½ Î±Î»Î®Î¸ÎµÎ¹Î± Î³Î¹Î± Ï„Î·Î½ Î¿Î¹ÎºÎ¿Î³Î­Î½ÎµÎ¹Î¬ Ï„Î·Ï‚ Î¼ÎµÏ„Î¬ Ï„Î¿ Î¸Î¬Î½Î±Ï„Î¿ Ï„Î·Ï‚ Î¼Î·Ï„Î­ÏÎ±Ï‚ Ï„Î·Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    98,
    'Î¤Î¿ Î’Î¹Î²Î»Î¯Î¿ Ï„Ï‰Î½ Î§Î±Î¼Î­Î½Ï‰Î½ Î ÏÎ±Î³Î¼Î¬Ï„Ï‰Î½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ­Î´ÏÎ¿Ï‚',
    '9789600423002',
    456,
    'ÎˆÎ½Î± Ï€Î±ÏÎ±Î¼Ï…Î¸Î­Î½Î¹Î¿ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ Î¤Î¶Î¿Î½ ÎšÏŒÎ½Î½Î¿Î»Ï… Î³Î¹Î± Î­Î½Î± Î±Î³ÏŒÏÎ¹ Ï€Î¿Ï… Î¼Ï€Î±Î¯Î½ÎµÎ¹ ÏƒÏ„Î¿Î½ Î¼Î±Î³Î¹ÎºÏŒ ÎºÏŒÏƒÎ¼Î¿ Ï„Ï‰Î½ Î²Î¹Î²Î»Î¯Ï‰Î½.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    99,
    'ÎŸ Î¤ÎµÎ»ÎµÏ…Ï„Î±Î¯Î¿Ï‚ ÎœÎ¬Î³Î¿Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÎºÎ¬Ï„Î·',
    '9789604253171',
    384,
    'ÎˆÎ½Î± Ï†Î±Î½Ï„Î±ÏƒÏ„Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¤Î¶Î¿Î½ Î“ÎºÏÎ¯ÏƒÎ±Î¼ Î³Î¹Î± Î­Î½Î±Î½ Î¼Î¬Î³Î¿ Ï€Î¿Ï… Ï€ÏÎ¿ÏƒÏ€Î±Î¸ÎµÎ¯ Î½Î± ÏƒÏŽÏƒÎµÎ¹ Ï„Î· Î¼Î±Î³ÎµÎ¯Î± Î±Ï€ÏŒ Ï„Î·Î½ ÎµÎ¾Î±Ï†Î¬Î½Î¹ÏƒÎ·.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    100,
    'Î— ÎšÏŒÎºÎºÎ¹Î½Î· Î ÏÏÎ³Î¿Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601637113',
    336,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î£Î±Î½Ï„ÏÏŒ Î›ÎµÎ¼Ï€Î»Î¬Î½ Î³Î¹Î± Ï„Î·Î½ ÎµÏ€Î±Î½Î¬ÏƒÏ„Î±ÏƒÎ· Ï„Ï‰Î½ ÎœÏ€Î¿Î½Ï„Î¿Ï…Î±Î½ÏŽ ÏƒÏ„Î· Î“Î±Î»Î»Î¯Î± Ï„Î¿Ï… 19Î¿Ï… Î±Î¹ÏŽÎ½Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    101,
    'Î¤Î¿ Î£Ï„Î¯Î³Î¼Î± Ï„Î¿Ï… Î”Î±Î¯Î¼Î¿Î½Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ»ÎµÎ¹Î´Î¬ÏÎ¹Î¸Î¼Î¿Ï‚',
    '9789602090424',
    448,
    'ÎˆÎ½Î± Ï†Î±Î½Ï„Î±ÏƒÏ„Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎˆÏÎ½ÎµÏƒÏ„ ÎšÎ»Î¬Î¹Î½ Î³Î¹Î± Î­Î½Î±Î½ Î½ÎµÎ±ÏÏŒ Ï€Î¿Ï… Î±Î½Î±ÎºÎ±Î»ÏÏ€Ï„ÎµÎ¹ ÏŒÏ„Î¹ Î­Ï‡ÎµÎ¹ ÎµÎ¾Î±Î¹ÏÎµÏ„Î¹ÎºÎ­Ï‚ Î´Ï…Î½Î¬Î¼ÎµÎ¹Ï‚ ÎºÎ±Î¹ Ï€ÏÎ¿Î¿ÏÎ¯Î¶ÎµÏ„Î±Î¹ Î½Î± Î³Î¯Î½ÎµÎ¹ Î¼Î¬Î³Î¿Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    102,
    'ÎŸ Î‘ÏƒÏ„ÎµÏÎ¯Î¾ ÎºÎ±Î¹ Î· Î›Î±Ï„ÏÎ±Î²Î¹Î¬Ï„Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÏƒÏ„Î¯Î±',
    '9789600513364',
    48,
    'ÎˆÎ½Î± ÎºÎ»Î±ÏƒÎ¹ÎºÏŒ ÎºÏŒÎ¼Î¹Îº Ï„Ï‰Î½ Î¡ÎµÎ½Î­ Î“ÎºÎ¿ÏƒÎ¹Î½Î¯ ÎºÎ±Î¹ Î‘Î»Î¼Ï€Î­Ï ÎŸÏ…Î½Ï„ÎµÏÎ¶ÏŒ Î³Î¹Î± Ï„Î¹Ï‚ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹ÎµÏ‚ Ï„Î¿Ï… Î‘ÏƒÏ„ÎµÏÎ¯Î¾ ÎºÎ±Î¹ Ï„Î¿Ï… ÎŸÎ²ÎµÎ»Î¯Î¾ ÏƒÏ„Î·Î½ Î™Ï„Î±Î»Î¯Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    103,
    'ÎŸ Î§Î±Î¼Î­Î½Î¿Ï‚ ÎšÏŒÏƒÎ¼Î¿Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601637045',
    352,
    'ÎˆÎ½Î± Ï€ÎµÏÎ¹Ï€ÎµÏ„ÎµÎ¹ÏŽÎ´ÎµÏ‚ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î†ÏÎ¸Î¿Ï…Ï ÎšÏŒÎ½Î±Î½ ÎÏ„ÏŒÎ¹Î» Î³Î¹Î± Î¼Î¹Î± ÎµÎ¾ÎµÏÎµÏÎ½Î·ÏƒÎ· ÏƒÎµ Î­Î½Î±Î½ Î±Ï€Î¿Î¼Î±ÎºÏÏ…ÏƒÎ¼Î­Î½Î¿ Î²ÏÎ±Î¶Î¹Î»Î¹Î¬Î½Î¹ÎºÎ¿ Ï€Î¿Ï„Î±Î¼ÏŒ.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    104,
    'Î— Î ÏŒÎ»Î· Ï„Î¿Ï… Î‰Î»Î¹Î¿Ï…',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÎºÎ¬Ï„Î·',
    '9789604253188',
    368,
    'ÎˆÎ½Î± ÎµÏ€Î¹ÏƒÏ„Î·Î¼Î¿Î½Î¹ÎºÎ¿-Ï†Î±Î½Ï„Î±ÏƒÏ„Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¡Î­Î¹ ÎœÏ€ÏÎ¬Î½Ï„Î¼Ï€ÎµÏÎ¹ Î³Î¹Î± Î¼Î¹Î± Î¼Ï…ÏƒÏ„Î·ÏÎ¹ÏŽÎ´Î· Ï€ÏŒÎ»Î· Ï€Î¿Ï… Î±ÎºÎ¿Ï…Î»Î¿Ï…Î¸ÎµÎ¯ Ï„Î¿Î½ Î®Î»Î¹Î¿ ÏƒÎµ Î¼Î¹Î± Ï€Î±ÏÎ¬Î»Î»Î·Î»Î· Î´Î¹Î¬ÏƒÏ„Î±ÏƒÎ·.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    105,
    'Î— ÎšÎ¬ÏƒÏ„Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ¬ÎºÏ„Î¿Ï‚',
    '9789603824972',
    640,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎœÎ¬ÏÏ„Î± Î£Ï„Î­Ï†Î±Î½Î¿Î²Î± Î³Î¹Î± Ï„Î·Î½ ÎµÏ€Î¿Ï‡Î® Ï„Î·Ï‚ Î¡Ï‰ÏƒÎ¹ÎºÎ®Ï‚ Î•Ï€Î±Î½Î¬ÏƒÏ„Î±ÏƒÎ·Ï‚ ÎºÎ±Î¹ Ï„Î· Î¶Ï‰Î® Ï„Î·Ï‚ Î±ÏÎ¹ÏƒÏ„Î¿ÎºÏÎ±Ï„Î¹ÎºÎ®Ï‚ Î¿Î¹ÎºÎ¿Î³Î­Î½ÎµÎ¹Î±Ï‚ Î¡Î¿Î¼Î¬Î½Î¿Ï†.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    106,
    'ÎŸ Î ÏŒÎ»ÎµÎ¼Î¿Ï‚ Ï„Ï‰Î½ ÎšÏŒÏƒÎ¼Ï‰Î½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ­Î´ÏÎ¿Ï‚',
    '9789600423170',
    240,
    'ÎˆÎ½Î± ÎµÏ€Î¹ÏƒÏ„Î·Î¼Î¿Î½Î¹ÎºÎ¿-Ï†Î±Î½Ï„Î±ÏƒÏ„Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î§.Î¤. ÎŸÏ…Î­Î»Ï‚ Î³Î¹Î± Ï„Î·Î½ ÎµÎ¹ÏƒÎ²Î¿Î»Î® ÎµÎ¾Ï‰Î³Î®Î¹Î½Ï‰Î½ Ï€Î»Î±ÏƒÎ¼Î¬Ï„Ï‰Î½ ÏƒÏ„Î· Î“Î·.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    107,
    'ÎŸÎ¹ Î ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹ÎµÏ‚ Ï„Î¿Ï… Î¤ÏƒÎ±ÏÎ»Î¹ ÎºÎ±Î¹ Ï„Î¿Ï… Î£Î¬Î¼Ï€Î»Î¹',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604540524',
    336,
    'ÎˆÎ½Î± Ï€Î±Î¹Î´Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¡ÏŒÎ±Î»Î½Ï„ ÎÏ„Î¬Î» ÎµÎ¯Î½Î±Î¹ Î­Î½Î± ÎºÏŒÎ¼Î¹Îº Ï„ÏÏ…Ï†ÎµÏÎ®Ï‚ Ï†Î¹Î»Î¯Î±Ï‚ Î¼ÎµÏ„Î±Î¾Ï ÎµÎ½ÏŒÏ‚ Î±Î³Î¿ÏÎ¹Î¿Ï ÎºÎ±Î¹ ÎµÎ½ÏŒÏ‚ ÎºÎ¿Ï…Î½ÎµÎ»Î¹Î¿Ï.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    108,
    'ÎŸ Î£Ï„ÏÎ±Ï„Î·Î³ÏŒÏ‚ Ï„Ï‰Î½ Î£ÎºÎ¹ÏŽÎ½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ»ÎµÎ¹Î´Î¬ÏÎ¹Î¸Î¼Î¿Ï‚',
    '9789602090462',
    544,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î–Î®Î½Ï‰Î½Î± Î£Î¹Î±Î»Î­Î± Î³Î¹Î± Ï„Î· Î¶Ï‰Î® ÎºÎ±Î¹ Ï„Î·Î½ Ï€Î¿Î»ÎµÎ¼Î¹ÎºÎ® Ï€Î¿ÏÎµÎ¯Î± Ï„Î¿Ï… Î‘Î»Î­Î¾Î±Î½Î´ÏÎ¿Ï… Ï„Î¿Ï… ÎœÎ±ÎºÎµÎ´ÏŒÎ½Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    109,
    'ÎŸÎ¹ Î ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹ÎµÏ‚ Ï„Î¿Ï… Î¤Î¿Î¼ Î£ÏŽÎ³Î¹ÎµÏ',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601638684',
    320,
    'ÎˆÎ½Î± ÎºÎ»Î±ÏƒÎ¹ÎºÏŒ Ï€Î±Î¹Î´Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎœÎ±ÏÎº Î¤Î¿Ï…Î±Î¯Î½ Î³Î¹Î± Ï„Î¹Ï‚ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹ÎµÏ‚ Ï„Î¿Ï… Î±Î³Î¿ÏÎ¹Î¿Ï Î¤Î¿Î¼ Î£ÏŽÎ³Î¹ÎµÏ ÏƒÏ„Î¿Î½ Î¼Î¹ÏƒÎ·Ï„ÏŒ Ï„Î¿Ï… Î¸ÎµÎ¯Î¿.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    110,
    'ÎŸ Î Î¿ÏÏ„ÏÎ±Î¯Ï„Î¿ Ï„Î¿Ï… ÎÏ„ÏŒÏÎ¹Î±Î½ Î“ÎºÏÎ­Ï…',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÏƒÏ„Î¯Î±',
    '9789600514576',
    352,
    'ÎˆÎ½Î± Ï†Î¹Î»Î¿ÏƒÎ¿Ï†Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎŒÏƒÎºÎ±Ï ÎŸÏ…Î¬Î¹Î»Î½Ï„ Î³Î¹Î± Ï„Î¿Î½ Î½Î­Î¿ Î±ÏÎ¹ÏƒÏ„Î¿ÎºÏÎ¬Ï„Î· ÎÏ„ÏŒÏÎ¹Î±Î½ Î“ÎºÏÎ­Ï… ÎºÎ±Î¹ Ï„Î·Î½ Î±Ï€ÎµÎ»ÎµÏ…Î¸Î­ÏÏ‰ÏƒÎ® Ï„Î¿Ï… Î¼Î­ÏƒÏ‰ Ï„Î·Ï‚ Ï„Î­Ï‡Î½Î·Ï‚ ÎºÎ±Î¹ Ï„Î·Ï‚ Î±Î¹ÏƒÎ¸Î·Ï„Î¹ÎºÎ®Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    111,
    'Î¤Î¿ ÎÎ·ÏƒÎ¯ Ï„Î¿Ï… Î˜Î·ÏƒÎ±Ï…ÏÎ¿Ï',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÎºÎ¬Ï„Î·',
    '9789604253140',
    320,
    'ÎˆÎ½Î± Ï€ÎµÏÎ¹Ï€ÎµÏ„ÎµÎ¹ÏŽÎ´ÎµÏ‚ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¡ÏŒÎ¼Ï€ÎµÏÏ„ Î›Î¿ÏÎ¹Ï‚ Î£Ï„Î¯Î²ÎµÎ½ÏƒÎ¿Î½ Î³Î¹Î± Ï„Î¿Î½ Î½ÎµÎ±ÏÏŒ Î¤Î¶Î¹Î¼ Î§ÏŒÎºÎ¹Î½Ï‚ ÎºÎ±Î¹ Ï„Î·Î½ Î±Î½Î±Î¶Î®Ï„Î·ÏƒÎ® Ï„Î¿Ï… Î³Î¹Î± Î­Î½Î±Î½ Î¸Î·ÏƒÎ±Ï…ÏÏŒ ÏƒÎµ Î­Î½Î± Î±Ï€Î¿Î¼Î±ÎºÏÏ…ÏƒÎ¼Î­Î½Î¿ Î½Î·ÏƒÎ¯.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    112,
    'Î— ÎœÏ…ÏƒÏ„Î·ÏÎ¹ÏŽÎ´Î·Ï‚ Î¥Ï€ÏŒÎ¸ÎµÏƒÎ· Ï„Î¿Ï… Î£Ï„ÏÎ¾',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ»ÎµÎ¹Î´Î¬ÏÎ¹Î¸Î¼Î¿Ï‚',
    '9789602090486',
    416,
    'ÎˆÎ½Î± Î±ÏƒÏ„Ï…Î½Î¿Î¼Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ Î‘Î³ÎºÎ¬Î¸Î± ÎšÏÎ¯ÏƒÏ„Î¹ Î³Î¹Î± Ï„Î¿Î½ Î´Î¹Î¬ÏƒÎ·Î¼Î¿ Î½Ï„ÎµÏ„Î­ÎºÏ„Î¹Î² Î•ÏÎºÎ¹Î¿ÏÎ» Î Î¿Ï…Î±ÏÏŒ ÎºÎ±Î¹ Ï„Î·Î½ ÎµÎ¾Î¹Ï‡Î½Î¯Î±ÏƒÎ· Î¼Î¹Î±Ï‚ Î¼Ï…ÏƒÏ„Î·ÏÎ¹ÏŽÎ´Î¿Ï…Ï‚ Î´Î¿Î»Î¿Ï†Î¿Î½Î¯Î±Ï‚ ÏƒÎµ Î¼Î¹Î± Î±Ï€Î¿Î¼Î¿Î½Ï‰Î¼Î­Î½Î· Î­Ï€Î±Ï…Î»Î·.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    113,
    'Î¤Î¿ ÎœÏ…ÏƒÏ„Î¹ÎºÏŒ Ï„Î·Ï‚ Î ÏÎ¿Î´Î¿ÏƒÎ¯Î±Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604536381',
    480,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎšÎ±Ï„ÏÎ¯Î½ ÎÏ„ÎµÎ»Î¬ÏÎ¹ Î³Î¹Î± Ï„Î·Î½ ÎµÏ€Î¿Ï‡Î® Ï„Î·Ï‚ Î“Î±Î»Î»Î¹ÎºÎ®Ï‚ Î•Ï€Î±Î½Î¬ÏƒÏ„Î±ÏƒÎ·Ï‚ ÎºÎ±Î¹ Ï„Î·Î½ Î±Ï€Î¿ÎºÎ¬Î»Ï…ÏˆÎ· ÎµÎ½ÏŒÏ‚ Î¼Ï…ÏƒÏ„Î¹ÎºÎ¿Ï Ï€Î¿Ï… Î¼Ï€Î¿ÏÎµÎ¯ Î½Î± Î±Î½Î±Ï„ÏÎ­ÏˆÎµÎ¹ Ï„Î·Î½ Ï€Î¿Î»Î¹Ï„Î¹ÎºÎ® ÎºÎ±Ï„Î¬ÏƒÏ„Î±ÏƒÎ·.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    114,
    'ÎŸÎ¹ Î ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹ÎµÏ‚ Ï„Î¿Ï… Î§Î¬ÎºÎ»ÎµÎ¼Ï€ÎµÏÏ… Î¦Î¹Î½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601638721',
    368,
    'ÎˆÎ½Î± ÎºÎ»Î±ÏƒÎ¹ÎºÏŒ Ï€Î±Î¹Î´Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎœÎ±ÏÎº Î¤Î¿Ï…Î±Î¯Î½ Î³Î¹Î± Ï„Î¹Ï‚ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹ÎµÏ‚ Ï„Î¿Ï… Î±Î³Î¿ÏÎ¹Î¿Ï Î§Î¬ÎºÎ»ÎµÎ¼Ï€ÎµÏÏ… Î¦Î¹Î½ ÎºÎ±Ï„Î¬ Ï„Î· Î´Î¹Î¬ÏÎºÎµÎ¹Î± Ï„Î¿Ï… Ï„Î±Î¾Î¹Î´Î¹Î¿Ï Ï„Î¿Ï… ÎºÎ±Ï„Î¬ Î¼Î®ÎºÎ¿Ï‚ Ï„Î¿Ï… Ï€Î¿Ï„Î±Î¼Î¿Ï ÎœÎ¹ÏƒÎ¹ÏƒÎ¹Ï€Î®.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    115,
    'ÎŸÎ¹ Î£Ï„Î±Ï‡Ï„Î¿Ï€Î¿ÏÏ„ÎµÏ‚ Î ÎµÎ¸ÎµÏÎ­Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÏƒÏ„Î¯Î±',
    '9789600513777',
    336,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎœÎ¬ÏÎ¹Î±Ï‚ Î£Ï„Î­Ï†Î±Î½Î¿Ï… Î³Î¹Î± Î¼Î¹Î± Î¿Î¼Î¬Î´Î± Î³Ï…Î½Î±Î¹ÎºÏŽÎ½ Ï€Î¿Ï… Î±Î½Î±Î¶Î·Ï„Î¿ÏÎ½ Ï„Î·Î½ ÎµÏ…Ï„Ï…Ï‡Î¯Î± ÎºÎ±Î¹ Ï„Î·Î½ Î±Ï…Ï„Î¿Ï€ÏÎ±Î³Î¼Î¬Ï„Ï‰ÏƒÎ® Ï„Î¿Ï…Ï‚ Î¼ÎµÏ„Î¬ Ï„Î¿ Î³Î¬Î¼Î¿.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    116,
    'Î— Î ÎµÏÎ¯Ï€Ï„Ï‰ÏƒÎ· Ï„Î¿Ï… Î¥Ï€Î¿Î´Î¹ÎºÎ±ÏƒÏ„Î® Î¦Î¿Î»Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ­Î´ÏÎ¿Ï‚',
    '9789600423125',
    416,
    'ÎˆÎ½Î± Î±ÏƒÏ„Ï…Î½Î¿Î¼Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¤Î¶Î¿Î½ Î“ÎºÏÎ¯ÏƒÎ±Î¼ Î³Î¹Î± Ï„Î¿Î½ Î½Ï„ÎµÏ„Î­ÎºÏ„Î¹Î² Î†Î»ÎµÎ¾ ÎšÏÎ¿Ï‚ ÎºÎ±Î¹ Ï„Î·Î½ Î±Î½Î±ÎºÎ¬Î»Ï…ÏˆÎ· Ï„Î·Ï‚ Î±Î»Î®Î¸ÎµÎ¹Î±Ï‚ Ï€Î¯ÏƒÏ‰ Î±Ï€ÏŒ Î¼Î¹Î± Ï€ÎµÏÎ¯Ï€Î»Î¿ÎºÎ· Ï…Ï€ÏŒÎ¸ÎµÏƒÎ· Î´Î¿Î»Î¿Ï†Î¿Î½Î¯Î±Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    117,
    'ÎŸ Î¤ÏÏ€Î¿Ï‚ Ï„Î·Ï‚ ÎšÏ…ÏÎ¹Î±ÎºÎ®Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601638240',
    336,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎÎ¯ÎºÎ¿Ï… Î‘Î¸Î±Î½Î±ÏƒÎ¯Î¿Ï… Î³Î¹Î± Î¼Î¹Î± Î´Î·Î¼Î¿ÏƒÎ¹Î¿Î³ÏÎ¬Ï†Î¿ Ï€Î¿Ï… Î±Ï€Î¿ÎºÎ±Î»ÏÏ€Ï„ÎµÎ¹ Î­Î½Î± ÏƒÎºÎ¬Î½Î´Î±Î»Î¿ ÏƒÏ„Î¿Î½ ÎºÏ…ÏÎ¹Î±ÎºÎ¬Ï„Î¹ÎºÎ¿ Ï„ÏÏ€Î¿ ÎºÎ±Î¹ Î²ÏÎ¯ÏƒÎºÎµÏ„Î±Î¹ Î±Î½Ï„Î¹Î¼Î­Ï„Ï‰Ï€Î· Î¼Îµ Ï„Î¹Ï‚ ÏƒÏ…Î½Î­Ï€ÎµÎ¹Î­Ï‚ Ï„Î¿Ï….',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    118,
    'ÎŸ ÎšÏÏÎ¹Î¿Ï‚ ÎÏŒÏÎ¹Ï‚ Î‘Î»Î»Î¬Î¶ÎµÎ¹ Î¤ÏÎ­Î½Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604536992',
    272,
    'ÎˆÎ½Î± Î±ÏƒÏ„Ï…Î½Î¿Î¼Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎšÏÎ¯ÏƒÏ„Î¿Ï†ÎµÏ Î™ÏƒÎ­ÏÎ³Î¿Ï…Î½Ï„ Î³Î¹Î± Ï„Î¿Î½ Î½Ï„ÎµÏ„Î­ÎºÏ„Î¹Î² Î“Î¿Ï…Î¯Î» ÎœÏ€Î¬Î½Ï„ÎµÏ, Ï€Î¿Ï… Ï€ÏÎ¿ÏƒÏ€Î±Î¸ÎµÎ¯ Î½Î± Î»ÏÏƒÎµÎ¹ Î¼Î¹Î± Ï…Ï€ÏŒÎ¸ÎµÏƒÎ· Î±Ï€Î±Î³Ï‰Î³Î®Ï‚ ÏƒÎµ Î­Î½Î± ÎµÎºÎºÎ»Î·ÏƒÎ¬ÎºÎ¹ Ï„Î·Ï‚ ÎµÎ¾Î¿Ï‡Î®Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    119,
    'Î— Î Î±ÏÎ¬Î´Î¿ÏƒÎ· Ï„Î·Ï‚ Î‘Î½Ï„Î¹Î³ÏŒÎ½Î·Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ»ÎµÎ¹Î´Î¬ÏÎ¹Î¸Î¼Î¿Ï‚',
    '9789602090431',
    480,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎœÎ±Î½ÏŒÎ»Î· Î“Î»Î­Î¶Î¿Ï… Î³Î¹Î± Ï„Î·Î½ Î±Î½Ï„Î¯ÏƒÏ„Î±ÏƒÎ· ÎºÎ±Î¹ Ï„Î· Î¶Ï‰Î® Ï„Î·Ï‚ Î‘Î½Ï„Î¹Î³ÏŒÎ½Î·Ï‚ ÎšÎ±Î»Î»Î­ÏÎ³Î· ÎºÎ±Ï„Î¬ Ï„Î· Î´Î¹Î¬ÏÎºÎµÎ¹Î± Ï„Î·Ï‚ ÎºÎ±Ï„Î¿Ï‡Î®Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    120,
    'ÎŸ ÎœÎµÎ³Î¬Î»Î¿Ï‚ Î¦Î¹Î»ÏŒÏƒÎ¿Ï†Î¿Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÎºÎ¬Ï„Î·',
    '9789604253034',
    288,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎˆÏ†Î·Ï‚ ÎœÎ¹Ï‡Î±Î·Î»Î¯Î´Î¿Ï… Î³Î¹Î± Ï„Î· Î¶Ï‰Î® ÎºÎ±Î¹ Ï„Î· Ï†Î¹Î»Î¿ÏƒÎ¿Ï†Î¯Î± Ï„Î¿Ï… Î£Ï‰ÎºÏÎ¬Ï„Î·, ÎºÎ±Î¸ÏŽÏ‚ Î±Ï…Ï„Î­Ï‚ ÎµÎºÏ„Ï…Î»Î¯ÏƒÏƒÎ¿Î½Ï„Î±Î¹ Î¼Î­ÏƒÎ± Î±Ï€ÏŒ Ï„Î·Î½ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹Î± ÎµÎ½ÏŒÏ‚ Î½ÎµÎ±ÏÎ¿Ï Î±Î³Î¿ÏÎ¹Î¿Ï.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    121,
    'ÎŸ ÎÎ±Ï…Ï„Î¹ÎºÏŒÏ‚ Î¥Ï€ÏŒÎ»Î¿Ï‡Î±Î³ÏŒÏ‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601638660',
    352,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î Î¬Ï„ÏÎ¹Îº ÎŸ ÎœÏ€ÏÎ¬Î¹Î±Î½ Î³Î¹Î± Ï„Î¿Î½ Î½Î±Ï…Ï„Î¹ÎºÏŒ Ï…Ï€ÏŒÎ»Î¿Ï‡Î±Î³ÏŒ Î¤Î¶Î±Îº ÎŸ ÎœÏ€ÏÎ¬Î¹Î±Î½ ÎºÎ±Î¹ Ï„Î¹Ï‚ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹Î­Ï‚ Ï„Î¿Ï… ÏƒÏ„Î± ÎºÏÎ¼Î±Ï„Î± Ï„Î¿Ï… Î‘Ï„Î»Î±Î½Ï„Î¹ÎºÎ¿Ï.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    122,
    'ÎŸÎ¹ Î ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹ÎµÏ‚ Ï„Î¿Ï… Î§Î¬ÏÎ¹ Î ÏŒÏ„ÎµÏ',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÏƒÏ„Î¯Î±',
    '9789600514644',
    320,
    'ÎˆÎ½Î± Ï†Î±Î½Ï„Î±ÏƒÏ„Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ Î¤Î¶.Îš. Î¡ÏŒÎ¿Ï…Î»Î¹Î½Î³Îº Î³Î¹Î± Ï„Î¿Î½ Î¼Î±Î³Î¹ÎºÏŒ ÎºÏŒÏƒÎ¼Î¿ Ï„Î¿Ï… Î§Î¬ÏÎ¹ Î ÏŒÏ„ÎµÏ ÎºÎ±Î¹ Ï„Î¹Ï‚ Ï€ÎµÏÎ¹Ï€Î­Ï„ÎµÎ¹Î­Ï‚ Ï„Î¿Ï… ÏƒÏ„Î¿ Î§ÏŒÎ³ÎºÎ¿Ï…Î±ÏÏ„Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    123,
    'Î¤Î¿ Î£Ï„Î¿Î¯Ï‡Î·Î¼Î± Ï„Î¿Ï… Î”Î¹ÎºÎ±ÏƒÏ„Î®',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ­Î´ÏÎ¿Ï‚',
    '9789600423064',
    384,
    'ÎˆÎ½Î± Î±ÏƒÏ„Ï…Î½Î¿Î¼Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎœÎ¯ÎºÎ±ÎµÎ» ÎšÎ¿Î½Î­Î½ Î³Î¹Î± Ï„Î¿Î½ Î´Î¹ÎºÎ·Î³ÏŒÏÎ¿ ÎœÎ¬Î¹ÎºÎ» Î§ÏŒÎ»Î¼Ï€ÎµÏÎ³Îº ÎºÎ±Î¹ Ï„Î·Î½ Î±Ï€Î¿Î´Î¿ÎºÎ¹Î¼Î±ÏƒÎ¯Î± ÎµÎ½ÏŒÏ‚ Ï†ÏŒÎ½Î¿Ï… Ï€Î¿Ï… Î­Ï‡ÎµÎ¹ ÎµÎ¼Ï€Î»Î±ÎºÎµÎ¯ Î¼Î¹Î± ÎºÎ¿Î¼Î¼Î­Î½Î· Ï‡ÎµÎ¹Ï.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    124,
    'ÎŸÎ¹ Î§Î¿ÏÎµÏ…Ï„Î­Ï‚ Ï„Î¿Ï… ÎœÏ€Î±Î»Î­Ï„Î¿Ï…',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604536251',
    352,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ Î’Î¯ÎºÏ…Ï‚ ÎœÎ±ÏÎºÎ¿Ï€Î¿ÏÎ»Î¿Ï… Î³Î¹Î± Î¼Î¹Î± Î¿Î¼Î¬Î´Î± Ï‡Î¿ÏÎµÏ…Ï„ÏŽÎ½ ÏƒÎµ Î­Î½Î± Î¸Î­Î±Ï„ÏÎ¿ Ï„Î¿Ï… Î¼Ï€Î±Î»Î­Ï„Î¿Ï… ÎºÎ±Î¹ Ï„Î¹Ï‚ Ï€ÏÎ¿ÏƒÏ€Î¬Î¸ÎµÎ¹Î­Ï‚ Ï„Î¿Ï…Ï‚ Î½Î± ÎµÏ€Î¹Î²Î¹ÏŽÏƒÎ¿Ï…Î½ ÎºÎ±Î¹ Î½Î± ÎµÎºÏ€Î»Î·ÏÏŽÏƒÎ¿Ï…Î½ Ï„Î± ÏŒÎ½ÎµÎ¹ÏÎ¬ Ï„Î¿Ï…Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    125,
    'ÎŸ Î‘Î½ÎµÎºÏ€Î»Î®ÏÏ‰Ï„Î¿Ï‚ ÎˆÏÏ‰Ï„Î±Ï‚ Ï„Î·Ï‚ Î£Î±ÏÎ»ÏŒÏ„',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601638646',
    384,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎœÎ±ÏÎ¯Î±Ï‚ Î¤Î¿Î»Î¿ÏÏƒÎ· Î³Î¹Î± Î¼Î¹Î± Î³Ï…Î½Î±Î¯ÎºÎ± Ï€Î¿Ï… Î±Î½Î±Î¶Î·Ï„Î¬ Ï„Î¿Î½ Î±Î½ÎµÎºÏ€Î»Î®ÏÏ‰Ï„Î¿ Î­ÏÏ‰Ï„Î± ÎºÎ±Î¹ Ï„Î·Î½ Î±Ï…Ï„Î¿Ï€ÏÎ±Î³Î¼Î¬Ï„Ï‰ÏƒÎ® Ï„Î·Ï‚ Î¼Î­ÏƒÎ± Î±Ï€ÏŒ Ï„Î¹Ï‚ ÏƒÏ‡Î­ÏƒÎµÎ¹Ï‚ Ï„Î·Ï‚ Î¼Îµ Ï„Î¿Ï…Ï‚ Î¬Î½Ï„ÏÎµÏ‚ ÏƒÏ„Î· Î¶Ï‰Î® Ï„Î·Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    126,
    'ÎŸ Î¦Î¬Î½Ï„Î±ÏƒÎ¼Î± Ï„Î·Ï‚ ÎŒÏ€ÎµÏÎ±Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÎºÎ¬Ï„Î·',
    '9789604253492',
    320,
    'ÎˆÎ½Î± ÏÎ¿Î¼Î±Î½Ï„Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î“ÎºÎ±ÏƒÏ„ÏŒÎ½ Î›ÎµÏÎ¿Ï Î³Î¹Î± Ï„Î¿ Î¼Ï…ÏƒÏ„Î·ÏÎ¹ÏŽÎ´ÎµÏ‚ Ï†Î¬Î½Ï„Î±ÏƒÎ¼Î± Ï€Î¿Ï… ÎºÎ±Ï„Î¿Î¹ÎºÎµÎ¯ ÏƒÏ„Î·Î½ ÏŒÏ€ÎµÏÎ± Ï„Î¿Ï… Î Î±ÏÎ¹ÏƒÎ¹Î¿Ï ÎºÎ±Î¹ Ï„Î· ÏƒÏ‡Î­ÏƒÎ· Ï„Î¿Ï… Î¼Îµ Î¼Î¹Î± Î½ÎµÎ±ÏÎ® Ï„ÏÎ±Î³Î¿Ï…Î´Î¯ÏƒÏ„ÏÎ¹Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    127,
    'ÎŸ Î‘Î¼ÎµÏÎ¹ÎºÎ¬Î½Î¿Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ»ÎµÎ¹Î´Î¬ÏÎ¹Î¸Î¼Î¿Ï‚',
    '9789602091278',
    400,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎœÎ¬ÏÏ„Î¹Î½ ÎšÏÎ¿Ï…Ï‚ Î³Î¹Î± Ï„Î¿Î½ Î¡ÏŒÎ¼Ï€ÎµÏÏ„ ÎÏ„Îµ Î›Î± Î¡ÏŒÏƒ, Î­Î½Î±Î½ Î‘Î¼ÎµÏÎ¹ÎºÎ±Î½ÏŒ Ï€Î¿Ï… Î¼ÎµÏ„Î±ÎºÎ¿Î¼Î¯Î¶ÎµÎ¹ ÏƒÏ„Î· Î“Î±Î»Î»Î¯Î± ÎºÎ±Î¹ ÎµÎ¼Ï€Î»Î­ÎºÎµÏ„Î±Î¹ ÏƒÎµ Î¼Î¹Î± ÎµÏ€Î±Î½Î±ÏƒÏ„Î±Ï„Î¹ÎºÎ® Î¿ÏÎ³Î¬Î½Ï‰ÏƒÎ·.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    128,
    'ÎŸÎ¹ Î‘Î¸Î¬Î½Î±Ï„Î¿Î¹ ÎˆÏÏ‰Ï„ÎµÏ‚ Ï„Î·Ï‚ Î‘Î»ÎµÎ¾Î¯Î±Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601638523',
    336,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ Î‘Î»Î¯ÎºÎ·Ï‚ ÎœÎ¹Î½Ï„ Î¡Î±Î¿Ï…Ï† Î³Î¹Î± Ï„Î·Î½ Î‘Î»ÎµÎ¾Î¯Î±, Î¼Î¹Î± Î½ÎµÎ±ÏÎ® Î³Ï…Î½Î±Î¯ÎºÎ± Ï€Î¿Ï… Î±Î½Î±Î¶Î·Ï„Î¬ Ï„Î¿Î½ Î­ÏÏ‰Ï„Î± ÎºÎ±Î¹ Ï„Î·Î½ Î±Ï…Ï„Î¿Ï€ÏÎ±Î³Î¼Î¬Ï„Ï‰ÏƒÎ® Ï„Î·Ï‚ ÏƒÏ„Î·Î½ ÎšÏ‰Î½ÏƒÏ„Î±Î½Ï„Î¹Î½Î¿ÏÏ€Î¿Î»Î· Ï„Î¿Ï… 19Î¿Ï… Î±Î¹ÏŽÎ½Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    129,
    'Î— Î•ÎºÎ´Î¯ÎºÎ·ÏƒÎ· Ï„Î¿Ï… ÎœÏŒÎ½Ï„Îµ ÎšÏÎ¯ÏƒÏ„Î¿',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÏƒÏ„Î¯Î±',
    '9789600511896',
    624,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î‘Î»ÎµÎ¾Î¬Î½Ï„Ï ÎÏ„Î¹Î¼Î¬ Î³Î¹Î± Ï„Î¿Î½ ÎˆÎ½Ï„Î¼Î¿Î½Ï„ ÎÏ„Î±Î½Ï„Î­Ï‚, Ï€Î¿Ï… ÎµÏ€Î¹ÏƒÏ„ÏÎ­Ï†ÎµÎ¹ Î±Ï€ÏŒ Ï„Î¿Î½ Î¸Î¬Î½Î±Ï„Î¿ Î³Î¹Î± Î½Î± ÎµÎºÎ´Î¹ÎºÎ·Î¸ÎµÎ¯ ÏŒÏƒÎ¿Ï…Ï‚ Ï„Î¿Ï… Î­ÎºÎ±Î½Î±Î½ ÎºÎ±ÎºÏŒ.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    130,
    'Î¤Î¿ Î‘Ï€Î±Î³Î¿ÏÎµÏ…Î¼Î­Î½Î¿ Î’Î¹Î²Î»Î¯Î¿',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601638530',
    320,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎÏ„ÏŒÎ½Î±Î»Î½Ï„ Î¡Î­Î¹ Î³Î¹Î± Î­Î½Î±Î½ Î¼Ï…ÏƒÏ„Î·ÏÎ¹ÏŽÎ´Î· ÏƒÏ…Î³Î³ÏÎ±Ï†Î­Î± ÎºÎ±Î¹ Ï„Î¿ Î±Ï€Î±Î³Î¿ÏÎµÏ…Î¼Î­Î½Î¿ Î²Î¹Î²Î»Î¯Î¿ Ï€Î¿Ï… Î±Ï€Î¿ÎºÎ±Î»ÏÏ€Ï„ÎµÎ¹ Î¼Ï…ÏƒÏ„Î¹ÎºÎ¬ ÎºÎ±Î¹ ÏƒÎºÎ¿Ï„ÎµÎ¹Î½Î­Ï‚ Î´Ï…Î½Î¬Î¼ÎµÎ¹Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    131,
    'Î— Î•ÏÎ±ÏƒÏ„Î®Ï‚',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î¨Ï…Ï‡Î¿Î³Î¹ÏŒÏ‚',
    '9789604536985',
    432,
    'ÎˆÎ½Î± Î¹ÏƒÏ„Î¿ÏÎ¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎˆÏ†Î·Ï‚ ÎœÎ¹Ï‡Î±Î·Î»Î¯Î´Î¿Ï… Î³Î¹Î± Ï„Î· Î¶Ï‰Î® Ï„Î·Ï‚ Î¦ÏÎ±Î³ÎºÎ¿Ï†Î¿Î½Î¹ÎºÎ®Ï‚ Î‘Î¹Î³ÏÏ€Ï„Î¿Ï… ÎºÎ±Î¹ Ï„Î· ÏƒÏ‡Î­ÏƒÎ· Ï„Î·Ï‚ Î¼Îµ Ï„Î¿Î½ Ï€Î¿Î¹Î·Ï„Î® ÎšÏ‰Î½ÏƒÏ„Î±Î½Ï„Î¯Î½Î¿ ÎšÎ±Î²Î¬Ï†Î·.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    132,
    'Î— ÎšÏŒÎºÎºÎ¹Î½Î· Î ÏÎ»Î·',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ ÎšÎ­Î´ÏÎ¿Ï‚',
    '9789600423071',
    400,
    'ÎˆÎ½Î± Î±ÏƒÏ„Ï…Î½Î¿Î¼Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎŠÏÎ²Î¹Î½ Î“Î¿Ï…ÏŒÎ»Î±Ï‚ Î³Î¹Î± Î¼Î¹Î± Î¿Î¼Î¬Î´Î± ÎµÎ³ÎºÎ»Î·Î¼Î±Ï„Î¹ÏŽÎ½ Ï€Î¿Ï… ÏƒÏ‡ÎµÎ´Î¹Î¬Î¶Î¿Ï…Î½ Î¼Î¹Î± Î»Î·ÏƒÏ„ÎµÎ¯Î± ÏƒÎµ Î­Î½Î± Î±Ï€Î¿Î¸Î·ÎºÎµÏ…Ï„Î¹ÎºÏŒ Ï‡ÏŽÏÎ¿ Î¼Î­ÏƒÏ‰ Î¼Î¹Î±Ï‚ ÎºÏŒÎºÎºÎ¹Î½Î·Ï‚ Ï€ÏÎ»Î·Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    133,
    'ÎŸ Î Î»Î¿ÏÏ„Î¿Ï‚ Ï„Ï‰Î½ Î•Î¸Î½ÏŽÎ½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÎºÎ¬Ï„Î·',
    '9789604253942',
    736,
    'ÎˆÎ½Î± Î¿Î¹ÎºÎ¿Î½Î¿Î¼Î¹ÎºÏŒ Î²Î¹Î²Î»Î¯Î¿ Ï„Î¿Ï… Î†Î½Ï„Î±Î¼ Î£Î¼Î¹Î¸ Ï€Î¿Ï… Î±Î½Î±Î»ÏÎµÎ¹ Ï„Î¹Ï‚ Î¿Î¹ÎºÎ¿Î½Î¿Î¼Î¹ÎºÎ­Ï‚ Î±ÏÏ‡Î­Ï‚ ÎºÎ±Î¹ Ï„Î¹Ï‚ Î±Î½Ï„Î¹Î»Î®ÏˆÎµÎ¹Ï‚ Î³Î¹Î± Ï„Î¿Î½ Ï€Î»Î¿ÏÏ„Î¿ Ï„Ï‰Î½ ÎµÎ¸Î½ÏŽÎ½.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    134,
    'Î— Î†ÏƒÏ€ÏÎ· ÎšÎ±Î¼Î®Î»Î±',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601638905',
    352,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ Î•Î¹ÏÎ®Î½Î·Ï‚ ÎšÎ±ÏÏÎ´Î· Î³Î¹Î± Î¼Î¹Î± Î³Ï…Î½Î±Î¯ÎºÎ± Ï€Î¿Ï… ÎµÏ€Î¹ÏƒÏ„ÏÎ­Ï†ÎµÎ¹ ÏƒÏ„Î·Î½ Ï€Î±Ï„ÏÎ¯Î´Î± Ï„Î·Ï‚, Ï„Î·Î½ Î•Î»Î»Î¬Î´Î±, ÎºÎ±Î¹ Î±Î½Î±Î¶Î·Ï„Î¬ Ï„Î·Î½ Î±Ï€Î¿Î´Î¿Ï‡Î® ÎºÎ±Î¹ Ï„Î·Î½ ÎµÏ…Ï„Ï…Ï‡Î¯Î±.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    135,
    'Î¤Î± Î Î±Î¹Î´Î¹Î¬ Ï„Î·Ï‚ Î›Ï…ÎºÎ±Î½Î¸ÏÏŽÏ€Î¿Ï…',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÏƒÏ„Î¯Î±',
    '9789600513371',
    352,
    'ÎˆÎ½Î± Ï†Î±Î½Ï„Î±ÏƒÏ„Î¹ÎºÏŒ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… ÎšÏŽÏƒÏ„Î± Î§Î±Ï„Î¶Î·ÏƒÎ¬Î²Î²Î± Î³Î¹Î± Î¼Î¹Î± Î¿Î¼Î¬Î´Î± Ï€Î±Î¹Î´Î¹ÏŽÎ½ Ï€Î¿Ï… Î±Î½Î±ÎºÎ±Î»ÏÏ€Ï„Î¿Ï…Î½ ÏŒÏ„Î¹ Î­Ï‡Î¿Ï…Î½ Ï…Î²ÏÎ¹Î´Î¹ÎºÎ­Ï‚ Î´Ï…Î½Î¬Î¼ÎµÎ¹Ï‚ Î»Ï…ÎºÎ±Î½Î¸ÏÏŽÏ€Ï‰Î½ ÎºÎ±Î¹ Ï€ÏÎ­Ï€ÎµÎ¹ Î½Î± Ï€ÏÎ¿ÏƒÏ„Î±Ï„ÎµÏÏƒÎ¿Ï…Î½ Ï„Î¿Î½ ÎºÏŒÏƒÎ¼Î¿ Î±Ï€ÏŒ Ï„Î¿Î½ ÎºÎ¯Î½Î´Ï…Î½Î¿.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    136,
    'ÎŸ Î ÏŒÎ»ÎµÎ¼Î¿Ï‚ Ï„Ï‰Î½ ÎšÏŒÏƒÎ¼Ï‰Î½',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î Î±Ï„Î¬ÎºÎ·',
    '9789601638653',
    400,
    'ÎˆÎ½Î± ÎµÏ€Î¹ÏƒÏ„Î·Î¼Î¿Î½Î¹ÎºÏŒ-Ï†Î±Î½Ï„Î±ÏƒÎ¯Î±Ï‚ Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î§.Î“. ÎŸÏ…Î­Î»Ï‚ Î³Î¹Î± Î¼Î¹Î± ÎµÎ¹ÏƒÎ²Î¿Î»Î® ÎµÎ¾Ï‰Î³Î®Î¹Î½Ï‰Î½ ÏƒÏ„Î· Î“Î· ÎºÎ±Î¹ Ï„Î·Î½ Î±Î½Ï„Î¯ÏƒÏ„Î±ÏƒÎ· Ï„Î·Ï‚ Î±Î½Î¸ÏÏ‰Ï€ÏŒÏ„Î·Ï„Î±Ï‚.',
    NULL,
    'Greek'
  );
INSERT INTO
  `Book` (
    `Book_id`,
    `Title`,
    `Publisher`,
    `ISBN`,
    `Pages`,
    `Summary`,
    `Image`,
    `Language`
  )
VALUES
  (
    137,
    'Î¤Î¿ Î¤Î±Ï„Î¿Ï…Î¬Î¶',
    'Î•ÎºÎ´ÏŒÏƒÎµÎ¹Ï‚ Î•ÎºÎ¬Ï„Î·',
    '9789604253416',
    272,
    'ÎˆÎ½Î± Î¼Ï…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î¿Ï… Î¦Î¯Î»Î¹Ï€ Î Î¿Î» Î³Î¹Î± Î¼Î¹Î± Î³Ï…Î½Î±Î¯ÎºÎ± Ï€Î¿Ï… Î±Ï€Î¿Ï†Î±ÏƒÎ¯Î¶ÎµÎ¹ Î½Î± ÎºÎ¬Î½ÎµÎ¹ Î­Î½Î± Ï„Î±Ï„Î¿Ï…Î¬Î¶ ÏƒÏ„Î·Î½ Ï€Î»Î¬Ï„Î· Ï„Î·Ï‚ ÎºÎ±Î¹ Ï„Î·Î½ ÎµÏ€Î¹ÏÏÎ¿Î® Ï€Î¿Ï… Î­Ï‡ÎµÎ¹ Î±Ï…Ï„Î® Î· ÎµÏ€Î¹Î»Î¿Î³Î® ÏƒÏ„Î· Î¶Ï‰Î® Ï„Î·Ï‚.',
    NULL,
    'Greek'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book_Copies
# ------------------------------------------------------------

INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (1, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (1, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (1, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (1, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (2, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (2, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (2, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (2, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (3, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (3, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (3, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (3, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (4, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (4, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (4, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (4, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (5, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (5, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (5, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (5, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (6, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (6, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (6, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (6, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (7, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (7, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (7, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (7, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (8, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (8, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (8, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (8, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (9, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (9, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (9, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (9, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (10, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (10, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (10, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (10, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (11, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (11, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (11, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (11, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (12, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (12, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (12, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (12, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (13, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (13, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (13, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (13, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (14, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (14, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (14, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (14, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (15, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (15, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (15, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (15, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (16, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (16, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (16, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (16, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (17, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (17, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (17, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (17, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (18, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (18, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (18, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (18, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (19, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (19, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (19, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (19, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (20, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (20, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (20, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (20, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (21, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (21, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (21, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (21, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (22, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (22, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (22, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (22, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (23, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (23, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (23, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (23, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (24, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (24, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (24, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (24, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (25, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (25, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (25, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (25, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (26, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (26, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (26, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (26, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (27, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (27, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (27, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (27, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (28, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (28, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (28, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (28, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (29, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (29, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (29, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (29, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (30, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (30, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (30, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (30, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (31, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (31, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (31, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (31, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (32, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (32, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (32, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (32, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (33, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (33, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (33, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (33, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (34, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (34, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (34, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (34, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (35, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (35, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (35, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (35, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (36, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (36, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (36, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (36, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (37, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (37, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (37, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (37, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (38, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (38, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (38, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (38, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (39, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (39, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (39, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (39, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (40, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (40, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (40, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (40, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (41, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (41, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (41, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (41, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (42, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (42, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (42, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (42, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (43, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (43, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (43, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (43, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (44, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (44, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (44, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (44, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (45, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (45, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (45, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (45, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (46, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (46, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (46, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (46, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (47, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (47, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (47, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (47, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (48, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (48, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (48, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (48, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (49, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (49, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (49, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (49, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (50, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (50, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (50, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (50, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (51, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (51, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (51, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (51, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (52, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (52, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (52, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (52, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (53, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (53, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (53, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (53, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (54, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (54, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (54, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (54, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (55, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (55, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (55, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (55, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (56, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (56, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (56, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (56, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (57, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (57, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (57, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (57, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (58, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (58, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (58, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (58, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (59, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (59, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (59, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (59, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (60, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (60, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (60, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (60, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (61, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (61, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (61, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (61, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (62, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (62, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (62, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (62, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (63, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (63, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (63, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (63, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (64, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (64, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (64, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (64, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (65, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (65, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (65, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (65, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (66, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (66, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (66, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (66, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (67, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (67, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (67, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (67, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (68, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (68, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (68, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (68, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (69, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (69, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (69, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (69, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (70, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (70, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (70, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (70, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (71, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (71, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (71, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (71, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (72, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (72, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (72, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (72, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (73, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (73, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (73, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (73, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (74, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (74, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (74, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (74, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (75, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (75, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (75, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (75, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (76, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (76, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (76, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (76, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (77, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (77, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (77, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (77, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (78, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (78, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (78, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (78, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (79, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (79, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (79, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (79, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (80, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (80, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (80, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (80, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (81, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (81, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (81, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (81, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (82, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (82, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (82, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (82, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (83, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (83, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (83, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (83, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (84, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (84, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (84, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (84, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (85, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (85, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (85, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (85, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (86, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (86, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (86, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (86, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (87, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (87, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (87, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (87, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (88, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (88, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (88, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (88, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (89, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (89, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (89, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (89, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (90, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (90, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (90, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (90, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (91, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (91, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (91, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (91, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (92, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (92, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (92, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (92, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (93, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (93, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (93, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (93, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (94, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (94, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (94, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (94, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (95, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (95, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (95, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (95, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (96, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (96, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (96, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (96, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (97, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (97, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (97, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (97, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (98, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (98, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (98, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (98, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (99, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (99, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (99, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (99, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (100, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (100, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (100, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (100, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (101, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (101, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (101, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (101, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (102, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (102, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (102, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (102, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (103, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (103, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (103, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (103, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (104, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (104, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (104, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (104, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (105, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (105, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (105, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (105, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (106, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (106, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (106, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (106, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (107, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (107, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (107, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (107, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (108, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (108, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (108, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (108, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (109, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (109, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (109, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (109, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (110, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (110, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (110, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (110, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (111, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (111, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (111, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (111, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (112, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (112, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (112, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (112, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (113, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (113, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (113, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (113, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (114, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (114, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (114, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (114, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (115, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (115, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (115, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (115, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (116, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (116, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (116, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (116, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (117, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (117, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (117, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (117, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (118, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (118, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (118, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (118, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (119, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (119, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (119, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (119, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (120, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (120, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (120, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (120, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (121, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (121, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (121, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (121, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (122, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (122, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (122, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (122, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (123, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (123, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (123, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (123, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (124, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (124, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (124, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (124, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (125, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (125, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (125, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (125, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (126, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (126, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (126, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (126, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (127, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (127, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (127, 3, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (127, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (128, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (128, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (128, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (128, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (129, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (129, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (129, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (129, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (130, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (130, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (130, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (130, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (131, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (131, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (131, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (131, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (132, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (132, 2, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (132, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (132, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (133, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (133, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (133, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (133, 4, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (134, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (134, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (134, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (134, 4, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (135, 1, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (135, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (135, 3, 1);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (135, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (136, 1, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (136, 2, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (136, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (136, 4, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (137, 1, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (137, 2, 0);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (137, 3, 2);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (137, 4, 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book_authors
# ------------------------------------------------------------

INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (1, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (2, 45);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (3, 3);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (4, 29);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (5, 36);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (6, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (7, 46);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (8, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (9, 3);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (10, 40);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (11, 39);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (12, 25);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (13, 9);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (14, 19);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (15, 15);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (16, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (17, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (18, 24);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (19, 49);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (20, 22);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (21, 13);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (22, 48);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (23, 50);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (24, 4);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (25, 20);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (26, 39);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (27, 34);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (28, 50);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (29, 1);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (30, 2);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (31, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (32, 23);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (33, 48);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (34, 20);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (35, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (36, 26);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (37, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (38, 50);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (39, 33);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (40, 13);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (41, 16);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (42, 40);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (43, 1);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (44, 35);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (45, 20);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (46, 46);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (47, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (48, 15);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (49, 14);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (50, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (51, 15);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (52, 10);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (53, 3);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (54, 36);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (55, 22);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (56, 50);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (57, 35);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (58, 23);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (59, 9);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (60, 25);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (61, 49);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (62, 17);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (63, 39);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (64, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (65, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (66, 32);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (67, 34);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (68, 23);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (69, 13);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (70, 45);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (71, 34);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (72, 37);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (73, 31);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (74, 42);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (75, 20);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (76, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (77, 44);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (78, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (79, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (80, 13);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (81, 42);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (82, 18);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (83, 16);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (84, 26);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (85, 30);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (86, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (87, 17);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (88, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (89, 4);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (90, 7);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (91, 23);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (92, 43);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (93, 44);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (94, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (95, 23);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (96, 40);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (97, 32);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (98, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (99, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (100, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (101, 14);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (102, 49);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (103, 3);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (104, 20);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (105, 37);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (106, 26);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (107, 16);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (108, 5);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (109, 26);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (110, 14);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (111, 43);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (112, 23);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (113, 33);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (114, 48);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (115, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (116, 10);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (117, 27);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (118, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (119, 47);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (120, 16);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (121, 39);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (122, 48);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (123, 23);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (124, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (125, 33);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (126, 3);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (127, 15);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (128, 14);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (129, 25);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (130, 35);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (131, 47);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (132, 29);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (133, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (134, 40);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (135, 34);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (136, 50);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (137, 49);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book_categories
# ------------------------------------------------------------

INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (1, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (1, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (1, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (2, 5);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (2, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (2, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (3, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (3, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (3, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (4, 4);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (4, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (4, 31);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (5, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (5, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (5, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (6, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (6, 4);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (6, 26);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (7, 6);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (7, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (7, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (8, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (8, 10);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (8, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (9, 4);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (9, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (9, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (10, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (10, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (10, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (11, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (11, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (11, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (12, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (12, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (12, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (13, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (13, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (13, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (14, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (14, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (14, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (15, 7);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (15, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (15, 32);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (16, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (16, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (16, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (17, 4);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (17, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (17, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (18, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (18, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (18, 32);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (19, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (19, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (19, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (20, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (20, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (20, 32);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (21, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (21, 17);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (21, 29);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (22, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (22, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (22, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (23, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (23, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (23, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (24, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (24, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (24, 26);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (25, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (25, 20);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (25, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (26, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (26, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (26, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (27, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (27, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (27, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (28, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (28, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (28, 29);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (29, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (29, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (29, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (30, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (30, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (30, 26);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (31, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (31, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (31, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (32, 31);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (32, 32);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (33, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (33, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (33, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (34, 7);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (34, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (34, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (35, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (35, 26);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (35, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (36, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (36, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (36, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (37, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (37, 6);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (37, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (38, 10);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (38, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (38, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (39, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (39, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (39, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (40, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (40, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (40, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (41, 10);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (41, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (41, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (42, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (42, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (42, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (43, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (43, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (43, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (44, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (44, 6);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (44, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (45, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (45, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (45, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (46, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (46, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (46, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (47, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (47, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (47, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (48, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (48, 17);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (48, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (49, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (49, 20);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (49, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (50, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (50, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (50, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (51, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (51, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (51, 29);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (52, 17);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (52, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (52, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (53, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (53, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (53, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (54, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (54, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (54, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (55, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (55, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (55, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (56, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (56, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (56, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (57, 5);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (57, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (57, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (58, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (58, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (58, 26);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (59, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (59, 20);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (59, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (60, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (60, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (60, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (61, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (61, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (61, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (62, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (62, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (62, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (63, 10);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (63, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (63, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (64, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (64, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (64, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (65, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (65, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (65, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (66, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (66, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (66, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (67, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (67, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (67, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (68, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (68, 20);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (68, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (69, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (69, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (69, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (70, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (70, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (70, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (71, 4);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (71, 5);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (71, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (72, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (72, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (72, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (73, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (73, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (73, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (74, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (74, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (74, 29);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (75, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (75, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (75, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (76, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (76, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (76, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (77, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (77, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (77, 26);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (78, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (78, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (78, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (79, 10);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (79, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (79, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (80, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (80, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (80, 31);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (81, 5);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (81, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (81, 17);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (82, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (82, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (82, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (83, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (83, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (83, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (84, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (84, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (84, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (85, 7);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (85, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (85, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (86, 6);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (86, 10);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (86, 26);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (87, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (87, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (87, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (88, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (88, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (88, 20);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (89, 7);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (89, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (89, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (90, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (90, 5);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (90, 17);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (91, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (91, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (91, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (92, 6);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (92, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (92, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (93, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (93, 8);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (93, 20);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (94, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (94, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (94, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (95, 8);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (95, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (95, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (96, 4);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (96, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (96, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (97, 8);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (97, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (97, 32);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (98, 5);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (98, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (98, 31);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (99, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (99, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (99, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (100, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (100, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (100, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (101, 7);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (101, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (101, 29);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (102, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (102, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (102, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (103, 5);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (103, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (103, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (104, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (104, 20);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (104, 31);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (105, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (105, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (105, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (106, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (106, 6);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (106, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (107, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (107, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (107, 29);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (108, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (108, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (108, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (109, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (109, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (109, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (110, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (110, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (110, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (111, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (111, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (111, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (112, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (112, 8);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (112, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (113, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (113, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (113, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (114, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (114, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (114, 32);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (115, 7);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (115, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (115, 26);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (116, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (116, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (116, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (117, 5);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (117, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (117, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (118, 18);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (118, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (118, 27);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (119, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (119, 23);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (119, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (120, 8);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (120, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (120, 28);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (121, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (121, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (121, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (122, 29);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (122, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (122, 33);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (123, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (123, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (123, 24);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (124, 30);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (124, 31);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (124, 34);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (125, 8);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (125, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (125, 29);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (126, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (126, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (126, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (127, 3);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (127, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (127, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (128, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (128, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (128, 26);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (129, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (129, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (129, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (130, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (130, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (130, 14);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (131, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (131, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (131, 17);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (132, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (132, 21);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (132, 22);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (133, 4);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (133, 9);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (133, 19);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (134, 10);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (134, 16);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (134, 25);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (135, 2);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (135, 12);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (135, 15);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (136, 11);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (136, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (136, 20);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (137, 1);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (137, 13);
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (137, 26);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book_keywords
# ------------------------------------------------------------

INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (1, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (2, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (3, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (4, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (5, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (6, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (7, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (8, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (9, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (10, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (11, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (12, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (13, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (14, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (15, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (16, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (17, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (18, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (19, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (20, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (21, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (22, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (23, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (24, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (25, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (26, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (27, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (28, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (29, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (30, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (31, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (32, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (33, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (34, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (35, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (36, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (37, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (38, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (39, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (40, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (41, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (42, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (43, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (44, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (45, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (46, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (47, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (48, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (49, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (50, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (51, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (52, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (53, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (54, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (55, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (56, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (57, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (58, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (59, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (60, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (61, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (62, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (63, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (64, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (65, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (66, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (67, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (68, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (69, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (70, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (71, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (72, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (73, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (74, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (75, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (76, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (77, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (78, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (79, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (80, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (81, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (82, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (83, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (84, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (85, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (86, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (87, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (88, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (89, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (90, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (91, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (92, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (93, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (94, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (95, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (96, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (97, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (98, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (99, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (100, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (101, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (102, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (103, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (104, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (105, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (106, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (107, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (108, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (109, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (110, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (111, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (112, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (113, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (114, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (115, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (116, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (117, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (118, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (119, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (120, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (121, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (122, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (123, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (124, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (125, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (126, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (127, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (128, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (129, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (130, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (131, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (132, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (133, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (134, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (135, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (136, 1);
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (137, 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Category
# ------------------------------------------------------------

INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (1, 'Action and Adventure');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (2, 'Art');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (3, 'Biography');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (4, 'Business and Economics');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (5, 'Comics and Graphic Novels');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (6, 'Computing and Technology');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (7, 'Cookbooks and Food');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (8, 'Crafts and Hobbies');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (9, 'Crime and Mystery');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (10, 'Drama');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (11, 'Education and Teaching');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (12, 'Fantasy');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (13, 'Fiction');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (14, 'Health and Wellness');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (15, 'Historical Fiction');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (16, 'History');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (17, 'Horror');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (18, 'Humor');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (19, 'Inspirational and Motivational');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (20, 'LGBTQ+');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (21, 'Literary Fiction');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (22, 'Music');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (23, 'Parenting and Family');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (24, 'Philosophy');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (25, 'Poetry');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (26, 'Politics and Social Sciences');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (27, 'Religion and Spirituality');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (28, 'Romance');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (29, 'Science');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (30, 'Science Fiction');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (31, 'Self-Help and Personal Development');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (32, 'Sports');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (33, 'Thriller');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (34, 'Travel');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (35, 'True Crime');
INSERT INTO
  `Category` (`Category_id`, `Category`)
VALUES
  (36, 'Western');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Keyword
# ------------------------------------------------------------

INSERT INTO
  `Keyword` (`Keyword_id`, `Keyword`)
VALUES
  (1, 'Educational');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Loan
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Reservation
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Review
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: School
# ------------------------------------------------------------

INSERT INTO
  `School` (
    `School_id`,
    `Name`,
    `Address`,
    `City`,
    `Phone`,
    `Email`
  )
VALUES
  (
    1,
    '1Î¿ Î›ÏÎºÎµÎ¹Î¿ Î‘Î¸Î·Î½ÏŽÎ½',
    'Î£Ï„Î±Î´Î¯Î¿Ï… 40',
    'Î‘Î¸Î®Î½Î±',
    '2102324000',
    '1ogel@gmail.com'
  );
INSERT INTO
  `School` (
    `School_id`,
    `Name`,
    `Address`,
    `City`,
    `Phone`,
    `Email`
  )
VALUES
  (
    2,
    '2Î¿ Î“Ï…Î¼Î½Î¬ÏƒÎ¹Î¿ Î Î±Ï„ÏÏŽÎ½',
    'Î§Î¯Î¿Ï… 2',
    'Î Î¬Ï„ÏÎ±',
    '3452324000',
    '2opatr@gmail.com'
  );
INSERT INTO
  `School` (
    `School_id`,
    `Name`,
    `Address`,
    `City`,
    `Phone`,
    `Email`
  )
VALUES
  (
    3,
    'Î›ÏÎºÎµÎ¹Î¿ Î Î¬ÏÎ¿Ï…',
    'ÎšÎ¿Î»Î¿ÎºÎ¿Ï„ÏÏŽÎ½Î· 10',
    'Î Î±ÏÎ¿Î¹ÎºÎ¹Î¬',
    '5432324000',
    'lykparou@gmail.com'
  );
INSERT INTO
  `School` (
    `School_id`,
    `Name`,
    `Address`,
    `City`,
    `Phone`,
    `Email`
  )
VALUES
  (
    4,
    '3Î¿ Î›ÏÎºÎµÎ¹Î¿ Î“Î»Ï…Ï†Î¬Î´Î±Ï‚',
    'ÎšÏÏ€ÏÎ¿Ï… 36',
    'Î“Î»Ï…Ï†Î¬Î´Î±',
    '2102325430',
    '3olyk@gmail.com'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: User
# ------------------------------------------------------------

INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    1,
    'student1',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'John Smith',
    12,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    2,
    'student2',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Jane Doe',
    13,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    3,
    'student3',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Mike Johnson',
    14,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    4,
    'student4',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Emily Brown',
    15,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    5,
    'student5',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'David Wilson',
    16,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    6,
    'student6',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Sarah Davis',
    17,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    7,
    'student7',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Michael Miller',
    18,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    8,
    'student8',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Emma Garcia',
    12,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    9,
    'student9',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Daniel Martinez',
    13,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    10,
    'student10',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Olivia Smith',
    14,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    11,
    'student11',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Ethan Johnson',
    15,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    12,
    'student12',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Ava Davis',
    16,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    13,
    'student13',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Noah Wilson',
    17,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    14,
    'student14',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Isabella Brown',
    18,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    15,
    'student15',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'William Garcia',
    12,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    16,
    'student16',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Sophia Martinez',
    13,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    17,
    'student17',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'James Smith',
    14,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    18,
    'student18',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Mia Doe',
    15,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    19,
    'student19',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Benjamin Johnson',
    16,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    20,
    'student20',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Charlotte Brown',
    17,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    21,
    'student21',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Liam Wilson',
    18,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    22,
    'student22',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Amelia Davis',
    12,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    23,
    'student23',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Henry Miller',
    13,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    24,
    'student24',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Evelyn Garcia',
    14,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    25,
    'student25',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Alexander Martinez',
    15,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    26,
    'student26',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Sofia Smith',
    16,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    27,
    'student27',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Joseph Johnson',
    17,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    28,
    'student28',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Harper Davis',
    18,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    29,
    'student29',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'David Wilson',
    12,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    30,
    'student30',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Abigail Brown',
    13,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    31,
    'student31',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Daniel Garcia',
    14,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    32,
    'student32',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Victoria Martinez',
    15,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    33,
    'student33',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Michael Smith',
    16,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    34,
    'student34',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Sophia Johnson',
    17,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    35,
    'student35',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'James Davis',
    18,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    36,
    'student36',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Mia Wilson',
    12,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    37,
    'student37',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Benjamin Brown',
    13,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    38,
    'student38',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Charlotte Garcia',
    14,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    39,
    'student39',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Liam Martinez',
    15,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    40,
    'student40',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Amelia Smith',
    16,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    41,
    'student41',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Henry Johnson',
    17,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    42,
    'student42',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Evelyn Davis',
    18,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    43,
    'student43',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Alexander Wilson',
    12,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    44,
    'student44',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Sofia Brown',
    13,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    45,
    'student45',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Joseph Garcia',
    14,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    46,
    'student46',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Harper Martinez',
    15,
    'Student',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    47,
    'student47',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'David Smith',
    16,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    48,
    'student48',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Abigail Johnson',
    17,
    'Student',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    49,
    'student49',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Daniel Davis',
    18,
    'Student',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    50,
    'student50',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Victoria Brown',
    12,
    'Student',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    51,
    'teacher1',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Robert Johnson',
    32,
    'Teacher',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    52,
    'teacher2',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Jennifer Smith',
    29,
    'Teacher',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    53,
    'teacher3',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Michael Brown',
    35,
    'Teacher',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    54,
    'teacher4',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Jessica Wilson',
    37,
    'Teacher',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    55,
    'teacher5',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Christopher Davis',
    41,
    'Teacher',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    56,
    'teacher6',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Emily Miller',
    33,
    'Teacher',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    57,
    'teacher7',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Matthew Garcia',
    39,
    'Teacher',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    58,
    'teacher8',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Ashley Martinez',
    31,
    'Teacher',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    59,
    'teacher9',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Daniel Smith',
    28,
    'Teacher',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    60,
    'teacher10',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Sophia Johnson',
    36,
    'Teacher',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    61,
    'director1',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'John Anderson',
    55,
    'Director',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    62,
    'director2',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Sarah Thompson',
    61,
    'Director',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    63,
    'director3',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'David Johnson',
    58,
    'Director',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    64,
    'director4',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Emily Wilson',
    49,
    'Director',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    65,
    'operator1',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Michael Davis',
    28,
    'Library Operator',
    1
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    66,
    'operator2',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Jessica Rodriguez',
    35,
    'Library Operator',
    2
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    67,
    'operator3',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Christopher Martinez',
    31,
    'Library Operator',
    3
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    68,
    'operator4',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'Amanda Thompson',
    26,
    'Library Operator',
    4
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Age`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    69,
    'admin',
    '$2b$10$5l3A31dNZDhuMRhLalHvb.7EzTmiGhKrMDbW9Zyj/xdBAYqfK25Zy',
    'John Smith',
    90,
    'Admin',
    NULL
  );

# ------------------------------------------------------------
# TRIGGER DUMP FOR: subtract_copies_after_loan
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS subtract_copies_after_loan;
DELIMITER ;;
CREATE TRIGGER IF NOT EXISTS subtract_copies_after_loan
AFTER INSERT ON Loan FOR EACH ROW
	UPDATE Book_Copies b INNER JOIN User u ON u.User_id = NEW.User_id
    SET b.Copies = b.Copies - 1
    WHERE b.Book_id = NEW.Book_id AND b.School_id = u.School_id;;
DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
