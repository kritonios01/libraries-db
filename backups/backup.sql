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
  PRIMARY KEY (`Author_id`),
  UNIQUE KEY `Name` (`Name`),
  KEY `authorsearch_idx` (`Name`)
) ENGINE = InnoDB AUTO_INCREMENT = 52 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book` (
  `Book_id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(80) NOT NULL,
  `Publisher` varchar(100) NOT NULL,
  `ISBN` varchar(13) NOT NULL,
  `Pages` int(4) NOT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 139 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book_Copies
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book_Copies` (
  `Book_id` int(11) NOT NULL,
  `School_id` int(11) NOT NULL,
  `Copies` int(2) NOT NULL,
  PRIMARY KEY (`Book_id`, `School_id`),
  KEY `School_id` (`School_id`),
  CONSTRAINT `Book_Copies_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Book_Copies_ibfk_2` FOREIGN KEY (`School_id`) REFERENCES `School` (`School_id`) ON DELETE CASCADE,
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
  CONSTRAINT `Book_authors_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Book_authors_ibfk_2` FOREIGN KEY (`Author_id`) REFERENCES `Author` (`Author_id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book_categories
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book_categories` (
  `Book_id` int(11) NOT NULL,
  `Category_id` int(11) NOT NULL,
  PRIMARY KEY (`Book_id`, `Category_id`),
  KEY `Category_id` (`Category_id`),
  CONSTRAINT `Book_categories_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Book_categories_ibfk_2` FOREIGN KEY (`Category_id`) REFERENCES `Category` (`Category_id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book_keywords
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book_keywords` (
  `Book_id` int(11) NOT NULL,
  `Keyword_id` int(11) NOT NULL,
  PRIMARY KEY (`Book_id`, `Keyword_id`),
  KEY `Keyword_id` (`Keyword_id`),
  CONSTRAINT `Book_keywords_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Book_keywords_ibfk_2` FOREIGN KEY (`Keyword_id`) REFERENCES `Keyword` (`Keyword_id`) ON DELETE CASCADE
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
  PRIMARY KEY (`Category_id`),
  KEY `categorysearch_idx` (`Category`)
) ENGINE = InnoDB AUTO_INCREMENT = 37 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Keyword
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Keyword` (
  `Keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `Keyword` varchar(30) NOT NULL,
  PRIMARY KEY (`Keyword_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Loan
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Loan` (
  `Loan_id` int(11) NOT NULL AUTO_INCREMENT,
  `Date_out` date DEFAULT NULL,
  `Due_date` date DEFAULT NULL,
  `Return_date` date DEFAULT NULL,
  `Status` enum('REQUESTED', 'BORROWED', 'RETURNED', 'LATE') DEFAULT NULL,
  `Book_id` int(11) NOT NULL,
  `User_id` int(11) NOT NULL,
  PRIMARY KEY (`Loan_id`, `Book_id`, `User_id`),
  KEY `Book_id` (`Book_id`),
  KEY `User_id` (`User_id`),
  CONSTRAINT `Loan_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Loan_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `User` (`User_id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`Date_out` < `Due_date`),
  CONSTRAINT `CONSTRAINT_2` CHECK (`Date_out` < `Return_date`)
) ENGINE = InnoDB AUTO_INCREMENT = 69 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Reservation
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Reservation` (
  `Reservation_id` int(11) NOT NULL AUTO_INCREMENT,
  `Date_` date NOT NULL,
  `Book_id` int(11) NOT NULL,
  `User_id` int(11) NOT NULL,
  PRIMARY KEY (`Reservation_id`, `Book_id`, `User_id`),
  KEY `Book_id` (`Book_id`),
  KEY `User_id` (`User_id`),
  CONSTRAINT `Reservation_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Reservation_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `User` (`User_id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 43 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Review
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Review` (
  `Review_id` int(11) NOT NULL AUTO_INCREMENT,
  `Rating` tinyint(1) NOT NULL,
  `Review` varchar(200) DEFAULT NULL,
  `Book_id` int(11) NOT NULL,
  `User_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`Review_id`, `Book_id`),
  KEY `Book_id` (`Book_id`),
  KEY `User_id` (`User_id`),
  CONSTRAINT `Review_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Review_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `User` (`User_id`) ON DELETE
  SET
  NULL,
  CONSTRAINT `CONSTRAINT_1` CHECK (
    `Rating` between 1
    and 5
  )
) ENGINE = InnoDB AUTO_INCREMENT = 160 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

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
  KEY `usersearch_idx` (`Username`, `Password`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`School_id`) REFERENCES `School` (`School_id`) ON DELETE
  SET
  NULL
) ENGINE = InnoDB AUTO_INCREMENT = 70 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: AuthorWithoutLoans
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `AuthorWithoutLoans` AS
select
  distinct `A`.`Name` AS `AuthorName`
from
  `Author` `A`
except
select
  distinct `A`.`Name` AS `AuthorName`
from
  (
  (
    `Author` `A`
    join `Book_authors` `BA` on(`A`.`Author_id` = `BA`.`Author_id`)
  )
  join `Loan` `L` on(`BA`.`Book_id` = `L`.`Book_id`)
  );

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: AuthorsFewBooks
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `AuthorsFewBooks` AS
select
  `A`.`Name` AS `Authors`
from
  (
  `Author` `A`
  join `Book_authors` `BA` on(`BA`.`Author_id` = `A`.`Author_id`)
  )
group by
  `A`.`Author_id`
having
  count(0) + 4 < (
  select
    count(0)
  from
    (
    `Author` `A2`
    join `Book_authors` `BA2` on(`BA2`.`Author_id` = `A2`.`Author_id`)
    )
  group by
    `A2`.`Author_id`
  order by
    count(0) desc
  limit
    1
  );

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: AvgBorrower
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `AvgBorrower` AS
select
  `U`.`Name` AS `Borrower`,
  avg(`R`.`Rating`) AS `AverageRating`
from
  (
  `Review` `R`
  join `User` `U` on(`U`.`User_id` = `R`.`User_id`)
  )
group by
  `U`.`User_id`
order by
  `U`.`Name`;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: AvgCat
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `AvgCat` AS
select
  `C`.`Category` AS `Category`,
  avg(`R`.`Rating`) AS `AverageRating`
from
  (
  (
    `Review` `R`
    join `Book_categories` `BC` on(`BC`.`Book_id` = `R`.`Book_id`)
  )
  join `Category` `C` on(`C`.`Category_id` = `BC`.`Category_id`)
  )
group by
  `C`.`Category_id`
order by
  `C`.`Category`;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Books_summary
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `Books_summary` AS
select
  `Book`.`Book_id` AS `Book_id`,
  `Book_Copies`.`School_id` AS `School_id`,
  `Book`.`Title` AS `Title`,
  `Book`.`Publisher` AS `Publisher`,
  `Book`.`ISBN` AS `ISBN`,
  `Book`.`Pages` AS `Pages`,
  `Book`.`Summary` AS `Summary`,
  `Book`.`Image` AS `Image`,
  `Book`.`Language` AS `Language`,
  `Book_Copies`.`Copies` AS `Copies`,
  group_concat(distinct `Author`.`Name` separator ', ') AS `Authors`,
  group_concat(distinct `Category`.`Category` separator ', ') AS `Categories`,
  group_concat(distinct `Keyword`.`Keyword` separator ', ') AS `Keywords`
from
  (
  (
    (
    (
      (
      (
        (
        `Book`
        join `Book_Copies` on(`Book`.`Book_id` = `Book_Copies`.`Book_id`)
        )
        join `Book_authors` on(`Book`.`Book_id` = `Book_authors`.`Book_id`)
      )
      join `Author` on(
        `Book_authors`.`Author_id` = `Author`.`Author_id`
      )
      )
      left join `Book_categories` on(`Book`.`Book_id` = `Book_categories`.`Book_id`)
    )
    left join `Category` on(
      `Book_categories`.`Category_id` = `Category`.`Category_id`
    )
    )
    left join `Book_keywords` on(`Book`.`Book_id` = `Book_keywords`.`Book_id`)
  )
  left join `Keyword` on(
    `Book_keywords`.`Keyword_id` = `Keyword`.`Keyword_id`
  )
  )
group by
  `Book`.`Book_id`,
  `Book_Copies`.`School_id`;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: CategoryAuthors
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `CategoryAuthors` AS
select
  `C`.`Category` AS `Category`,
  group_concat(`A`.`Name` separator ', ') AS `Authors`
from
  (
  (
    (
    `Category` `C`
    join `Book_categories` `BC` on(`C`.`Category_id` = `BC`.`Category_id`)
    )
    join `Book_authors` `BA` on(`BC`.`Book_id` = `BA`.`Book_id`)
  )
  join `Author` `A` on(`A`.`Author_id` = `BA`.`Author_id`)
  )
group by
  `C`.`Category_id`;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: CategoryTeachers
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `CategoryTeachers` AS
select
  `C`.`Category` AS `Category`,
  group_concat(`T`.`Name` separator ', ') AS `Teachers`
from
  (
  (
    (
    `Category` `C`
    join `Book_categories` `BC` on(`C`.`Category_id` = `BC`.`Category_id`)
    )
    join `Loan` `L` on(`BC`.`Book_id` = `L`.`Book_id`)
  )
  join `User` `T` on(`T`.`User_id` = `L`.`User_id`)
  )
where
  `T`.`Usertype` = 'Teacher'
  and `L`.`Date_out` + interval 1 year > curdate()
group by
  `C`.`Category_id`;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: LateLoans
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `LateLoans` AS
select
  `U`.`Name` AS `Name`,
  to_days(curdate()) - to_days(`L`.`Due_date`) AS `DelayDays`
from
  (
  `User` `U`
  join `Loan` `L` on(`L`.`User_id` = `U`.`User_id`)
  )
where
  `L`.`Status` = 'Late';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: LoanRequests
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `LoanRequests` AS
select
  `Loan`.`Loan_id` AS `Loan_id`,
  `Loan`.`Date_out` AS `Date_out`,
  `Loan`.`Due_date` AS `Due_date`,
  `Loan`.`Status` AS `Status`,
  `Book_Copies`.`Copies` AS `Copies`,
  `User`.`School_id` AS `School_id`,
  `User`.`Name` AS `Name`,
  `User`.`Username` AS `Username`,
  `Book`.`Title` AS `Title`
from
  (
  (
    (
    `Loan`
    join `User` on(`User`.`User_id` = `Loan`.`User_id`)
    )
    join `Book` on(`Book`.`Book_id` = `Loan`.`Book_id`)
  )
  join `Book_Copies` on(
    `Book_Copies`.`Book_id` = `Loan`.`Book_id`
    and `Book_Copies`.`School_id` = `User`.`School_id`
  )
  );

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: LoansPerMonth
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `LoansPerMonth` AS
select
  `s`.`Name` AS `School_Name`,
  year(`l`.`Date_out`) AS `Loan_Year`,
  month(`l`.`Date_out`) AS `Loan_Month`,
  count(`l`.`Loan_id`) AS `Total_Loans`
from
  (
  (
    `Loan` `l`
    join `User` `u` on(`l`.`User_id` = `u`.`User_id`)
  )
  join `School` `s` on(`u`.`School_id` = `s`.`School_id`)
  )
group by
  `s`.`School_id`,
  year(`l`.`Date_out`),
  month(`l`.`Date_out`);

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Operators20Loans
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `Operators20Loans` AS
select
  group_concat(`SUBQUERY`.`Name` separator ', ') AS `Operators`,
  `SUBQUERY`.`LoanedBooks` AS `LoanedBooks`
from
  (
  select
    `OP`.`Name` AS `Name`,
    count(0) AS `LoanedBooks`
  from
    (
    (
      `User` `OP`
      join `User` `U` on(`U`.`School_id` = `OP`.`School_id`)
    )
    join `Loan` `L` on(`L`.`User_id` = `U`.`User_id`)
    )
  where
    `OP`.`Usertype` = 'Library Operator'
    and `L`.`Date_out` + interval 1 year > curdate()
  group by
    `OP`.`Name`
  ) `SUBQUERY`
where
  `SUBQUERY`.`LoanedBooks` > 20
group by
  `SUBQUERY`.`LoanedBooks`;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Top3pairs
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `Top3pairs` AS
select
  `C1`.`Category` AS `Category1`,
  `C2`.`Category` AS `Category2`,
  count(0) AS `Borrowings`
from
  (
  (
    (
    (
      `Loan` `L`
      join `Book_categories` `BC1` on(`BC1`.`Book_id` = `L`.`Book_id`)
    )
    join `Book_categories` `BC2` on(`BC2`.`Book_id` = `L`.`Book_id`)
    )
    join `Category` `C1` on(`C1`.`Category_id` = `BC1`.`Category_id`)
  )
  join `Category` `C2` on(`C2`.`Category_id` = `BC2`.`Category_id`)
  )
where
  `C1`.`Category_id` < `C2`.`Category_id`
group by
  `C1`.`Category`,
  `C2`.`Category`
order by
  count(0) desc
limit
  3;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: YoungTeachers
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `YoungTeachers` AS
select
  `U`.`Name` AS `Teachers`,
  count(0) AS `NumBooksBorrowed`
from
  (
  `User` `U`
  join `Loan` `L` on(`U`.`User_id` = `L`.`User_id`)
  )
where
  `U`.`Usertype` = 'Teacher'
  and `U`.`Age` < 40
group by
  `U`.`User_id`
having
  count(0) = (
  select
    count(0)
  from
    (
    `Loan` `l`
    join `User` `u` on(`l`.`User_id` = `u`.`User_id`)
    )
  where
    `u`.`Usertype` = 'Teacher'
    and `u`.`Age` < 40
  group by
    `u`.`User_id`
  order by
    count(0) desc
  limit
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Author
# ------------------------------------------------------------

INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (45, 'Alain-Fournier');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (36, 'Albert Camus');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (10, 'Aldous Huxley');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (34, 'Alexandre Dumas');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (30, 'Alice Walker');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (38, 'Antoine de Saint-Exupery');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (13, 'C.S. Lewis');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (40, 'Charles Baudelaire');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (8, 'Charlotte Bronte');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (15, 'Dan Brown');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (41, 'Emile Zola');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (23, 'Emily Bronte');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (5, 'F. Scott Fitzgerald');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (49, 'Francoise Sagan');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (14, 'George Brownson');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (4, 'George Orwell');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (39, 'Gustave Flaubert');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (46, 'Guy de Maupassant');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (3, 'Harper Lee');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (6, 'Herman Melville');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (32, 'Homer');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (7, 'J.D. Salinger');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (12, 'J.K. Rowling');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (11, 'J.R.R. Tolkien');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (25, 'James Dashner');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (2, 'Jane Austen');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (48, 'Jean-Paul Sartre');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (18, 'John Green');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (50, 'Jules Verne');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (26, 'Kathryn Stockett');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (19, 'Khaled Hosseini');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (33, 'Kurt Vonnegut');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (27, 'Lois Lowry');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (47, 'Louis-Ferdinand Celine');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (16, 'Margaret Mitchell');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (24, 'Markus Zusak');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (22, 'Oscar Wilde');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (20, 'Paula Hawkins');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (1, 'Paulo Coelho');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (9, 'Penguin Classics');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (44, 'Pierre Choderlos de Laclos');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (31, 'Ray Bradbury');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (43, 'Stendhal');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (21, 'Stephen King');
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
  (17, 'Suzanne Collins');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (37, 'Victor Hugo');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (42, 'Voltaire');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (35, 'William Golding');
INSERT INTO
  `Author` (`Author_id`, `Name`)
VALUES
  (51, 'Γρίβας');

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
    'LÉtranger',
    'Gallimard',
    '9782070360024',
    186,
    'Un roman de labsurde écrit par Albert Camus.',
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
    'Les Misérables',
    'A. Lacroix, Verboeckhoven & Cie',
    '9780140444308',
    1488,
    'Un roman épique de Victor Hugo sur la vie des personnages pauvres et marginalisés en France du 19e siècle.',
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
    'Un conte philosophique de Antoine de Saint-Exupéry.',
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
    'Michel Lévy Frères',
    '9780199535651',
    368,
    'Un roman réaliste de Gustave Flaubert sur la vie dEmma Bovary.',
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
    'Un recueil de poèmes de Charles Baudelaire.',
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
    'Pétion',
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
    'Un roman de Émile Zola sur la vie des mineurs en France.',
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
    'Un roman épistolaire de Pierre Choderlos de Laclos sur les jeux de séduction.',
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
    'Un roman allégorique de Albert Camus sur une épidémie de peste.',
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
    'Denoël et Steele',
    '9782070360284',
    464,
    'Un roman de Louis-Ferdinand Céline sur la condition humaine.',
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
    'Un roman réaliste de Guy de Maupassant sur lascension sociale.',
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
    'La Nausée',
    'Gallimard',
    '9782070368075',
    240,
    'Un roman existentialiste de Jean-Paul Sartre sur labsurdité de lexistence.',
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
    'Léon Genonceaux',
    '9782253004575',
    304,
    'Un poème en prose de Comte de Lautréamont.',
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
    'Un roman de Patrick Süskind sur un tueur en série obsédé par les odeurs.',
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
    'Un roman réaliste de Émile Zola sur les grands magasins.',
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
    'Un roman réaliste de Émile Zola sur la vie ouvrière à Paris.',
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
    'Un roman de Jean Cocteau sur une relation toxique entre frère et sœur.',
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
    'Une pièce de théâtre de Jean-Paul Sartre sur lenfer des relations humaines.',
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
    'Éditions du Seuil',
    '9782253004117',
    192,
    'Un roman de Françoise Sagan sur ladolescence et le désir.',
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
    'Un recueil de poèmes de Victor Hugo.',
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
    'Les Rêveries du promeneur solitaire',
    'Garnier-Flammarion',
    '9782080711826',
    192,
    'Une œuvre autobiographique de Jean-Jacques Rousseau.',
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
    'Michel Lévy Frères',
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
    'La Poupée',
    'Fasquelle',
    '9782253011351',
    144,
    'Un roman de fiction de Pierre Louÿs.',
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
    'Ο Αλχημιστής',
    'Εκδόσεις Ψυχογιός',
    '9789604537876',
    224,
    'Ένα βιβλίο που μιλάει για τα όνειρα και τον εντοπισμό του πραγματικού νοήματος της ζωής.',
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
    'Το Νησί',
    'Εκδόσεις Κέδρος',
    '9789600425036',
    456,
    'Ένα μυθιστόρημα του Βίκτορ Πέλεβιν που περιγράφει τη ζωή ενός ανθρώπου σε ένα απομονωμένο νησί.',
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
    'Ο Λόρδος των Μυγών',
    'Εκδόσεις Πατάκη',
    '9789601612189',
    256,
    'Ένα αλληγορικό μυθιστόρημα του Ουίλιαμ Γκόλντινγκ για την εξέλιξη της κοινωνίας και τη φύση του ανθρώπου.',
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
    'Ο Δράκουλας',
    'Εκδόσεις Κλειδάριθμος',
    '9789602090646',
    432,
    'Ένα γοτθικό μυθιστόρημα του Μπραμ Στόκερ για τον βρικόλακα Δράκουλα.',
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
    'Η Οδύσσεια',
    'Εκδόσεις Εστία',
    '9789600515900',
    544,
    'Έπος του Όμηρου που περιγράφει την περιπέτεια του Οδυσσέα κατά τον επιστροφή του από τον Τρωικό πόλεμο.',
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
    'Ο Ιλιάδα',
    'Εκδόσεις Εστία',
    '9789600515603',
    608,
    'Έπος του Όμηρου που περιγράφει τον Τρωικό πόλεμο και τις μάχες των αρχαίων ηρώων.',
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
    'Τα Μεταμορφωμένα Τεστάμενα',
    'Εκδόσεις Κάκτος',
    '9789603824330',
    224,
    'Μια συλλογή από παραμύθια του Αντώνη Σαμαρά.',
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
    'Ο Τζούλιους Καίσαρ',
    'Εκδόσεις Βιβλιοπωλείον της Εστίας',
    '9789600514453',
    368,
    'Ένα βιογραφικό μυθιστόρημα του Ουίλιαμ Σαίξπηρ για τον Ρωμαίο ηγέτη Ιούλιο Καίσαρ.',
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
    'Τα Παιδιά της Αγάπης',
    'Εκδόσεις Ψυχογιός',
    '9789604533540',
    416,
    'Ένα μυθιστόρημα της Ελίφ Σαφάκ που εξερευνά την αγάπη και την ταυτότητα στην Τουρκία του 20ού αιώνα.',
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
    'Ο Μικρός Πρίγκιπας',
    'Εκδόσεις Ωκεανίδα',
    '9789604101087',
    96,
    'Ένα φιλοσοφικό παραμύθι του Αντουάν ντε Σαιντ-Εξυπερύ.',
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
    'Το Έγκλημα του Λόρενς Γιαρντίνερ',
    'Εκδόσεις Πατάκη',
    '9789601602821',
    208,
    'Ένα αστυνομικό μυθιστόρημα του Άγκαθα Κρίστι για μια δολοφονία σε μια πολυτελή έπαυλη.',
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
    'Η Συμμορία των Μεταναστών',
    'Εκδόσεις Κέδρος',
    '9789600427306',
    352,
    'Ένα μυθιστόρημα του Βίκτορ Πέλεβιν για μια συμμορία κλεφτών της δεκαετίας του 1920.',
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
    'Ο Κόκκινος Δράκος',
    'Εκδόσεις Πατάκη',
    '9789601610864',
    464,
    'Ένα αστυνομικό μυθιστόρημα του Τόμας Χάρις για τον δολοφόνο Σεριάλ Κίλερ.',
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
    'Το Όνομα του Ανέμου',
    'Εκδόσεις Ψυχογιός',
    '9789604537388',
    464,
    'Ένα μυθιστόρημα του Πάτρικ Ρόθφους για έναν άνδρα που αναζητά την αλήθεια πίσω από την τραγωδία που έζησε.',
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
    'Η Αλίκη στη Χώρα των Θαυμάτων',
    'Εκδόσεις Σαββάλας',
    '9789601637823',
    208,
    'Ένα παραμυθένιο μυθιστόρημα του Λιούις Κάρολ για τις περιπέτειες της Αλίκης σε έναν παράξενο κόσμο.',
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
    'Το Μεγάλο Τείχος',
    'Εκδόσεις Εκάτη',
    '9789604251962',
    432,
    'Ένα επιστημονικο-φανταστικό μυθιστόρημα του Τζον Σμίθ για ένα μεγάλο τείχος που προστατεύει την ανθρωπότητα.',
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
    'Ο Υποβρύχιος Κόσμος',
    'Εκδόσεις Ωκεανίδα',
    '9789604103722',
    368,
    'Ένα αριστούργημα του Ζιλ Βέρν για την περιπέτεια κάτω από την επιφάνεια των ωκεανών.',
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
    'Ο Μικρός Πρίγκιπας',
    'Εκδόσεις Κέδρος',
    '9789600423001',
    112,
    'Ένα φιλοσοφικό παραμύθι του Αντουάν ντε Σαιντ-Εξυπερύ.',
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
    'Η Επιστροφή του Σερίφη',
    'Εκδόσεις Ψυχογιός',
    '9789604539788',
    352,
    'Ένα αστυνομικό μυθιστόρημα του Ντέιβιντ Μπαλντάτσι για τον αποφυλακισμένο πρώην σερίφη Τζον Ρέινολντς που αναζητά δικαίωση.',
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
    'Η Πόλη των Καταραμένων',
    'Εκδόσεις Κλειδάριθμος',
    '9789602090813',
    608,
    'Ένα φανταστικό μυθιστόρημα της Κέλσεϋ Ντρέικ για μια πόλη όπου οι κάτοικοι είναι καταραμένοι να ζουν κάτω από την θάλασσα.',
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
    'Το Σώμα της Αθηνάς',
    'Εκδόσεις Πατάκη',
    '9789601611618',
    208,
    'Ένα ιστορικό μυθιστόρημα της Μάντας Τσικλήρη για μια ομάδα αρχαιολόγων που ανακαλύπτουν ένα μυστήριο αρχαίο θησαυρό.',
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
    'Ο Εραστής της Λαίδης Τσατλίν',
    'Εκδόσεις Ψυχογιός',
    '9789604541095',
    464,
    'Ένα ιστορικό μυθιστόρημα της Ρόμπιν Μπέρνς για τη ζωή του Τζόρτζ Τσάρλες Γκόρντον Μπάϊρον, του διάσημου ποιητή του 19ου αιώνα.',
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
    'Ο Ναυαγός των Παγετώνων',
    'Εκδόσεις Κλειδάριθμος',
    '9789602090721',
    352,
    'Ένα περιπετειώδες μυθιστόρημα του Τζούλς Βέρν για ένα ναυάγιο σε έναν απομονωμένο παγετώνα.',
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
    'Ο Μαέστρος και η Μαργαρίτα',
    'Εκδόσεις Σαββάλας',
    '9789601637557',
    512,
    'Ένα μυθιστόρημα του Μιχαήλ Μπουλγκάκωφ για τον συνάντηση του Ντιάβολου με τον Μαέστρο στη Μόσχα.',
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
    'Η Καλύβα',
    'Εκδόσεις Εστία',
    '9789600514606',
    256,
    'Ένα πνευματώδες μυθιστόρημα του Γιάννη Ξενάκη για την ανθρώπινη ψυχή και την αναζήτηση του νοήματος της ζωής.',
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
    'Οι Αδελφοί Καραμαζόφ',
    'Εκδόσεις Κάκτος',
    '9789603823166',
    672,
    'Ένα κλασικό μυθιστόρημα του Φιόντορ Ντοστογιέφσκι για τις πολιτικές και ηθικές διλήμματα του Ντμίτρι Καραμαζόφ.',
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
    'Το Αφεντικό των Μυρμηγκιών',
    'Εκδόσεις Πατάκη',
    '9789601610871',
    176,
    'Ένα παραμυθένιο μυθιστόρημα του Μαύρου Σεληνοφώτη για την περιπέτεια ενός αγοριού που βρίσκεται στον κόσμο των μυρμηγκιών.',
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
    'Το Αντίθετο της Αγάπης',
    'Εκδόσεις Ψυχογιός',
    '9789604539832',
    352,
    'Ένα μυθιστόρημα της Κέλσεϋ Ντρέικ για μια γυναίκα που ανακαλύπτει την αλήθεια για την οικογένειά της μετά το θάνατο της μητέρας της.',
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
    'Το Βιβλίο των Χαμένων Πραγμάτων',
    'Εκδόσεις Κέδρος',
    '9789600423002',
    456,
    'Ένα παραμυθένιο μυθιστόρημα της Τζον Κόννολυ για ένα αγόρι που μπαίνει στον μαγικό κόσμο των βιβλίων.',
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
    'Ο Τελευταίος Μάγος',
    'Εκδόσεις Εκάτη',
    '9789604253171',
    384,
    'Ένα φανταστικό μυθιστόρημα του Τζον Γκρίσαμ για έναν μάγο που προσπαθεί να σώσει τη μαγεία από την εξαφάνιση.',
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
    'Η Κόκκινη Πύργος',
    'Εκδόσεις Πατάκη',
    '9789601637113',
    336,
    'Ένα ιστορικό μυθιστόρημα του Σαντρό Λεμπλάν για την επανάσταση των Μποντουανώ στη Γαλλία του 19ου αιώνα.',
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
    'Το Στίγμα του Δαίμονα',
    'Εκδόσεις Κλειδάριθμος',
    '9789602090424',
    448,
    'Ένα φανταστικό μυθιστόρημα του Έρνεστ Κλάιν για έναν νεαρό που ανακαλύπτει ότι έχει εξαιρετικές δυνάμεις και προορίζεται να γίνει μάγος.',
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
    'Ο Αστερίξ και η Λατραβιάτα',
    'Εκδόσεις Εστία',
    '9789600513364',
    48,
    'Ένα κλασικό κόμικ των Ρενέ Γκοσινί και Αλμπέρ Ουντερζό για τις περιπέτειες του Αστερίξ και του Οβελίξ στην Ιταλία.',
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
    'Ο Χαμένος Κόσμος',
    'Εκδόσεις Πατάκη',
    '9789601637045',
    352,
    'Ένα περιπετειώδες μυθιστόρημα του Άρθουρ Κόναν Ντόιλ για μια εξερεύνηση σε έναν απομακρυσμένο βραζιλιάνικο ποταμό.',
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
    'Η Πόλη του Ήλιου',
    'Εκδόσεις Εκάτη',
    '9789604253188',
    368,
    'Ένα επιστημονικο-φανταστικό μυθιστόρημα του Ρέι Μπράντμπερι για μια μυστηριώδη πόλη που ακουλουθεί τον ήλιο σε μια παράλληλη διάσταση.',
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
    'Η Κάστα',
    'Εκδόσεις Κάκτος',
    '9789603824972',
    640,
    'Ένα ιστορικό μυθιστόρημα της Μάρτα Στέφανοβα για την εποχή της Ρωσικής Επανάστασης και τη ζωή της αριστοκρατικής οικογένειας Ρομάνοφ.',
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
    'Ο Πόλεμος των Κόσμων',
    'Εκδόσεις Κέδρος',
    '9789600423170',
    240,
    'Ένα επιστημονικο-φανταστικό μυθιστόρημα του Χ.Τ. Ουέλς για την εισβολή εξωγήινων πλασμάτων στη Γη.',
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
    'Οι Περιπέτειες του Τσαρλι και του Σάμπλι',
    'Εκδόσεις Ψυχογιός',
    '9789604540524',
    336,
    'Ένα παιδικό μυθιστόρημα του Ρόαλντ Ντάλ είναι ένα κόμικ τρυφερής φιλίας μεταξύ ενός αγοριού και ενός κουνελιού.',
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
    'Ο Στρατηγός των Σκιών',
    'Εκδόσεις Κλειδάριθμος',
    '9789602090462',
    544,
    'Ένα ιστορικό μυθιστόρημα του Ζήνωνα Σιαλέα για τη ζωή και την πολεμική πορεία του Αλέξανδρου του Μακεδόνα.',
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
    'Οι Περιπέτειες του Τομ Σώγιερ',
    'Εκδόσεις Πατάκη',
    '9789601638684',
    320,
    'Ένα κλασικό παιδικό μυθιστόρημα του Μαρκ Τουαίν για τις περιπέτειες του αγοριού Τομ Σώγιερ στον μισητό του θείο.',
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
    'Ο Πορτραίτο του Ντόριαν Γκρέυ',
    'Εκδόσεις Εστία',
    '9789600514576',
    352,
    'Ένα φιλοσοφικό μυθιστόρημα του Όσκαρ Ουάιλντ για τον νέο αριστοκράτη Ντόριαν Γκρέυ και την απελευθέρωσή του μέσω της τέχνης και της αισθητικής.',
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
    'Το Νησί του Θησαυρού',
    'Εκδόσεις Εκάτη',
    '9789604253140',
    320,
    'Ένα περιπετειώδες μυθιστόρημα του Ρόμπερτ Λούις Στίβενσον για τον νεαρό Τζιμ Χόκινς και την αναζήτησή του για έναν θησαυρό σε ένα απομακρυσμένο νησί.',
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
    'Η Μυστηριώδης Υπόθεση του Στύξ',
    'Εκδόσεις Κλειδάριθμος',
    '9789602090486',
    416,
    'Ένα αστυνομικό μυθιστόρημα της Αγκάθα Κρίστι για τον διάσημο ντετέκτιβ Ερκιούλ Πουαρό και την εξιχνίαση μιας μυστηριώδους δολοφονίας σε μια απομονωμένη έπαυλη.',
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
    'Το Μυστικό της Προδοσίας',
    'Εκδόσεις Ψυχογιός',
    '9789604536381',
    480,
    'Ένα ιστορικό μυθιστόρημα της Κατρίν Ντελάρι για την εποχή της Γαλλικής Επανάστασης και την αποκάλυψη ενός μυστικού που μπορεί να ανατρέψει την πολιτική κατάσταση.',
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
    'Οι Περιπέτειες του Χάκλεμπερυ Φιν',
    'Εκδόσεις Πατάκη',
    '9789601638721',
    368,
    'Ένα κλασικό παιδικό μυθιστόρημα του Μαρκ Τουαίν για τις περιπέτειες του αγοριού Χάκλεμπερυ Φιν κατά τη διάρκεια του ταξιδιού του κατά μήκος του ποταμού Μισισιπή.',
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
    'Οι Σταχτοπούτες Πεθερές',
    'Εκδόσεις Εστία',
    '9789600513777',
    336,
    'Ένα μυθιστόρημα της Μάριας Στέφανου για μια ομάδα γυναικών που αναζητούν την ευτυχία και την αυτοπραγμάτωσή τους μετά το γάμο.',
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
    'Η Περίπτωση του Υποδικαστή Φολς',
    'Εκδόσεις Κέδρος',
    '9789600423125',
    416,
    'Ένα αστυνομικό μυθιστόρημα του Τζον Γκρίσαμ για τον ντετέκτιβ Άλεξ Κρος και την ανακάλυψη της αλήθειας πίσω από μια περίπλοκη υπόθεση δολοφονίας.',
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
    'Ο Τύπος της Κυριακής',
    'Εκδόσεις Πατάκη',
    '9789601638240',
    336,
    'Ένα μυθιστόρημα του Νίκου Αθανασίου για μια δημοσιογράφο που αποκαλύπτει ένα σκάνδαλο στον κυριακάτικο τύπο και βρίσκεται αντιμέτωπη με τις συνέπειές του.',
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
    'Ο Κύριος Νόρις Αλλάζει Τρένα',
    'Εκδόσεις Ψυχογιός',
    '9789604536992',
    272,
    'Ένα αστυνομικό μυθιστόρημα του Κρίστοφερ Ισέργουντ για τον ντετέκτιβ Γουίλ Μπάντερ, που προσπαθεί να λύσει μια υπόθεση απαγωγής σε ένα εκκλησάκι της εξοχής.',
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
    'Η Παράδοση της Αντιγόνης',
    'Εκδόσεις Κλειδάριθμος',
    '9789602090431',
    480,
    'Ένα ιστορικό μυθιστόρημα του Μανόλη Γλέζου για την αντίσταση και τη ζωή της Αντιγόνης Καλλέργη κατά τη διάρκεια της κατοχής.',
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
    'Ο Μεγάλος Φιλόσοφος',
    'Εκδόσεις Εκάτη',
    '9789604253034',
    288,
    'Ένα μυθιστόρημα της Έφης Μιχαηλίδου για τη ζωή και τη φιλοσοφία του Σωκράτη, καθώς αυτές εκτυλίσσονται μέσα από την περιπέτεια ενός νεαρού αγοριού.',
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
    'Ο Ναυτικός Υπόλοχαγός',
    'Εκδόσεις Πατάκη',
    '9789601638660',
    352,
    'Ένα ιστορικό μυθιστόρημα του Πάτρικ Ο Μπράιαν για τον ναυτικό υπόλοχαγό Τζακ Ο Μπράιαν και τις περιπέτειές του στα κύματα του Ατλαντικού.',
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
    'Οι Περιπέτειες του Χάρι Πότερ',
    'Εκδόσεις Εστία',
    '9789600514644',
    320,
    'Ένα φανταστικό μυθιστόρημα της Τζ.Κ. Ρόουλινγκ για τον μαγικό κόσμο του Χάρι Πότερ και τις περιπέτειές του στο Χόγκουαρτς.',
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
    'Το Στοίχημα του Δικαστή',
    'Εκδόσεις Κέδρος',
    '9789600423064',
    384,
    'Ένα αστυνομικό μυθιστόρημα του Μίκαελ Κονέν για τον δικηγόρο Μάικλ Χόλμπεργκ και την αποδοκιμασία ενός φόνου που έχει εμπλακεί μια κομμένη χειρ.',
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
    'Οι Χορευτές του Μπαλέτου',
    'Εκδόσεις Ψυχογιός',
    '9789604536251',
    352,
    'Ένα μυθιστόρημα της Βίκυς Μαρκοπούλου για μια ομάδα χορευτών σε ένα θέατρο του μπαλέτου και τις προσπάθειές τους να επιβιώσουν και να εκπληρώσουν τα όνειρά τους.',
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
    'Ο Ανεκπλήρωτος Έρωτας της Σαρλότ',
    'Εκδόσεις Πατάκη',
    '9789601638646',
    384,
    'Ένα μυθιστόρημα της Μαρίας Τολούση για μια γυναίκα που αναζητά τον ανεκπλήρωτο έρωτα και την αυτοπραγμάτωσή της μέσα από τις σχέσεις της με τους άντρες στη ζωή της.',
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
    'Ο Φάντασμα της Όπερας',
    'Εκδόσεις Εκάτη',
    '9789604253492',
    320,
    'Ένα ρομαντικό μυθιστόρημα του Γκαστόν Λερού για το μυστηριώδες φάντασμα που κατοικεί στην όπερα του Παρισιού και τη σχέση του με μια νεαρή τραγουδίστρια.',
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
    'Ο Αμερικάνος',
    'Εκδόσεις Κλειδάριθμος',
    '9789602091278',
    400,
    'Ένα ιστορικό μυθιστόρημα του Μάρτιν Κρους για τον Ρόμπερτ Ντε Λα Ρόσ, έναν Αμερικανό που μετακομίζει στη Γαλλία και εμπλέκεται σε μια επαναστατική οργάνωση.',
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
    'Οι Αθάνατοι Έρωτες της Αλεξίας',
    'Εκδόσεις Πατάκη',
    '9789601638523',
    336,
    'Ένα ιστορικό μυθιστόρημα της Αλίκης Μιντ Ραουφ για την Αλεξία, μια νεαρή γυναίκα που αναζητά τον έρωτα και την αυτοπραγμάτωσή της στην Κωνσταντινούπολη του 19ου αιώνα.',
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
    'Η Εκδίκηση του Μόντε Κρίστο',
    'Εκδόσεις Εστία',
    '9789600511896',
    624,
    'Ένα ιστορικό μυθιστόρημα του Αλεξάντρ Ντιμά για τον Έντμοντ Νταντές, που επιστρέφει από τον θάνατο για να εκδικηθεί όσους του έκαναν κακό.',
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
    'Το Απαγορευμένο Βιβλίο',
    'Εκδόσεις Πατάκη',
    '9789601638530',
    320,
    'Ένα μυθιστόρημα του Ντόναλντ Ρέι για έναν μυστηριώδη συγγραφέα και το απαγορευμένο βιβλίο που αποκαλύπτει μυστικά και σκοτεινές δυνάμεις.',
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
    'Η Εραστής',
    'Εκδόσεις Ψυχογιός',
    '9789604536985',
    432,
    'Ένα ιστορικό μυθιστόρημα της Έφης Μιχαηλίδου για τη ζωή της Φραγκοφονικής Αιγύπτου και τη σχέση της με τον ποιητή Κωνσταντίνο Καβάφη.',
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
    'Η Κόκκινη Πύλη',
    'Εκδόσεις Κέδρος',
    '9789600423071',
    400,
    'Ένα αστυνομικό μυθιστόρημα του Ίρβιν Γουόλας για μια ομάδα εγκληματιών που σχεδιάζουν μια ληστεία σε ένα αποθηκευτικό χώρο μέσω μιας κόκκινης πύλης.',
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
    'Ο Πλούτος των Εθνών',
    'Εκδόσεις Εκάτη',
    '9789604253942',
    736,
    'Ένα οικονομικό βιβλίο του Άνταμ Σμιθ που αναλύει τις οικονομικές αρχές και τις αντιλήψεις για τον πλούτο των εθνών.',
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
    'Η Άσπρη Καμήλα',
    'Εκδόσεις Πατάκη',
    '9789601638905',
    352,
    'Ένα μυθιστόρημα της Ειρήνης Καρύδη για μια γυναίκα που επιστρέφει στην πατρίδα της, την Ελλάδα, και αναζητά την αποδοχή και την ευτυχία.',
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
    'Τα Παιδιά της Λυκανθρώπου',
    'Εκδόσεις Εστία',
    '9789600513371',
    352,
    'Ένα φανταστικό μυθιστόρημα του Κώστα Χατζησάββα για μια ομάδα παιδιών που ανακαλύπτουν ότι έχουν υβριδικές δυνάμεις λυκανθρώπων και πρέπει να προστατεύσουν τον κόσμο από τον κίνδυνο.',
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
    'Ο Πόλεμος των Κόσμων',
    'Εκδόσεις Πατάκη',
    '9789601638653',
    400,
    'Ένα επιστημονικό-φαντασίας μυθιστόρημα του Χ.Γ. Ουέλς για μια εισβολή εξωγήινων στη Γη και την αντίσταση της ανθρωπότητας.',
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
    'Το Τατουάζ',
    'Εκδόσεις Εκάτη',
    '9789604253416',
    272,
    'Ένα μυθιστόρημα του Φίλιπ Πολ για μια γυναίκα που αποφασίζει να κάνει ένα τατουάζ στην πλάτη της και την επιρροή που έχει αυτή η επιλογή στη ζωή της.',
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
    138,
    'Ηρωίνη',
    'ΛΙβάνης',
    '1234567890123',
    240,
    NULL,
    NOFORMAT_WRAP(
      "##X'ffd8ffe000104a46494600010101006400640000ffdb0043000201010101010201010102020202020403020202020504040304060506060605060606070908060709070606080b08090a0a0a0a0a06080b0c0b0a0c090a0a0affdb004301020202020202050303050a0706070a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0affc0001108017700fa03012200021101031101ffc4001e0000000603010100000000000000000000000506070809010203040affc4005010000102050302040304060606090109000102030004050611071221083109134151142261233271810a15194291a1162433525692175393b1c1e118344346556272a2d12539546366738283b2b3ffc4001d010001040301010000000000000000000000010204060305070809ffc400431100010302040304050808060301000000010002030411050612210731411322516117719192a1142332334281b1e1081553547293c1f034445262d1f11643d282ffda000c03010002110311003f00bb9d2bff00aa8fc2178d773f8c20b4b88430107bc2f5a182626d67d62d5d2f25bc08102229e4a6b79a10204086d8a7ae734b6db677bb8d99f9b3ed1cd254a01442569482720723da3b3e70d28ecddc72903b888c1e26bacf7e684d836b5ed645c73529e75d5272f37272c905c98694ac29081eaac438724c77352650a494179b2738c85b83b7d23281f6690b6d2af30e5c527b7e311e3a4ed5cae6a8b572eb4dd9a875296959271c6ffa23504a10a946dbece2c77055053a13d456abcd753753d3fd616d2d512e99213363968fc8a4eece09fef607610a9149e50090371290783b4f681b90eacb29737797f7863907d0c418a66b8eb4d475e750f491178579025ef04c8d32ade5a3e064b8070f2b3f28c4383d72f519ab1a4768d0e5b4b2b2d3f3d474b553b9e65bc28bb2ad6038d8c7aabb8fa4085295b53aeb79f34104e3736398cb4b42947628909247d09ffe622cf51baa9ac97d69e589abdd33dd486e6aa323f1f334f4ac6c996d280b5b2067fb4e4a71ee212955eb62ab54b5af5d77b2ee29f5ce5b16bb299fb39d680548ce6085adc4f71cc1b94854d205696b702324f191c260653c82a2a0a39007a08adf578826b65a5a69a5bab4e53ee57672eaada1bac49cfcb244acc36b56dfb0c72719cf30e3cef51bab746ea1b562c8153ae4c4951ad5f8ba6093692af8571480af9f3db1985b1080a6c80e0f99b593cf651e08fa4637251f3a9df9547042bd0fb4421b63507a86b9ba47d3ad59a56a455262ab337206aa322128f36625cba42bcb1ea401fce248f4eb257649cc55dabab52ff5e79cf07599575492f496e39d8b0380a1ed089539cade09f2c20280c73ebf48d56b504256a40271f2a71cee8875a1b35addae7a97a9f68ca6b4d4251ca15c9b29e8c27cb6db0e8dc93eb9c423a77597a9d7f5cf54b4bec1bc2e1abd568cdb668025d8429941de90ade7d38cc0853e3785957c8aca3828f78c93bd4ac27940e306228d817d6b84cf5b325a457b6a23e84aac054ecdca321384ccf00ff0e4fe50c7da3d51ebeb3a692f772aefacbf511aa3faae727271b48926e4fe20a4ee50e42b1da042b1d195252b5a159c1f949f58d5d7d0d33f15320a1231918e418891d69754b7d5817adb950d2faf898a250a71955e0fb6720b4f1001463b81eb9852ebb5c5a9952d63b26ebd30d519855ad74d3d6d542424d4829651e5e5333c9e013ebf4810a491c3ab2db980739007efa63b8edda103d3ccb57e434c64e9f745ecd57a699794815265414143270323be042fa04210204081084081021879a78e4b0bedf9c653d87e118706060fbc653d87e10f58ee01b26fb4cbee8fce17e8eff942034d78c010bf4772625558f9c50e9792da040811109b29cde68408102006e9c4d9614a29190927e821b6d77e9b2c7ea199a549df2a743344aa353d4e4a79fb641c8cfe70e4a921492924f3ed182ca1492923b8c7e10a9a4dca61eb7d07695d42efb82f990aa54a5a76e265b62aad32fa92d2d09f64838cc282ede9274deee9db3a7e726269a99b21013447d97885292076563bc3aff0e8ca4e55f28200cf7fc60061b01200fbbd8e604898b9be84f4ae6c5ca899aad431765444ed59c65e50509803014083ec21416e749ba696e9ac2b73f342b74cf829c54f28b9b5909da40dddb3ef0eaa996d695248c050c1c400d20673c85770604263ad0e87b4b6c366df97b7eaf3f2ed5bb3aa98a51332a292a52b252539c6215527d2fe89c9de374dee8b2d84cede528997b8dbc6113494faed1c67eb0e299564acad49ce71c1e40c7b7b46fb13c64671d898374269a8fd23e8e52dfa6bb3b48f8ba7d11cf36892534a25b915678da0c067a45d2945ed75decc333489cbce9c65aaea0f2bee1e38fca1d754bb4a512b4e414e0a4f23f846f803b08374264e47a20d2390b168762d2e6aa2ccb505c5ae45689a5821c51ceeef0a2d10e9cb4fb42a5aaa9b3a72716fd62643d509c9c98538a5399cf1bbeb0e425b427381f7bbc0f29bdbb0a063db102136fa5dd34e9c68ede570df967b6f373d71cc176a3e7b876adc27254235b03a63d32d35d5cad6af5b72f349acd772671d538a2820ff002872cb6850c2d215f88cc0280a0412707eb02136739d30698cc6b539ae4e35326baed3d724e388795fd92b39ff007c26a81d09e835b56fce5aa8a54e4d52672a2a9f9b9275f56d2f956e0b1f5061f0436840f94738ee7bc071a4b98dc4f07d0c084d1cbf47ba389b46bb67cdd157354fb925fca9ff0039d254db601da127be4412ca7409a1d2f2520d48cc55902468e29d2ee7eb0706c9619c0033df987dc36904e077ee2301a401809e3da04248e8ee8fda3a2363cad876534e990962569766660ad4a593dc930b01c8cc68a61b51048e07648ed1bf6ed02108102040842040810c3cd3c7241eeff9c04f61f8468f295ef012b56073e90ad702d05617fd61481d36ee217edfac2034f3d3f187011f707e1136b3eb147a56f75660408110c8ba980d90810204005904dd08102042a44204081021081020408420408102108102040842040810210810204084204081021081020408420408102108102040842040810c3cd3c725ca60ed19f7809fba3f08e8bedf9c653d87e10e02c2cb191775d37fa7a0a4807de17c958d8080781082d3fee3f185c29c534c9712338e48f789b59f4d44a57586ebb6f4951405723b88d1b9b977890dba0edfbd8f4865fac8eba3a78e87f4e9cd4bd7fbbd8a7a1082a939243a0bb30ac70903eb101adff19df11beae8bf5ee883a201316cb2fa8b15faabca693388078c678ed10d4db122e15b1879a52b6858c9ed1952b6a37ed27d80f58ab1b73c7fb553a77d4391d37f12be9627ac366754944bdc94f0a758c938192780331647a5bab1a7dadf64c86a6699dc92d57a2cfb69765a7a5df040c81c1c7e3020036dd2a4bed856dce4e7b0f48c97407435b4e48ce71c4428f115f111eabba34bb7cbd25e8d1cbe2df453173953adb734b4b6c6df7238ed10db463f49fba8bea12f73a6fa37d06b759aca4a96ec9b153595a528fbc30204d172ae79c996da195823040ed190fa09c007ef11dbd62afdbf18ef12e5b876785ad4d182a2479ce94e7d39868b5abf49f3a8de9c2e96ec7d72e859143a9bd2e979b666aa2b428851c0e0c096ce5738dcc34e1d893f301ca0f711bef49c807247a08839e1c5e247d57759f76348d51e8d55645a33d4754d536e154e2d42655e839f7ff8c353d6a78cff005bdd205c35fa9d6fc3f13376750e74b2cdcaed49684bc8e70bf6ed022ce566eb7d091d8927b240e6325d095252a046ef53e914f1d3afe91bf57dd59373f3dd3cf87eb7734b52ca53507e46a4b5fc3eff00538f68b59d22bb6e8bdf4b6dfbaaf5b60516af53a7b731354a2e157c3ac8ca9249f68126e39a569986d2952d676a5270498097c294a1b15f2fa91dff0008843e231e377d3cf4355a6f4be85266f0bf66c86e5adea72b790b27001dbf5861697e21fe38f7a4bb3aad6c743b26d5beeb7e6b7499b99521e28c67b77e4409c5a6d756b2a75291b959031924f6100bcd84798a5613fde3d8c576746be3fba3dacfa97ff476eab2c599d2dbf7cf0c7c054b2961e5e7180a57b98987d50eaaea3e9368455b54345b4dd37a5764da42a99439778e2610afde053df881259c9cf2fa000a48241f61e9ef003edad056d1df8feefac529eae7e942f525a11757f41f577a1b6e8f5c613b95213d505b4b5a4920601ee225778787899f5add625ff464ea4f45ccda96355e503d2771b35152c0cfbfa408b394fa727d968a92b4a81070918e57f87bc6e2612a25212ac8c6463de2bbbc47bc577acde87f50ab62d3e8d137258b4800a6ec5cd2928008ce49ed0cc74cbfa417d747570d2e7f433c3f135aa7b0e06e6aa889e584151f40471021a1c42b77336da561b712a4e7382a11b87904809c9cfac5357517fa475d61f499702681adfd05a68695ad425a627679610e1f4c130f4f873f8c575a7d756a05bed3bd164948d8b569c5cbce5dd2d5452c30a48cec23b71022ce56562659f55639e33eb192f202b67757f74778ac2f11cf1aceb03a08d51adca557a346e7ec9969ef85a5dc53538a6d0f719c83d8c77f0f3f19eeb4fae4d47a1cb52fa17553ec7a82b6bf7699b594a79c1efc408b3959b1707eea4ab8f48c29f42101c5e5391d8ffba3cee960a94da77a56bfde493b52a8643c437ac3a2f447d25dcfafb51710e4d53654b74d97788497a63b0c03df981259c4dbaa7dd3308504fca7e638edda321c1b379411f43de217782a789acdf895f4df317dddb2f2f2373d22a0b627e4104056c0785e2267e5632b57f77b425827779bb159716008ca5630383da3477eb194f61f842ac7a8a44584da014e0429ae4adc85b9409cb8aaae6d96a74b2e61e20e3e54a49ff8426ac3e1490609fac67e7e57a56d417e9aa525f45af305a527b83b4c4cacfac5160035597ce1f555d40df1e2ebe2cd49d3fad559e99b67fa5edd3a9d4d0b2180c21cd8af97b13c778fa5fd0fd22b574274b693a5965d325a4a9f48916e5d0cca32103294e0938f5fac7cb47832210ef8ae597fac1cf3152f5f9970a0f254e1789cff0018fac05a028af67c8a272a1e910d6ce6ee0006ca28f8c3f47567757dd13ddb45af5bed4cd5a8f4d72729532a48ded9402a3cfe022ad3f45efafeb92c6d6fa8f447a81733d3547ab2166812930b2af26652e11f293e981da2f375c112afe905da2717f22ad79d0e27ff00e1547cb3784acf5468de2d1634cdb89504b77a3ed6e6c6728debe3881243de69bafa77eb20ece957515b6d478b5a6b207607611c7b4502fe8baade77c532aee3afad67f57d54614ac8fbc62febac44b89e93f50c2d5b946d59a2b23df62a2813f45c88fda93581919f81aaf19ffcc60447c8afa492e3ab633e691803b47ce67e9603ae27c446d4405612bb76477a47627cd1cc7d18a48f87efed1f399fa583ff00da29690fff002e48ff00fea20b00b0c2e26600abd2f0fd5173a2bd362e60836bb3f291c0e076860ff486dc73f65fdf2a0ea86cd8538ffd27ff00987efc3eb3ff0042ad35c8ff00baecff00c2182fd21ce3c2f6fb27d93fff005813c93db10a187e87413fe8ef545c46104ae44908180491de2ca7c50bab494e8bba2fbb75b04ca5b9f969032f4b27ba5d58da088ad5fd0e720e9c6a8e140fcf21d8fd21ebfd2ae99aba3a059294927d68967eb09137b7b10950233089cf00cc1bd1420fd1c8d03475c1d74dd5d516bb2155c9aa23667d0e54cf9a10f297c0015d872388fa24014864aa5d6425230da11809007a63da291bf4401b9572dfd4d9d52438fb8fed51f508c8e22eed9d809435c049c110a89890eb05493fa57dd29db16b50ed3eb12caa32242b289e44b4ecf498d8a2e9236ab23d625bfe8f4f5eb59eb4ba396a857a560ccdcf666c92a84c81852d91c379cf7381de117fa53f2d4e5f86b7c72d5b9d62ec952ca4fbfae2234fe8834dd6c5735718daa449badc92f00700e4e6040faaba92bfa465e19e9eaa34197d45e975b1e6de368b2a7279c9547dacdca8e024639ca7be6187fd1a4f14871f68f40dae1722d5392aa50b69d9f5f285038f2727b9e22e86a925235195548cdb1e73132da9a79850ca5c4286140e7e998f9bef1b6e876f5f0c3eb3a95d556883aaa7dbf55aafc750952e76e26f76e2d9c7a77e21c0022c9223da6dd5585fe90e75455eb96896a786ce8739f11796a4d49a6e7d12e37096952ac2b72476f539fac4d5f0fde8f6d1e88ba5db6f43ed1a7332cf49c834aaa3c840def4c14fce4abd79cc5697806e90ea6f5dfd4adc5e2a3d507f589a0da24edb9274ee44b948c6e4e7f0cf1172a95210497564a8e543ebeb0c44b78c69515fc58fc3e6cff108e99eaf65ccd0d0bb9e972ce3d6eceab0149700ec4faf6ed14e7e097e225a83e18fd53d47a35ea62ab35296c4dd4d72934c4e12112d30158f884e7ee83c47d193ebca90a2b095819db8e08f68a12fd2a7d0ae9caded60b5afcd3e9d12fa875b68a6ad45a7232b530394bc4279049f58700922901ee9e697bd77eb35e7e375d7ad0fa04e9e26de9ad2cb12a0dcfde95f6b2a6e6f041284afb0e388b8bd13d19b174174d691a53a65416a9746a3cab6ccbcb30909c948c152b1dc98a84fd14fea63a76a75ad7274f335496699a893132669f9b9a23cd9c6bb6c0a3ca8fd22ea50b04607a42b92c97659ab499c068a500679c27b02629f7c7d6e0befae6ea8ec8f0bfd119d2a9b6a59cab5c28655903e50a6c2b1db9116cba9b7bd2f4dac4ad6a0d6dd6d12b45a63d3aea9d56120369262a3fc15f52f47b573ab1d5ff116d7cd51a1ca552b55a769d6ca67ea0da16ccb36bfdd0a39008f586a6b2fab51514bc0475fee3e863c4f2b3d2d6a64cfc34bd7a797489c43876a04d2067701e91f472c14abed82b858ca467d23e65fc782cfd3ed07f11fa77535d396a6d3e7e56b532cd543f499c42fca9cf3029c0761e3e5063e82fa16ea3285d51f4a764eb5d1e612e8abd1da4bd8564a5c480956ef63907bc0b2cd670d413bcf4653d87e101e1ce00809ec3f08160b0487b1d07e204292f2b6e9d775b13d69d5c665ea728b967463d14923fe309fb292944c80442d5c49523295608f52224d5fd628d4df44af969afe93dc1e167e3234a46a453dca7d364af844d53aa852421e9275d2b5a41edd888fa80b42eda25f16d53ef2b6a684c4855e5513328e83b9252a4e41e2237f898f8566847891e9e7ea8d40963255fa732a346ae4aa3ed50e63e50a3ed9884fa41a27e3d3e1cf495693697ccd0351ed194f9692ecfcd294b69bf44fe207a4465b190b5ed014f7f13bea32d5e99ba32bdf506e89e6e51d7e90ec9ca871601754b494f00fe314bbfa327d195cfacfd604ff0054970506665e816b7993720f291f653134a70f0091cf0624fde5e175e29de29f7853a77afbd4b92b5ac695990e3b6e51df254e23bed23f9459f74afd2a693f47da474dd15d15a1374da54824296529f9df5e002544f27388135a7b369f35cbac1521ae95750df415a52ab5a6ced03b7c8ae62817f45e9294f8a8560ed69d2990aa6d719078049ef16bfe279a2de2bdad970ccd99d1dea05b94db2ea94b5cad5a5aaceec7965430401edf58afce94fc09bc60fa31d5c77597426fdb2e42bf30c3c875d5ce9dab2e1e739812c25ba4ea3657ce1044ba52e1dff37703b47ce7fe95e90e78895ac81b92b4db92412b238fed445d4d0ad0ebedbe875cb6ebf7451c6b42a5ca535465dcca79807073ed1549d5b7819f8c5f5c5a992da9dd455ed65d62a92324862597f1a5094a90aca4829f6e2058e06b1b28255bff0087ebde5744ba6530b75451fd14640de39fa7fc6185fd21969c5f85d5f682852945a052483b47cbeb04fe17fd3c78b468056e474ffaa7d47b767ec4a4514cac8334c742e652e0fbbf2ff7471cc347e223d0df8da75753174692c86a8da5fe8e2af37be9f2cecc61ef2c6404ac0edc409c433b626fb267bf4391b69ad3bd572c290e1f329c08601e3e539ef1635e2e3d27bdd62f42b7ae9452e9a899a8b925f154d18f9b7b5f3e07e388adae893c1f3c6d7c3ed9acd1fa70d49b229acd7d4d19d0e4e93bf6fe3da2e5f43a475329da4f42a66b0cd313574334e6dbaf3ecff64e3e07cc53ee926044c18640415449fa2d7ad12ba01d59df1d33ea68347abd7654cbc8c94efd9e26d0bca88071dc08fa010f29256832ce95b5f70ede5c1f48ae2f131f01ca3751ba9ad753dd28de22c9d4b9698f886661b596585b80e724a7de1054ebabf4902cba0a34a5cb7ed5a8bedb21894b916efcfc0da14aff007c22476923748bfd2c6ea2adc6b492d1e97e915143f58a85491393124d2829c1b4f09207bc3e1fa353d155cfd30746ceea65f522b97ad5f733e6bb28ea08534c209f289cfd2119d2678046a76a06bdff00d2e3c4d7553fa5d74f9a97a528d2cbf325d939ce39ec22d3a8b4696a25319a4d3651a969796612c4bcbb29c25b6d2309007e1025d5a63d21772b3e5acad9e13e83b927d62a27f4bb1057d2669fac30e94b5782c9da3d3ca316c17fc95d53364d5256c99d12f597645c453a6943210f6d3b0a87b67114e5d69f84b78def5d74093b1f5f757ecbab5229d555cccab2274a76a4e427b7ae310f0b1b0fce025487fd180754af0d4a5a834e1db5150ca07ca798b1d7548243b9e53c6d8a85e847c34fc6efa2b90a3698d8badb684bd9b2b5343d51a6fc4f2b6b3c84fd7116c35e95bc9fb09f95a53eda2b8aa51432efee266b6602f3edbb986a7ca439db26ebad0eadb4cba31e9febbae3a9b56665114a9171c90939a7005bee8190123b9e62b53c1d3a39b93c413576eaf147eb3a49daa4a5d2f3f2963d2a7c6e6e5a50e40525272071091eb23c173c693ae4b9a695af3afd6bd628ecce3aaa6d28d4548692d13f20501ea044a0f093e89bc543a31ac53b4d75db552dda8e98d35828628f4e7429c6558e0207b409cdd2d6ec555b789d747bac9e0e9d7bd3ba8dd0b929a6ada9daa8a9d1aa49044bca92bf99a247d33c18be5f0f3eb874ebaf0e9ca8bac5635550ece2a5108ae4920e54dbe000a38f62727f3884de29fe1a1e2c1d7b5df5db0a9daab6a2b4cdcaa7c65b74ca83a12fb3c6362c8190310cff0046fe0c5e363d09b9368e9e35fad3a349d47febb4e137e6343ff485409496c94f627752a3f487faa49bd2fe9524fa70b1a780ba353eb12f4c6da43985a255c56d70f0723884de85fe8d8f42ad68edb2abce5abaaabae8ac3b5571b9c5a50e2ca771002481dcc468ea2fc0e3c67faabd59a76b1eb26bf5ad3d58a23e9728cf7c7901920e73b4700c589f86768f7894e93b555a4f5d5ab146b8e45a93698b7514a702ca36f077fb71026f76366ca1278a57e8f6f4cba75d1ddcbab9d38d3ab5faf6832c6704bb8f29c52daec40ce7b417fe89f7588ed5ec9ba3a42bce7db150a6cd2a7294d38a3e61693f294807eb9ed134bc4eb413c4f75b2aac5bbd13eadd0e8d6dced38cbd7a4ab05290e6ec8504fbf062ba3a7efd1e6f166e96b54dbd65d14d6fb5642e04b854e4efc660b8952b7292476c6498139afed2321db2be25bca49da4a50b3f74287a40f8c911c29f467d783085e99e83ad96e68ad1693d41d764ea777b2c91589b9356e656e13dd27d617df0f9e770ff0028816148cb3bfeb62168a5a5091bc7048108cb3402e873d6168dfcc391ed126b3eb146a5fa2b5592d80109c83de3284a1bf9c2ca723ee83c7f08d88071f48d14e14b8b4940e065049fbdef81116f752c6cb0e4b87c65e5efc1c80956311b8e3e6708cc725bedb00be5bc2481950ef93f48cade46f4952b857012064e7eb0a909bad940ef2b5b49c01c1c64c06d01433fef4c6a5c0d3894aca94a50c71db31b0716707033fbc807388122084fce42944abdc8e3118750940cadd007b623256b0a385839e00c768d12fa1454dad255e58f9d451c66042cf96db6af88512a5118dc07a46ca42d6ae1ec646424a63520b85285038c6ede93803e9004c07021684120e49278c01021676646d71593ee531b23206ddd9f6388d16b56cf99c48ce76b99e3e9c7ac043a5294b4a565453c2c0ee7f0810b67d4da53871b0afc466036da9b6b6a56a51f42a301b709404ab9514e4646331cdc7939502bc240fef7255ec3de042d9b490f65c6b0a23ef031da3936b525041491ed93924c616fa996825e5616ac80a03201f4810ba9c0e707f28d1492b38695b0ff00e98d158050dbcf28b8ae3281c123fdd194bee0c853473bb090159cfd7e90216c034a46e29ce3d76c652b4a86edaa1e9c88d4be10d798a20606558ed18335b5292e20a4afee8cf7810b748681f95b193ff9630507ee255b4f72426021d2a51008271f733c8fc602373c921d4a90a3d921502502e865215b1682a38fbc530360cf0e7fed8c210f96820af6a80ca959ce0c04ad7bca57b529c8d8b073b87ac174ba4a0a471c3c07d4a63213b065053f5c003318696e2d04cc4aec3b8e139ce47bc6c9054a292a038c8e212e8d2564a7f2fca063ebff00b632d6140edcf0ac1cc6f841f5305c24d25720524f9494edc7d2079c13c63b46db46edd8e630594139c41a825d25232ccee3f1859b5dbf2845593dc7e30b66fee0fc225567d35129792c93804888f9d5475db6cf4afad96469b5f961542624af49bf83a6d6e59c01b65e240215ec067d6241abb1fc221f788f74f1aa1d4d5fb41b06d9b254ed3da907dd66ba0712b341396ce7d30a886de6a61174a56fc4af4d0f5417574ef2f6bce298b2a842a55cb914f02c04edced1ee635b57c46a895472d6addd9a5753a0db77e4e2e5ed3ae4c4c24a671c19c0207ddce3d6233e88f878750d4fd52b8ed1bea84e1a65db62b74aaa5d84f2275b04e73dce4e21794ce9335ef54aced2fe9b6ecb45ca652b496a9f12fd7d4709a8946eda13f8e7d21e934a59a7c5769545ac57dabb3472a74fa55b173b745a8cf393cda94b71c194bc123929c7a08f36adf8c768d699eae512c0b5ac1ab5d549aca038bafd23e56a58faee27bedf5c7684ff00493d064f55b5cb52aeeea7349f7cad5ae044e5b8b9851d812da0a0398ec4fe30d46b2786b7573a75acf6f5a7d3b5369f55b1249c9ef357504e56c3738bdce007e99fca046952e2e9ebfe8b25acd65e9458561ccdd12d7c4b3af536a7233094a10b6d3b96d9cfaa7d613d6978a0d937c51751d346b2ea1fd2bd34ab191a9db0e3c12b795bc2728cfdfefe90dc48746dacda11d47e92ce697da4aaedad654acfccd5675e512b4cd4cb78d88fa03095bd7c3c7a80d68b12bfa8d6cd23fa1ba8c6fb33ec4da0ec13d245632973fbc7683de04694ff00db3e223395bd5e5e8dd4b4727a9d53fe87aee26d3375269b05948fbb951009e3b42efa3feaadceacf43dad6da769ece484b4cbf32cb12ce3e93e6165c520e3f1293cc468bdba2dd47bdfab95ea45fba40dd6ede91d33551650f9cb41f8d29fbd949191bb9878bc307497573a79e8dd8d2bd48b4112554a3cf4f2e4e51a27e66dc754a40e7e84421e480d48e7fc59a908d13aa6b033a3734b4d32f416f09133ed87039e6f97bb667763f28516a2f88bd674fb5326f4de6344e756f48db6cd6a7aa0a9e6d0db52eb1b8a4051c9501ed114e6fc3775e66b46ee097568a855e73ba9cdd684f8755854987f7e36e719dbf487c6add27df9ad1d73d2350b56b48d6f5a06d696909852d6a4a52eb49ecac1e466135234a5cda3e26f6ceaeccb6c74efa6556baca2df15ba9243a1b32ac64a4a0eef51831c95e27b6957e4b4eee0d3fd2fa85664affaa9a7ca3897920d3a6028a541ccf7c107b4309aafd2f75cda41d445df76747ba754a94a1d6e9aaa4b685a4a4791ef811cf497a3aeaf2c7b7749680de95c91fe855ec2af543ce160e4abf99835234a91f41f122b7272ff00d48d18aa69fcf4bde76048aa6d74e5bc948a932064ada278563d864c6b4ff111ac2f576c9d24b974527690f5ef437aa34f7e76a0da061b46ec124809cfb1869b59ba25d71ea858d48b9136eb365de827d33165dc72a76a9481ca9827f7828fa18efa89d1eeadea2f527a49756a26954bd7adfb3eca724ae5982ead2b7a7d6d04ee1b48c7cded0a0dd1a5484e907abc7fab2b56e9baa95a7f354997b72b7314a097a612b334fb3f78a48e3078c186f74d7c5574defb91d5b72ad63cfd1a77499d77e3a9b30e0f32752807947be71e903c32f40b54fa6cd2cbeb4faffb39aa6b331764f54e8cda54485b0e8fb34127d4188f75df0f9ea66eed43aaeb026db6e9afd4aa530dd7e903813d28a4282091ebc9079854694f4d1fc577f5c74eb62f5232da0f5396a2df95afd5d252d373884a924a8a42893c27241ef0693be2a560db165cf5cda83634f5267115e629349927e6125b997dd38414afee900f723810c2d5ba20ea66e2e85f4d7a65b974bd87cdab759a8569a69446f603ab5276e3b70a038f68f4dede19dacdd40e894b58f74d05a90a659d72cbd42daa3ad442a66592adceb24f7255db24c36e8d2a5468175d9a7bac7aab70e8656e58522eab6e41a9d9f976e6d0ea5e697d8a4a091c41bf4b3d6d69d754f3579d22d99298a74d59f597a4a6a56695f3badb7ff6e0ff00715e8621fe96f872eafe8e5ef7f753ba43621a656ae9a6b549a5d050f294b926beeb8e7cc7da0da8bd1af561d326ac3973e8149395a97b92cc629b74a67860a9f0495818fc7bf78529cd6eea436927896686ea8d0353aea69e7642474d2a4b97a9ae60105eda31b923f7924f1b8711e2b4fc44256627ed476ffd23a8d0a977c4c196b56a2eba36cca959da3e9b872018602a9d0b6bd6a05e669148d3b94b66ddaed8a6895f5b236f98ef9be6e4fb9cfa9e6172be96fa84d6f3a67a79a9342629349d2aad35513388184cf392e36b433f548100374e22c96360f8a25b9a88350ad8a3e9fcfb57869fce2d936ebef04aaa4ca4e14f344f0a09032711eea7788bd4a6f5953a3d3da333b2f36ed988aea55335069b1b3615e32a22191bbbc3db5e757acca95e1214e96b2b50e95754cbf4aa9304a533d4b75d2a710a23ef129f7839beba1ed4fd40eac537ededa6cdd5e84d6993549959a4baa41132964a7ba48f58426c90594a0e8ebaa05f557a5ead4a55a2f51922a4e4aa255e7028a827f7c11c1061dad987b703c6223c786768a6a568274ead69cea6d09aa7cdc9d55d32b2ed127fab93f2939f589118fb7cfd21a522c40810204243594b4a55ce7bc2e19054d82210b66fde30bb95fec444dacfa4a152fd2216db0fb88c2db5a80483c11850cc6f022129abcbf02e2894ad67cada129677718f7cfbc6ea6038e254b715b507e5483dff0018ef1ce16e85c832f212525cf3777f7cf6fa461c6dff00312b4b615b78dde611c1efc08ed020ba1732db89294a0e464e4ee2368fc3d639bf2d32eb411e6956c3900ac8f33f1f68f44082e5175a94b9e625df34e027051e99f78c796a0807795a803dce331bc084ba168e21d524a50a2938ceedc7bfb463cb75494a5c56411f6837763f48e902042d087f040207ca31cfac6561d5e00594e15dc1ee236810216a96501294296a56d390498d76cd288754a0929ddf224f0af6cc748105d0b879332a97f2de0970ab05414ae01fa47469a71b4ed5cca9649fbc46303da37810b742e6d36e25ccb8a384f0956e3950fac64b6ee0a4bc559e42bb6d31bc08442e42581777a938213f2b8167249ef911b161d2ded69e2920f7f7fa98de37476fce0ba173759514fd9a882391f31ef1c94d4c3ce28bc416c0c25bcf0afa98f5473810bcea9779d4943d85241ca3e63907da3a796f13b94e94f1f7127811d2040841a41482771249ee4c6e13ea7bc0476fce330216bb0fb881b0fb88da0409da4240d983241f785cca9fb203e9086b2ff77985ccb11e58e7d226d67d250297eb1cbac08191ee2044253508e71d239c084204081021081020408420408102108102040842040810210810204085b25208c98cec1ee6023b7e719810b1b07b98c29200c88da30bedf9c085a46428818118810216dbcfb08d60408108408102042c851030233bcfb08d7198ce0fd3f8c085bc08191ee20647b8812dca841697894dab2eb1b6c49aeffdd859a3c4b6d66d80e22c69a24f18db1036d4772e6c79250a1fbab38855b4eacb6360000f452a3c415dc6ae22ebdea5bfca6af4751f0e72a06ef11dff00dca647ed34b6ff00c0735fc231fb4d2dbff01cd7f0886ff12b3d827f25405bef211bc379fa24e4c6bcf1af88bfbcb7f96d0a6fa39ca82c3b23ef2993fb4d2dbff01cd7f08d7f69adb1fe049aff002c4374ccbcbfbac9fe31aa5d715ca707f386bb8d5c46fdb8f71a81c39ca646d11f794c95789b5b206458933fe58d7f69c5b3fe0499ff002c4392fadae569c8fa46533485381a0b4e4fd61be9a788dfbc0f75a9de8df2afec4fbca62fed38b67fc0933fe581fb4e2d9ff024cff9621ca6682ced6c6e3bb1f2c6de6a83e65d40057d4f10d1c6ce22104fca06dfed6a3d1be551ff00a5def2987fb4dad9ff00034d7f96323c4ded91ff0071a6bfcb10f12f151dbb123ea4f1186e692e13b4278ee49879e34f12edfe25beeb13bd1c653d56ec8dff00894c4fda716d7f8166bf8460f89bd0c9fb2b12671f54c43c3368dd80907f03190e297c8e3f3860e34f1249b7ca5beeb127a38cabd213ef2985fb4de91fe0499ff2c0fda7342ff01ccff962200438464383fcd1cfe2dffa421e34f1247f996fbac4878719547388fbca617ed38a21e1161cc83ffa607ed36a4ff81a67fcb10f4ccba4656463e86017b0e21b2ef2bfba73c4633c6be24dedf2a6fbac4e1c38cab6fa93ef2985fb4de923b58d33fe58cfed37a57f81e6bf8443cf3d39292f8f94e0fcd03ce4ff00af1fe684f4dbc4a1fe647b8d4be8df2afec4fbca61fed37a57f81e6bf84615e26d492306c5993f9443d53e13dddfe06355be366ef3bf9c29e36712c7f991ee3127a38ca639c27de530bf69a527fc0733fc207ed36a48ed624c8fca21d79e9ff5dffba321d42c67cefe709e9bb895fbc8f71881c3ac9e4ed01f794c4fda6f4aff00034cff000ff9c0fda6f4aff034cff0ff009c43b2a6c7fdb7f38095a15d8aff008c1e9b38947fcc8f75a9de8e728feeeef794c4fda6f49f5b1a67f87fce07ed38a47f81a6bfcbff00388784840de5640f72631e7b7ffde3f9c3dbc6be24dbfc48f75a93d1ce501ffa1def2989fb4de8c7bd8d33fe581fb4da8bfe0699ff002c43b330d0eef13f8181f12d7fad57f185f4d7c49fde47bad58cf0eb285fea1def2987fb4e291fe0699ff2ff00ce33fb4e291fe069aff2ff00ce21d87918fed8c67ce4ff00af307a6be24fef23dd6a77a3cc9dfb03ef28f3a9bd61e96f4eb7e3b64ea9ca545134d9e1d32ca0931e263c517a6a0d61c72756b0ae07927eec287c5d283a65a80ca2a6dd2d84541446e7520054579bb40a0dba44bae533f272a51cc76ca6e14e41ad0fda53a4dae1fb5fcbc9724a0e296649a9c1219eea9d47c523a6e3301969336093dcb260fe9be20da23596173320e4d84a53924b462b26b93120aa983208c60f6cc399a0d6ddf3aa777d3b4c2cba2bd3752ab3c112de40242123ef15085a8e07e4c0018c4a093febbad8c7c4acd0e7598580ff000a9b4ef89274f0c053135373cdb80e33e41c18f449f889e82ce2c3523f18493fea4c365d46747fa47a2f53a369c5e02699a8cecaa15509c2af95a74fdefc84325a87a38ee8bcda2b548ab8ac501d98f2daa936301be33f346deaf8079628a9448e0fb585ceae57e575d471ca5e236079729f1b9d8d753cad0ed41bb36f6fa5cad7bf9a9b323d66e944fa3cf937a641db956f64e36c17d4baf7d17a54d0a634c4c3d30ef6dac1310d6d8b9135cabb343334b61a707dbb878f31bf74c1f33354cb4aeb5ced0655b9a4cba70d2a686fcfe310a8f80395eae40667b9ad3cbbdbfe0a5f0e309e21f110ba6a69628a161b1739bb9f573bfb4299766754da6f7cb0f3f2339f0a1b1825d1b4e477e0c18bbd48e944aadaa633584cccdafb10af5f6883b39549b9c997a77699654cfcce36d1da3f211c656a7314d9e6aa32cb01d63ee2d5cfe71b96f0238684b628fb52791efdae7d4bd10de16b60a76eaa92f7db7b36c09eb61d079297771f5ada556bcfcd53eeba654e55d65dda91f0eada7f38f2b7e203a2df1065c07c2ce0a50593c8f786ab4c3506435c241fd24bf692c29f9e25529555378754a038e7bc36b71e9655ecdb89ea45729bf6acb8a0dccedc6e403c7f28cf51fa3df0ea89ed12be4173b7ce7f5b2f397111f9af21e22229c31cd70bb5d6fc7cd4b597eb5f4aa6d9f3580f0e3fd418ed27d61698cea820a1e51ce33b711131b5c84a4af94e2b69fc711d6875793a690a74a56779214ae7889ecfd1f386561abb675fc24fc971da8e276681259ba7dd52ecf547a6284ee5a1e1fc63ccaeac34ad3ff66f1fce235395e97aab612ca503f011e39999601ca4236fac6ea1fd19f85d2b01d137f37f2581bc4ecd4e36ee7baa4e2bab7d2c2a4b414f3656adbbb19fcb104f5febfb41ed8aa0a455aa6ea5d47a16b988c33b76d1e9d3cd97427e470287e30c7f5033f2b56d4e76a72f9080ca48da78c9ef1aac63f477e1a52530ec04a0df7f9dfc923f89f9a6317259ec5607fb463a70c926acee49cff6503f68cf4dff00f8b3bfeca2b3964206e50c93cf7f48e6999467e64ff3315af409c3f3d25fe67e499e953345fec7baacfe5fc40fa7e98fbb57779edf671b3fd7df4fd2c038fd55dda3ff00c28adab792e248f31ddd9ed8306d3ada9c632a68a91ec15109dc07c841c2ed93de587d2e66a077d1ec560aff0088874e483c551eff00671e677c487a7295041aabd8ff00f4e2b9a79293b81f97e9049515ba0292e14e00fb84104fd731999c04c82edc096c37facfc965f4b3999fb5d9ec56589f138e9ad2ada6a8e7e6dc734f89a74d7bb8aa4d7d7eccc55c3890a2a595a5bc1e125593025be2d6ada978bc7ff2022258e01f0fff00d32dbc7b4dbf04f6f14734b9b7059ec569adf898f4d8e1d82ab303db7b6711bfed2be9b7ff00175ffb38ab812b3ce81f780f5495472f2df337e5796423ea79300e01f0fef6025fe67e4b19e29e6a27ec7b15a6a7c49ba6c57ccaab39f93719fda49d357fe2aeff00b38ab7950e292a536dab6a578ef1d90378e1583f5308780190aff466fe6251c55ce006cf601fc2ad07f69874d638fd6aeffb381fb4c3a6bffc55dff651572a7cac6c6b0563b9503881f1091c14f3ebde1cde01f0f4b6f797f99f926fa56cdbfb467b8a5ef51bafb35ad17115a66549424e42730d44e50dfaa128793f281807dcc1dbd60d7973426e529ce299f52127b42a283a795b9b429e6a8af6d4a327e431b8a796870ba3d31b801cf9aa1b258a08c34744c2d56cb765ebe86519f997ed127bc3e6faaaf4e3d4b5b37bd3a459995e54d3c879208405f008cc3477cd3ea54cae25b6e41685856394428adf1733d2d27546259666e4df0f30a4823849c9ed1ba7624f8bb3983816dc5cdfa2d950d5c71d5472386c1c2e3c45f71752c3addd60a16a8d7ab0c5c1e409e6e614e36eede403d80861eccbfa86cdb6ed937e520ced1a65c0a0c27b87330aad6d5d0755ad9a4ea0d1525a9df874b55697ec54a48ef8869cbcdb44cabe0a13fbaac45ab17cd2fed1b353b43a2700373b1b795ba5d7d59c953652ccf91e3a61176d492340209b8045aedb74b1e46fbf8278fa9bd2bb2a56d9b2b54ecca28a7b68a42a4dd906f077151e1c38f50219e4a42192ca0e16af5307529aa77149508d973554f3e9cb565b42ce4857a633da089d509552a5d2a1f39cf315bc47168e76c7253b6c079f5ebd364654c3707ca94ff21a58c31ad7b9e40dafab978dbe2b0a79ec6d7dcdea031b847253a77707b1f58e5335064b5b7cc1bc711c25e6028fda28609f48d6d3d74d4f20986c5a6eb6f262823aa60691e7ba5a69f5799b3aaedde2d13313b2ebfb009fbadfd62415cb6cc86a4e814beb0cd4fa662a0a990d3ae20612807f77f188aa6a859696833425d2cf0c7d47b43988d4fabcb68d5374ee85542d5393302667649e1b4b8f03c2c7ae22d1993325262182fc9d8d04869b3bc0ff007e6b8f7e92efc1a7e1fc9531b43e56b83411f66fccf9809137ddbb5444bb9332ae2be451e07d21232b589d95743336b5640f5879ad29e62b095a271b689502320e7984bea1695d5e65f72768922b5b41390a08f58a260b9aaa691ff279dd6f024af9dd13657b5a5d63aafc92765af5f84461b3e91ed6ea13b539452e5dcf4f786edd90b9515b329334d75212707e530ee58967cd354a2dcc248ca7d62ef519e0e154a4b9da89e563f92cf4f87cd5750628c6e12319b7e6aa9560c4d2c90610bacf456a4af2769db72af211f34484a55a4cca5412eade032ac73fbdf4868f5ead5abd5b58cd12914e2e3b30cb6112ad1e3f131a0c23343b16c41fa9fdd0dd46fb01fdfa943c4f0daaa68c6a1f6804d53cd36d3612a1c81882f71c652a3c8fce1f192e877582b665ff00585c943a732eac798ecccce0b49f63f842e2a5d1374db62372e8be3a8194a9bcb482f0a5b9b8a0fa88dad4e6cc0699e1825d67fd80bbfa051a0c36b666925b6b7890a3051eb0ccaba969b595a89c04a793fca159234dba2aad05c8d0a7e60633e5b32ab07f1c91129b4ab437a5bb6ee092b92956ebc8a4b6728aa5690438a23d9233987ea4756eda96626656d4a109a9264832eeb74e4e14476e76e7115ec473bb60974c14af778177747a8ec77f2535997e299baa599a1bd6db9b7b42add6f4df512bf3a992a269cd65d7967002a55401fe50e36967403ac7a89774b48ea95ab3f42a09014b9f29c1fc3b44d26f5ff57ee7a931fabe9b4ea7258504b2944800e2bff6c3bf645afaf959b2ae7bbf508cec8d31aa56fa73aa95014b748f418ed18e4cc799eae02d8610c6b81ef1b90df3d9bd14189f8052c859a8bdc0f2b73f8955e5aefe1597551eb6c3da195266ad2094fdab9327d71da11161f87875197055dc969db7134f4a7232fcc2003f5ef1367a70b5754f566e45d1b5b3529ab22d5917d6e2eab32bf2d6f8c90319fca36be7c35fa88beebb3d53d31d5a7eaf21951a74e09950f393cedc60fa8c46b30ece18d87c547535b017c84b58482e2e22db6d60398b0e7e2b735edc23b213b2273b6dc0dadfdfa945377c30f5aa4a45f9c13720eadb3ca52e051fe509c73a06d5e9b69c5b52f2c82d677171b29cff00187b657a57f13ed2cbcc50e936cd7513480a525c7c12c38d8eea2547da0e17a6fd6c5eb5997b6750754a5245530a086e592b4a563e9c44cc4f1ec7305a8ecaaab216b8736ee1c3ff00c8d47efeaa140ec02a99ac45201cbeff000e8a2c4ef47dab728d38a97959671b6d58714cac601fafb4174af4aba8d3aef96b6584abdbe211ff00cc5ab691785a69a583a5957af751dd45b7477ea0c6e597e7523735df8e61a0b86c8f093d2eb9e4ab352d5f9eadb34a1fd624a9d32a5178839f7f5c4328f3a575648591bf57fb842f20f983b273e8b0f0dd4223bf42eb1fc156c6a06995cda7758fd4377498967b1b92a463e61f4f7825122ac7096ff358ff00e626278947541d29752b55a33bd35e8b2adb349962c798fe72e81c051cf7262232e56d1de7cfb354a5e7e750715c9f531d0e8ebeaa4a1639ed1a8f3d969e6ecd952e6307747257456274bf61b324241ca52149f72885d52ba79b029328a976282d10b46dcf97057646ad5314a038efef0ad9dd5391f212182028ab9fc23e7c5763988492bacf7dbc2eb5a5c1dd533f7f741362dd73eaa9b14e6d27393818844dd9d27d374ee95e6d32921c0d851384e4f312dad4ba242a2c6e5b883f48d2f076893120b3352eda92073c44aa6cf38bc45ac0f2437ec93cc293154ba121dcd550eb148dff006fd75c98b62dc7d286ca8372e96cec5e7824c3495cb8af9a4d3fe36b56bcc25842bed5d2d1f962d5aebab68ffc4aa56728f2aa733820a4434dd54e8337a87a25521a3f469533ae2095321b19c63d23ace5fe2efd4d0d5d23991bdc06a71b345fa93d1755c9fc45cc19598d8b0ea873184dcb6fddf62af962fba2559843f22f824f2083d8fb465377add4fc43cf8193b402ae4436375db178692d74d1ab386a6d85953f27b3b1f78f022f2438f2cbf3ca25c1b9784f088f42b30e8dcd06221cc3c883b1f57885dee9f8d6cad83554ddb2dac77f8a5bdc37ccd3738bf83714a230303fdf1efb56ef989d4ef9c99481ff00abb1fac1069ae9e6a1ead32faac9a6b33afb24ed487805389f4e21dbd27f0efea86f0980dbb6cb54b61f3b9e54d3a381dc9e62162d8be018442595b3c71b86c41780557e0e2953d1636d9e5a926376e4785d1e74db6edb9a99ad76eda578d4596e4e667505f0f2f6eee47112f3affa0e83db3a8d2ced8b69352eed3e969936a4d63cb4cc24a797063b9cc31b2fd2849e8a3f4fa855ee34aaa72ae25d979a2d630442e2fcd76b275767e4a5759661909936432dcfcb35f3850e028e3d2216079ab28e234d2524a0963f60f6f427ee2adb3f12f86d99714a68b1399ef804643aedb0d4ed839c3adfe09a6b5d54d93ab09e54aae58799fd892738cc48ad31b82c2ab533e0ea3e42be4e76e0ff001fac335a832f60dbb4d727ad1af7c7b0504a6714d7ddfa433146d71a9dbd537d32b30a52379c11c67f28a2e3b94ea330544d13242c744469b6da878dfc979a31ba08f2ae393d24bbb03ee34f2009bb6c77d8b6db2949a996569a4bf99569344ba7249e719869ee9bc68b49975229f3032071886caead71b86e092530852c67ff003437d5abc2aca3f6b38a3ffee8d8e5fc975d0d33055c85f6f12a162198617b74d2b748f1ebed4e64deb0862792c2de564afbfa412bd7769e3bd45d3ee0d41aace4952da6da336f4892b7569f500434d3f74bab9c4277e48582466337e4ca66ae544d2d950feaedfcc0fd23a2d06034ec7b847dd2e6d891cedec2ab32d654398dd64917befe2158d4b750de0e355fd5d26e536eef8896702a71e7f7e1ef7e0c39155bd3c0fee3aad3af24536a3232edb612e4b1673bd407ac55769c4d2a56b65c5d351372fb49525d5720e2082af5aa9b95999994b7ba5c4c10dca877b4638f2f563650d82a1e1addb72dff00e4292df92c91fceb4b81f32ade9eeabfc1c34cdb6aeab4ea55875d6f3e4d15da78798cfa7de88f1aabe2d1694fde734ad37d379014edff00d59465d2d109f6da06220a49d0666ec9b4cb53255410d1cab6afb41e3ba495497f2e610950ca80573e91ad9323e095158f9eaea1efd7f6355997f1000041f3d4b01aca58a111b182c3cb7fc55865b1e39da37625b3252b5ae98a9757a8b382b770060fe2041aeaefe92957af1d3f72c8b43a6aa4c9a5e404614fe42503b1fc62b77fd15cfaeb89f849857978f9828fac1a33a57372eeaa71692bc1dbb446d1b973098e85d466493b170b16768eb11e1ceff1581b5b0472091ac6870eb64e3eb3f8816a275093c95dd94a62932d2c8dac49482fe57307237010add37f144eb7b4f2dc96a769cdfc24d992c792c9944ad381db930d05afa41253b3ff001334c2873db10e3d5f47aa121639ab5b54d2a44b8cf9694654b888ccb7952960869e0a46688c92d16be93b6e09b9b9b6e493c961fd6f511cae731f6d5cc744b9acf8a578816bcce376ddfba9e4cb4ce03934c301a5a31d920a7de101725e7ad727792aa15aadd45c4b437b132e15039f7839d04b0a66baa45c2fc816d4c2feda59f6f18faf31343a7bd09d29d7d98369266d94d4d6cedfeb60019c7604c65750d08af2f8a06ea76e4e90493e37b5d429eb24a97dc955e1a83aa5a877810d5cf7fd4aa4d918530fce2b6207b60c367549897766ddf8565a4a523e67d29076c4f4eb6fc26b5634e25e6ee8d37a4acfc392b7e57667cd4772a4fd2201555a9d92aa4d48392e651d95514ceca3c8c12a1df1162a6a4ec1a0e903ee48d967d46ee2b8cc4e2db61d331325d5a87c8a09dbfee8f02665fda32be711d679c059c81de3c61c38fbd1b00c6859c8b9bab6bb4665c93405bcdaca84291db8661f950104839e0fac7ae40db6cc9e56d241fca3c350acd1a4d0a782004e78c0f58f9d6cacfd63505c2121dd01e4a741471386ed47f64d72bd2b30952e6b08cff283ebf6fe12147712d294b596f939e21ab90d4242a7fe1d8ed9e38838ab382bad252e4d04873820c629f01633158aa2a19668dc809869181f63b04c6d5eefacd76fa72550cba505dfdd3db98933a53213547a133353455b9290085f650c7ac256d0d15a04b567f5b4d3e8249dd9e2149795e92b4893fd5924027d388de66ac720c69b1e1d87c7b0e7e5cadfd52be36c9dd8c5ec9adea57a4ad0fd6aadaab357b690ccf295b97312784157d0fd219ed47e8b3a7bd36d06ba5eb7edc53951320e2da766885a90a038c7b43f6aac54e6e6533080a5807247d212dae6f0a5e92576bd529325a98a7ba94850c0ce3eb160cbf8ce65a396968c54bf407345b51b6ee008f62cec6d442d0c248558fa3e2f2d2abcadfbda4ebafc9492a6c25e5cba8849c1e4111681a69d49dbd70372a9a6ddec4f2d72e9dec388c1ce04555542edaf5350a90294f92ccca9c69a70700130ea74d1aaf32c5f52cfcc84ad271b90c9f4f5fe51dff88192a2ccd46259400e6875b61bdb92b0411e1afa3732769d5d0ffc295bd665e9579169aa83934c2fe299fb0976de04b43dce222457af99f94690b7278efc10e233f7a2607557d36da754b02dfd68b2a5aa4ea2a8d0f8b61e732968fac442d46b02a74e74b6e4916d20e592473b621e43a5c3a8f08651c66fa79ad2d4d4c72ce5ad1b787ad279fd5cb80cbaa942aaea58571e4a5476ff00082d666a7e69df8b538e6dcf7cc144ed227da9fdfb30127983ca126a1547452d96c640f48e9ce8a9a36dc786e992bdd39bb892761befb0d87b02ece5d32d2690871d5e40c77826a9d75338b210e7711bdd56c5528f35e64d2383e9882c6e9dbd92b42b987d38a77303dbd5636b74a2d986a71fa936860a8952c7ddee615b7cc9ced39d65b9bc8756cb41248edf8c796c292431764a4c4e37b9b0e00a0467d6159afcd4b3d7c832df2cb7c237f91c4668ea1eec51b0b5bb11cd4ea9a085d837cadcfdc3c0d3d6df9ad672dda6d836d48cfcd5c8c999a8e7ce423928491c1fa424e8c7ccafaedc95914cdb9bf72168fbcbcc14d597329484999336d9cf98a5927cb48e4621fae89342262f0acd3eb93d22b726aa93296294909cee04819fe11b1828ded85c1c6fab75afa9ab8d9035cc1600724f0746dd06deba936ed66ee12adcb5328d2ca76af3ce27093c67093e87108d9cb49cf8e9ef849b4aa565e654dcb1233b8038cfd62c53c40dd6ba4be84297d34e922c4b57ae30872b13adf0a5254064644403a0d22669146929033416f3690970af9dc4f72622cf83cef90f53d15666a88bb3041dd16d37442ead489b9296b055e74d4c4c259f2109f98a89c42bee3e9bf55743ee89ab7f5b298dcb298612b974a138ca4f627de24ff85fe9a529bd4c56b2dc7260d0e8eea02c01c79b9ef8fc60e7c5a2eab62e5d62fd7099b0a6a725105b40c7ddf6e2328c258d83bfb3930d402cd9452b72d2a3f9827a559f3429394a530fcf4c36f512e3d49b6e83369654c4d5450d3b2cf37949413ce47bc307277ed2a4d08669c8f2508504e4fac3e9d145d545abebf5055519d42112f348d981c6730414347da06dedb8510cfa5d729ffeb7ba58b3b44efe7652cca436c48d5a542816d006158e7047686b74da8634e65585d3dc5b530dba1c44c157da7f1f689d1d5a50a85aaba64fcc49ccb4ecfd2d1bdb52482760e4c4099db8dc44f29e7c7c8c929233ed1b576131c3525ccdc205635c75376567bd3a54ad9ea7f44259175a9a999b914f9130a081bd49038049f48ad9f184f0886112339adda396b862a72b976665986c06dd40c93948ee6252f855eaf32d5e550b31c9e4a587e583a10a3fbc4f112eaf8ad69c6a8d7ea3a2f335a67f5d3124a71d955e3e668fe3dff28c92c71fd090dafc8adcd33be511878e63a78fad7c914ebca69e5d3e7d05b75b5283ebdb84b4a49c14911e3f26aaaf99ba729493f7559ee3de27c78c9741129a0da96bd62b0e8a19b62e57d699995423869e0719fa64f3cc42416d5de8010c4c24363840c8e07a440d4d0a7d82b0693d58f887c4b7c4e73ff9a14cd5ef28d49e661e0a046393eb11e6d660be8f8943ee923d40cc387695b75bb8519698796de382527bc795eb32fe1d48d2e26c0733e0a633b490dc84e35b972526666f2d14eecf107d52aeb89584b0af41cc26ed0d3f32270b494ba3b8571067546552ee790795a7dbb622b12c544fadd311d7b75e5d1365d4cdca3597b92e46d81f0aef1e9f34799d6ee4ad4d9987d24a7d637a04aadf68071cc60710609aebb492a416f21438388d2ca5f4f52f740c6df9248e69036ed17ba7274a6d9a3ae94db93cc85a82f9491da1a5f12aac4ad2340676dd9597da89b9848416d3ff00c41ed13502b32ad1618529bcfdd20479ae694a4eb249336bdf52e5d6d9980b2027315ec1282b307cc91e2155bc4d3acb4753d10d966d5bb4aa8dd43a2cdb322d4cf9ea094ad485276f7c7a470d34aa9a0d4989e919475a5b2bc9ddfbc3d4c4b6bcba57b6b537fa7eec9ce1924db4f2dd9568a700807239826e8aba019dea66973179dc15e3272720b2d14b48f99401c6711eca973ae08dc0e6aaa9759acb6a1a795c022feb04594c155a6120a973a27792b5bba61a6db549702d6d24052b1da19ed5bd0cb86456ed30c89716b570a08cc4acd05e9c68da09698b6ade70ad803852fbc28a62daa3cf5410a9b9443801f994b1eb1e51f4830e0f8ccd2d0375465ce22ff0b28b15642c99ac702013baae863a1cbcae2df30641680a39fba6345f47772d8b3467532aa52928ce7062ce5ba151d9943e549b486827d04232e6a5d9d3014c4d2d92a27949ef889345c73c76aa7747243dc1cc0e6bb7c780e4a665c35300324805c91b807cd55c6a169adcd393aa44d482f6a4e3ee9846d56c672972eb765e50a5ec709222d0ee5d0db16e6972b90946cac82725381986d2e2f0f89fb9e59570c9cb20343384e793f94753c078cb8116363aa3d937cf6dcfad73ac47002d91a699e1e5e2f66ee47b3d6a12e88e9dcfd66aedcc4f4814a82b2144417f534d268faa6aa714e36caa38c7d2271d9bd1fde36c2d2ecbd102908577f5c4448eb5ecb7697afd38d4eb1e596586c2d2a1c8c88bce4fcd987666cc93328e40f0d8cf22094cc628ea30ecb8193c6412f045c5ae1312a6662e0a83543a7901c997d28000fddcf3fca2cdfc39f456e6b92efa6ceda812997b569e82878a7e5f378cc56e4a481b5ae85561f201611be5f673c9f78b23f0f5ea324f4cfa73999c9dac34c4d3d36a7665c42815ecc768ed544fa62038f55cf7123aa20423bf160d4da9ca5f542a1d7eb21e7a59ac292939c445e373b73b2ed290ad9bdc0377ae098d7aa4ea2a435e754266ef492f4bb2a2868ba70ac8e3b437e9b8673e52cb60abf7539e00f7cc65ed5badd7e4b5afa5d63bdb1562ba3faef64f4f9d314c09aa797e62665d4494fd47788c1d4f6ba53f56adba557e93358718479650a57cc3061032dd45ce2e9eab4e75c43f2a259292dacf2081cc35950bbe52b7733b294c70b72e8047940fca151ada892a67a80e06cd01658e9dfd9e8b6c95ed5ce2a618425f1e66f03bc3e9d2fdc73b42be53372d3a7ccc0cf032222cb72ecc9bad4cb53e02db7372c15710e5e8e5e77451aae9ad21e56c59c15147a444a82c10901bbac13533434395955a3d4ab1212eedb73751717f18d169cdeacf788f9aa5506a87773d4da454c381d595946ef730496adef6c4dccb427ab6bf8c751bc028c2723ebe908ad60ba65dcaa9a9d2dc74b8956d71e038fe30987d7c94d604defd142d2e79b10a52787f5f1394aea0e949957032f3aa2958ddc1188b2da6e9ed8b776abd1f5866b7375aa735e495255b42f9f5c77fce293ba35baab56beacca566ab55714b133be59c1df07d3f08b64d1cd766ab53ccd3678f9602012f1e3262db076153196bc58f42958f9a9646ba337473e241d2869ceb174ad7fb35b501e648aea0c20273b5c427f77db9f68f9b29bb4d52536ec9b754504b4e29090547b0388faa5ad5eb6956289fd18bb12cae4ab483243cf2003bc1183ed1489a8bd04b6dea0d75b92b687929accd06769e36f9aac63f28a76311d45155e98da4dc5f657ec225a3aea72f79b58d924f4e6cc9591914ca3cb4927f789877ed2baa936353cca392cdb994e02b888c32dad52eeb0994a73fe62c1e0b70b2a1de93d3b228727092b571857a08f30627825756b1cc9c9009e5e4acb514f042eee0ba7c676ffa7cd36a9c61b09c8e024412b5569cae4ca9524c2940f638824b55c949f954b2e1560fd61ced2790a3a2aa8915b49ce73cc566bd9458052bcf6772d17bdfa280e34ce7813b3ba91c6ad73d2def29322bc640ede90aea64a1a853bcf9a6f0af6221c0bee9b6d5bec09a98619194fa810dccdded4d3f24aa9019fa778a9d262d2e394a27a784803af8a9a5b847647b3ee84634d914b8c16d2df23e91e9a04b8a4d53e2265180a70724416532fea4c9601c147a13dc98f74dde146ab4ba5d58295a7e646d38e4461a938a1698df19b1e5f82d2c8f80c8749b84c4dbd4e55d557d5fb65998f211332ca5a1d1e8539308bf0c1d58bc74e350d364cdbff134ba8bee32a1e808c9cc2c2c1af5368539a9b5da8ab2998965a5393c67984bf4034397af579573a52db2cb136e142cf183cc760ac91bff008d62d1c83ba59081e25c596b7b404c88eb05c5bb29eb52bda55f9751652073e90409b9d2a7025f6c94eefdd105b36f4bb892994994acfa8498f14bea35b5407fe1aaec8de91c150e23cd71d149a1cd6b0b881cbaad4d0504f89d5362e57ea764a5ae5ff4b6e4bf57257b16b18193081b8adf7be34d49d995292a483bb3e90597f5dd6f5c33a89f9398d9b0f01b560477a24dd5f504b945b74a5e7d8693f665e09ddfc62c983e0f3e1f189a21a757d2d43e1baebf995b160b97e9f0da5782f70efd8dd1556eff005d0190d4bcd28638ef0b9b6ba969490b3849cd3c3cec7de298f355ba63be0ce52e45ca2879e9f527cc46ddc1bc9f523885eeab745f3569db49b7290dc9cd4eaa5fcc5ba95801236e7198d862efca92450b2b3492e75af702dcbcd6af26bb13a2ac74cc780e0dd83b91e7c923addeaded4a6cc866aeb6d6a524f0071103faf1b9e897cf52d3b5390692a69e6193848873ee1a62e835e9da1d458479ec3c501615918f5ed11e3a8c6665bd5833edab0d790dee50fa4773e15e4fc1703c7a4ada206ef8edcf6dd6bb3a66dc4b1e81b4954d682d3cdbcfd564dd5ef37234c9b995394de0a762446b63ea955a956fbd449679d436bce10959023c97c3ee545d5baa59db9c9c411dacb69355deb24b63b88f49d202611e415165898f162bd36f552a095cecf4ebabda5df9771f583f90bceaac2b9677a060e3e91e6b825a427a9ae4ad3de4253b817020731e79762a1b98956520a767cc7b1fe3199ce672bac65c246dc858aaccd59dad26e3a64bac367fb446788f5bb28c49d3ff005acbaca56eaf2e273eb1efaacbbcaa62132ce04a40fb50950e2086a12b3f2d2be5b0b52da1f3952b9fca30b4b5f7d26e86965acbd2f55e5c48ec71d51593e90bcb53559aa5d04529b9770bb818528421e8b26c4ca5a997a548dddca93810632936f333cfb72d2c1c435ca52b47253eb11e48defdacb04b1c6f2403b04e750b56172896ddac3a034939514ab0a02152c5cbfd32a6bf36ccf0669681b94b51e4c32d22f4ad725973ed49a996d1c14bdebef8851d06a7589ea3bf4ba6ca7f546d0038d213c949ed180d38677ba8dd6b6589800d3cefbfa93bfa17a9946b6ef593aa3b51f3e51b7804ab3f58b15b3f551e7e9d257150128532eb69e02b9f48aabd36b1ef2acbe8b7ecfb2e7e61d077a422594ac1fc40893766ceeb6d9341965ced12aecb3278f882a975ec4f3f846da8ea246c8ed5c86ea34d1b849dd0483c94fbbaba807eb14193a5d4e71b2e52a71b9d9a29572360e0445daff501aff3b5d9d9c91a449a987a6dc5b2ac0e505448fe50e658da7325aad6f54ab73b5832ef3d6d3ad24a3294bae293c11f5111b4da9abd4e3fabdbba65f6b1f669dcd1ce13c73fc224d6c12d5b9b2345f65b0a5a8f92874601b5d45ad28d28aad02792fb80bc9cfa8cc3cbfd00b8aa72e87e952f850c6e01247109bd29d4596a75590d56909435b872a4c48ea56a0db9314d97fd5cda1c4ad601d8911e4acc58be2d04c0f6648f1e43f05dae966a1ec484de59342b829afa5ba8214024f3910e9da527332f349a94ba8857a9cc29dbb698acd2d3392f2e1248cfdcc470a7db3599742972c0607602397e2598e0c41ae6bac1dc8df716ebe0a24f3500bec3ef49cd5097bbaec604bb0fa804a4e3061aa97b56f66e604812bef8e6244cacb4dd3240bf3cc1241c924434f7f5fafcb5c1b298956c52f0e38947dd113b2ce27526375353b1ba1a2f71ff005d5562b6a0bf66b07922112d50a0ad0cd649db9fe70a3a5cec8d4a4d299657cc127d615533a69a4b7b5b92556a96b8a69afb8407db7c009fc3f18255e805b929724d4bd1f59e466698c4befcb6e9dd9c7d224d4e2986d5802a242d7817366b8f5e5b0b7c5436d2ccc69361bf9d933d6c69dd62fdb2ef594a4abedbcf702f0aee331d3a29d38adbfa5358a0cb38599b93aab882a49c7687bb4c3412d8b12d2abdc54ed4254e3f30db8e36d273b4e47f384b74654cae37665cf5090dafe6e17bcd4e7b44cc433599703af640f1a1b242417348dec7c79f2f25af74f3d382c4e269ad8171d0d95542af32a7129f4518426b84ccbcdbee7c38d852bee21c8aadf93946a52e9d3430549311ff0052eea997261f464ed39209f78ac64fa0c4f12c65d57381b781b0f62b83715c0db96f4358454f8ff449db966eb347a0aa71b983dffbd055a67a9af49dc6d1a8561f957de3b251e617852950475aabd51d952cbedaca3773c9c435faeb712a8153a557a9fe6369945254d940c0ddeb1dff0002c222a9bd3ccc6b8bb96c3f03754e74d53513ea713cbc54eeb3abdad8e4e948ea167d12eac6e6db713bd91f9c49cd37b16d6d56b3e62cabaf58a7c556625cb74ca887c0f39641c0ce62a124fa9dad4c3c8aab35f5b60a025f0158c43a96375a77852e6e5a5e5ea7e61976c3ac292bfa8ed186bb2a886ce6d244f2d27631b4f2b75b2ced9ebe3789359b3797ad38b72686df16feafd634cee446266993452dbca24ae6104fdecfac47eeb0ec99cb52ed9890773bc328c7112f6ebea0a917cd56cfbd6790113f3520b4cd4c7be38c13ea618eeb39996bbf50ccfd2f0f27e19bce071da21658c42b6973639859a63736f6bec08e602e958be1182cf91a9f1581d7a991ddef828817553d54fa134e38aca9c4f26135684aaa6eba9a3ee00bab48c93ee40ff8c383afb40724e912cdcab7e5a37e549cfac35a8977e46744eb2fe149c1e15ec63d0787ca25a7b83cd7332cee0ba97b4af0fd6d366cf565579b6664b21c423ccf74e617fe0f3d0469d7561ab55ab575a6ec0dd3a90f10b2dac254540f039f48672c9eabe9add8a2995aa9a83accbec195f3db1cc11f4afd5a56b45f50ea55196afae524aa2f951759560939e2346311cc11e1f23bb10e730f2e5abe1b7c53e1a48cbc35eed8ab55f113f08fe87749fa65acde1a7b72aa52a9212c56825e077903e91515a1b6ab378ea1532cea82c392ea9cdab04fdf6c1ef0faf543e22753d40d3d99b2e42e37a6c4c37856f733114ec6d439fb1ee891ba82be56960b9b4f39cc3b0badc5eaa8e49658c46e00d873dfd761f8259e968e19831bbdfaab4ed4ce8bba6bba744142d36db93a8d3a5773ee27032a09cc56bcdcf8a1dc4fd19530a7033345871e5631b77621e9b87c418c9592ed2280e1f899c676a86ef71888cd3b5b7973af54da7762a6dc2b25473c9398cd83cb8bd6c2e755334bba1bf3f80582a692189fdddd5f5786af87bf435ac9d2e52557bdb32750ab4cb61e7dfdc3773ce2115d707459a31d25f50d6abf68e9d4a26daaf6d6dc0b4647c9c9886de1dbd71dcda696d316b49dcc03ac11b5b53d8e21e9f105f118ff00481a696f50ab95369e99959c4a9052b048e7dfd22bb55992add3bb0f7c644c7769e6081f70b75eab61fa9e9f4365e855ac74ada35d37d22c794b9b4e6c4a4a5e9a4256f292ca49492067b8860fc5d3a81a174cd66cbda96eda720b5dc230b50974e519fca226f4e7d7d5e740a7cbb5235bd887194ed407380302107e26fd4d3dadcedbd233f514beeb1b77ed56488651e6c76305b40e05b25ec7c764cc428a3a0a5ed996df9257e81f53f3f51a44ad027a9ad3289204b2b4f1e6a0f2acc7be72bd44999c7667e0dafb4714afe273117b4f2ea452a584d4ba55f603de142ad64714a2af295c98ea7451c10d0b232f26de6a8aea991ce2523e9da7946b9a710d48938cfa0c187b74e2c290b52598132429208012b3eb0a4d25d20b4e9f504d4972e92907eeaa173735a76f29c4cda5a425b49f91293eb1e08c673bb2be7751b1eed23cb7f6ae9a316a0a61a2c49f241dba5994a1a65245b0141381c60478ed4b86a4852953a3092a383e909ebe2b34ea2cb36e4c5450c3608001547ba80e2ebd6a0ad50df0f4af212b47a91de2ad1e1711c304ae61d323ada9c3aef6dfdaa0d6b713aac3456b2177605d6d601b75d89f1ff84b476b9213d2aa97984a4e41e04206e8b42dba7313157496500a4a8a1cc768209fbc6b5201625a5d65485fcd907b412ea7ea3ccd6ac2a8b7f05b5e4cb9da531b5c1f2ce214555118cda3246a21c37bf255c8995ad7fd3bdd2eb4a3507a75bc529b5ae0a5c9244b02fae65f09014a49fbbcc494d049fe8da596f4cb16c4a4cce4c27629bf2d2a46d8a55aeea756298adadce2d232a0434bc1dd9f585d68df58575581332ac99e7ca14e00a25c278cc778afcad8c51426ab0d7b766fd0201bf89f5952052cb1eee7127ccabb8d6cd33d02bdba7fad4de9bd1a4e4aa72d4e756c142437908492a18115d7d225d6cdada7556a5f90733f5f7d4a781e71930e3e9ef5c9602f49e7a7ea95d2b995531e42d9f33bee411da1b6e9f2826a96322a94649f2ea338b7d391d8124c72cc7eb5d8961333714a711c8648c3ac34825bab7b6fb9ea539c4bc586c7cd282f19e9bafccf9ed30adbf86210972590e5655e5b8c9480acee3eb0f249505f79c2a98602523d4884f5c8c85547e0659a4f1ce408a860f8f36079a68458b7a859221aecd79364d8cae9c529e0252625770f525308bea37a469cbff4d1d9cb28a4cf498539f0c4606d1ce730f554d0b90036a4660c2cfa15d773a94cd3945097014b8b23e523da2d51665c4f0f7b6ae392da083bf2fc42dac7d93486b7fb0aa56a34ab8ad59a7293520eb60a887fcc463183e9ef0a5d2f3745c1526e9540957a61ec6c60a013919f5f689d1e23fa15a5761e874ad4cd325e5eacebbb5d9b09039309be912c6b46d2d30a7d62d59791a9551d23e226128076831dd6978830629945d8d52c249d459626c2e2d73eadf659e56b3b601bb8e7ff006961a65a7c6474f2934abcc0338ca73b1272a466119ae4d22977cbf254d0a3fd5d1dc76e21f892b61daabdf112985bce637a93d927da1a8d72b56a74dbf5f6a6dbf9fc944734caf8c8abc6e4739d776f71d05f98fb967a36544b1f61afba0dc051b7592d87eb14a41515ab6ab2ae2191ac5b8b927d4def50c8f941112feaf416e787c3ce4b8e47b4323adb661a25444c352bf67e984c778cb18b45238417f6a875d472411ea1d39a64db754875c43b2c0215c0c2a3b2436dcbf998d852309e33cc7aeb14f4ca9de47ae711e4ca572c5b0327bc5ec5eeb5fa890bccf3b30082e4c6544f20263dad7c2e10da9d52d24e4823d63cf28c9f30f9ff009663b28a9b994a427221481cd0f76a0b94f4bb0dcd852770501f663d23d289962658435b8929f423d6379c71027100a4768e6af25a9c0118c13cc25cdef74c0e22cbd946ad55add78cc51a61c61d5287da36ae40f58f5d5ee7afdc6e15562ab30fece59df93cc17bbff584ad0bda31de3a212f28e5131fca3018a2126bd23578db70874cf22c4ede09ced2eea0af8b5a4bf56793e706c67cd52f948f60215d47bc2b17bcc9aed7e7145ccff5741566194b79e7656aa96de56e0e606ec43a76a4badbdad36ac04f31affd5f451549a86c6359ebfdf550ebaa257c3a49d93e1a753ab128865e6527cc70217f89854b944612e29210cf04fef422ec49e624a43e3260808611bd59f71da1093facb5833cf16df56df355b707d331bd65444c85ad23755c6c25ca6ed35eaad312e0919a5a8a4642b3f2c37d7cf5113f6cccaa56a132a53a17b52949f94422ef0eab6764a9bfa96dc9023cce3cdda73cc35371576b3537ff0058ce3de7baeaf2504761ef1e47cb1922a7b57cf8ac22ceebc89fbd7b87859fa33cd88bdb88670063880d4216fd33fc7ffca55ea96ad5cf7fbc8f8b9d4b6c36a052967209fc61ff00e80f50ae2bba693a5ecd243f2cdaf2561192377726224b8e2f297544839fbb88991e16176b96d22e4aab36ca5f7db6479731b73b4c7a228727e53c730d38755d2fccb2ce11dad6205b539dd4ee6c3add7ac33ee4ecacce19be862a2618a20d0c8cd9bdeb801de7604fb53e5ab3a3333674c2e5974053c1c485a5c69bc800fbc37152a6da2cd2a625a729b2812eb650fef472063b8fac38375758572da13c19bcd965727319056ea41212783fca1a2d42bcec5aed45fa950260ae46613b80071dfbc79f388bc249b27b9b5b473b8c0e75f4ee03396903c6fbfb17ce7cff00c2ac6b25d08c55dfe1dc7a7d9b9e57f0ff008511f53fa40aadc35aabd5b4eea2d197616a78b4b395797c938fac32d63d8b70552e36a8126c38b9979e537b5e190920e227a5398b6656653314a9a533e7b0b0e02ae16307e5889fa41a9b38c7521334495b752eb9fac5d43384f61ba2d796730e2d59415314841ec582c4f3e4b9c53bdd338e8dda97164f4ff3f6fd16be8bbeb3fd6a46512e30d30bc20ee1d943d6252e80366ded20a336a0901c970a57963b1fa4329aa7361174551b610b4199946d2eb79ecaf5870eded5b16d5a149b7514ddde5c8a79c768e679c7f5c63f85c571abb4735d6e834b2e40f2b9512a1b312416a72ae6bc1c6644aa5d0028f6c08494ad4272a2faa6163e6009188cd02ab317920a10d67db88f44fd26a546694a432063d3e91cde9e922c2c981ec0243b1ef29b41076d296bf63e092570d56a8ed4c4b792b512780910b2b3ae5bb2d3920e2e554864fcc014f1986eab3a9aaa2d7925c910a295f394c38329ab2fded6cfeae94a500e246321b8b062f4958da58da69c189d6b9bdd4c9a8240eb5d323e25d742af1d0e44fd65b0bd93b84a476848f40779daf6dd3d36a53932ee7ff4e2ece073929733d87b0c47a7aefa9cfbda2cba5ce318febd8fbbeb04bd0df4ecfd9f4176f4aa4ead6baab3f65b95d818e9d43061d0f0bdd0ce6cc329d23a6d6bfb3659a94c715dae527a91a872d45a80525084a3cc0ad881c1308dd73ac2eead40fd73b424ae580506c6123021412541a7372a573982ac8c127da13b7bb0c2aba9533d8338fe5158cb3153415ef9621d39a978146d7d63da374857e99e72f3b09e7767eb091d64b0d17350772593e6a1271b47b4396ecbb4ca5b0072a8f2d7294eb484e53942876c7a4742a0c4a6a7a86cade415826a31340e610a08ddd487d99854a4d24a5c4a88c76e0411332ad32e6c2a2488927d4168aa679955cd456f6a4f7091ebeb0c04cdb7314c9df8799c82be7911dcb09c5e9f13a612467bdd4782a354d34d493963c22c9b4a4277a7d239cbcea8b810b4a494f638837728dbd18cfa4789ca3794ef9bcf78da892eb02e6e2fe266038fa427038db1914b0eab7a1c51f5e4c7b954bf398dc0c68c536714406cf19f687178b2c249bae63c897484ac6e39fde85050297293690b32e3b4789aa436a400f7deef07f42636a434d088ce9b658262432e16266852ccbecccb68c6d5fa7bc38345926d8650e3655bdc48e0f68206686f4cc92507ba5cddda1452d51664651134e0e191888f24c6ca0bdc5cc174a7b96e566dab2972ad383cf994fda851edf8434aaae4b6e3923398efa817a09c9b75c5abecd040033f48423971b25c510a1dcc61324cfef81b14f652fcd82a515075dac49147c15c56cca4d2c8fbc83eb1caaba876cd4a690bb7edc4b195e53e59dc4fd3111c68b73cdce4c6e751e5ac2f69f93233f8c39f604e5527ebb21212f30843e1f496dd29f941fac62afc77167696427416f2b72bf82fa9382f165d514efaf2c6b5a012492eb0b78df6f6a712a16ddff549072b4ed973adcbb7fd9bae4b948c1f6c438ba0b736ace844f4a57649c7e569f5249330ebcd602c01db10bfb6faf199d39a61b32f8b0a9f70d3d12e1b43c1a4a141607b7ac2d283d52d1b5c2d44b757d1e926e469ad292ca0108c02239dd071073bd0e36e931ac309885c7691c8d3ddb8dcb5db7f55ce19fa59e0f89ce30dc5a85a2124b4b83c1696ff00ab4f523a26a6e3d515eb35fecb55e6d4db656431378c23239e4768496a7dd55591b8554da71013d804703f84295f92a448d4665da5b68f2269d2b665f38f279ec210b77b4fb75e33eb257cf703319b3366e6e6bac6450c76858091af675cdb63d3a6d65c7f8edc49c273d53536178134b6962b1b9dae7d5d2d6f8ae54799bce7e791200ad21d56144a8f0211fd3bda6ba7758350914fccea259c5e55e9eb9878ec4925d5a5d2fb2d28b8784613eb045a6765cfd33add6e4d99701d9fa6ad23ea488a3feb5ed60aea76b434f64ed87973f82f3be1d18633bdb23abed99e4ea089775af3be29b03e5e7b42fe912d6f4e49b6f4f3637332c948403ce44136b0e9fdcba71a8d2354aa34afeb0dba861b03395e219717e5f96edde05483c842e60a54da81c457a970a7661c3e1104a3bad05bbf3b6c6de3643dc4485be0a4935a974ab27e7050923e905d35aff2570cf09671d496cfa030d05d951ac5d34d54cb12ee118ee910dcc9d4ae2a0d4c3be5bc46eda524186d0640c26aaef9769baf8a48d954c2e93a2954fd56c89a7513536e35b944139021d0d20ba34f69ac280758dce0c60a0768845705f338da18df32a4138f96163a7d784f2112eefc5a89528a4a52ac98d4639c3d754e161ae99c00bd82c06a2a1d20052b7c5165adea8595404d05f6cbb35564a7623033c8f6837b768b3d6cd934d90977065a65b2523d3e510db75876ed66695a7ac4eb8b2a9dac27ca6fbeeed8874eecb2754280b087286ef9496118d809e3688753d3368f29505109c16de63b9e6358dc78ade47aa6245911d6aad59cbafadc20248230ae2332b5076a0189c9a193db07d63ad168d55ab8f87a9cbad1b958505271cc1b542de4d2aa32d212ed1213cac91c46da8ea6921f986fd2b735b6c1a89b15697b4defb2e6c51d0e3fe6b6d7caae704466a74753a909d9dbdc41fcba10b4ee08db8380311ace961946e7c803d311962aa7b5da46f6571310626c6efa6372c8530f206d2380a1c430fa95604854e71c79b080aee36a710f7ea45550ebe509731df10d0de33859754af3791fce2fd971f5519120e64f254dc59d03efa533552b3e6e9b3aa0da4ed078cc7036ecc4d365f4a390718850dc95b9942d4368233df309672f1724264b6b386c9c9c0f58ead04d532301baaa48d00dc2eacd0e741dbb3f947a25adb9a0f06dc4e01f68f6c9dcb2af4b8790783f48eb2b5f53e82820058ed1235d49e6a1bc1baf3b96ea5a713c93f5837a25bea78875e1b529f5ed1c290ebb5099cbd8c03ce0c6ba9379cb5b32ad4849ba43ae8e0010cbc923b49dd4624c8fd011dce5cb4aa44b1950b054919cc222e3d42992ea9326ae01ede9090ab5e338ead4953849c73cfac121ab3d30e12eba403e8225414363de5261a5b04675cb8e667e68bc0ab07b88f226a6f607d98edfdd8d41696c84e327d63a05320636ff00289fa20f05314b3e9f3a3f7ef7d08177cf49adb9b9b415b1bc77ef04d53d10d41d2db7e6ae8a8905a972433e58f982bd21ff00e977a95975d8b49d35b8291e43720d1434bd9852f93f7bdfbc3b73968da576d326e42a8db6b959d050e2477424fef0fac79b64cdf8ae138dd44158cbb0beedfe1f5f45d0b02cc78b8c227a1d570ffc156faf562bb38e36b5cfabcd4af2b4abe90fb74c7a9371dcb3b2f4054f90875643cca4764fbc213a92e98adcb0b5a25e81645d0d9939f7005fc5380a919f6c76896fa19d2bd85a1746939ea74db952a84c4aa1d7669d58523e619c271ed16ccc998304182453e920ccdeefe7e0aa11e102798c447d037bae733a5a66ea85e65c52109c73f8c66aba2b30db4a75280a03be443a219a74b49a9481b94b393bbd20a27aad30e1f290dafe656060e46238b4b8a62134ba637580b72567ec63634374ecb1a3b63db8c492657ca0268ab1da1bbd44a32f4d7c422c69f6e6425a9c6ca5c18e0f30fe74ff002367335c71fba6792d38c0dc9493818f73986c3c4268b4fb47aaed1fbd64ea12f3127599f0ca54c0e520ab111b0671ff00c86561792258661bf886176dea00ad3d732327b3630ed6dc0f14b5eb82b72435d6c0a5332c8521d9c597404f7071043aff00a0745b95dfd7347a636cad0efdd4a40f48941ab9e1d0354357ed5d4d9abc56cd1e9b27e7a5093f385edc8ddf4842750b68546c6f8676427a5e750ebe51b1950cf0239cb332d1505461b4f87540738466f676d726e2e7d5cd4434cf89ce25bb11617e6907d32e845acfd31d55df49410949c05a4436daaba77647fa684db94db7d289451254e04710e7507521ea63686b72990e0f9907bc1654ee1b76a53eaa9a9b4799bf852c7cd8f53167c1e2ae6e333574f2386b160dbec159e92998e205869e9d515d6ba22d2dba1e61d979a4a16e207cbc706143a77e1f56c5a55045467aa297105794a491da0f292f492e5533cc54c276a7702578c08e9716b2aeda9543f355d69496c7d9b60e491f9441afc7f3248c3454531f3b8e97076fb96beaf0f92594e9b58795933bd7c5954f6baaed1ad3db6db43ad09b6de75b48fc22616a622814390f267694cad465d091f663b8481106a475469bac1e23f665426aa085c8d16482d641fbaafae6277d6ae1d3dbd278cacfd55a56cc8250a1de27663a49a1cbf86d04bab5b222e2e1cfbcf27f05a4d134759a80361ceca1c6ad54a6a5ae15fea496d995e52909c711e342ea53d4f44ece35f69efeb0a3eb0eecb76c2b85b96a2ca21c46d2a53c0679f41f84276ddb8d8add2513296c8dcd255f4e7bc593008a66e16c90b363b03cc9f5ab6615792aae05b65ec2a48974940f4e7f1822b9669d4b7f2e47a08360f07dc4a103092a3bbdf1ef05d5e944cc4aadd6d7c25bce4fbc6d6975f6b6b1561a8b8684c86a3cc4f25d53a33c661a0baebcb330b0f2b91e9987c3519e94c3cca543094fa8fa4477d497daa7ce9742fe55663b1e570d95a3500b9f6380c2eb0495b86ac16b5e17eb08dad4d29d52bcb573f4f5834abd481985b6e280c7391f5ed09b7e7b2fad040ca4e159f78e9f4703437755b0e257ba9b5c9c69b2d29460c5bafcc266b6b6b238820919e2e3c50509fe106526825f0eb64124f20c4c30c764d7d8104a70b4cd0fd62a4c4a951cb8e8047e7098ea164676977fae96fa8ed4232de617da314a9862af2b36829c85057cdda3cfd6bd91332171c85e12c145a7d91e6abd01fa42430c5a358f15a98660dc4c32fcc262dc716061479f58c3090a388c38cee5ee39c2c6e11d984f96323bc64d416f839a365ec61be3df88c96f9ef1bb1b368e4f68c908c9e4c31375056896be9ed8ed0726d528da5f6cf1b408d6feba5cb3289333920c2884b0779f64e3bc2d69d67d1852d33e66067e86096f793a54cc816404a81385823394c789f0fc5a1a8983e62e905faae874510640348b155b7a8f78d7af0d439a9e134fbb32b9c0253e63f28cfa458de8c53eec95d22a249cf8714f89242965c273c888ff00d4b687699da141b76ffa153f13e6b8d17b60c0c6e8964e5d549a55ad4b7d6fa06645a560638e3b45bb3e66da3acc230f6d253ed7736c0756ed7bdbadd6826aff0091d44a5c773bd978dab5ef1a8a4f9414063f94734db7745297f109935a90d8dc4ac42aacad59b7aaf349946a71b0a030391de15f2afaea136a454020a0a31948188e3588e71aca2a92c9a9cb6de76bfc16b8e662e36d3f1fc93337cd569f2122cdcd57a8097971c4c041c150f688f1d796b9a5733a697950eb4db4c5327caa412faf392150e5788dfebda7e99bb354b96cca4bbc37792318fa9c45706a55ef55bde6e4e72b332a71a95525126d6fc849fa0f48f44f08706a4c6b06189c8d05c4bc1bee4348d247de0a855357515550d9192100731e2a7733e30dd6c6ae570e98d915c9190486bcaf39c563721039c7e50ebb1ae6753f4ddfa0546a734c5d54493139373c1596d59ef88ad7d22bfa6b4a2f846a1cc30660c921456c8e7823da1d5b7fad476955fa8d5adcb55c2baec8a5b790a4e46c27e61fc33174a7e19e49c3dc3e47451c76fb406ff151ea5afaa3791e6e396ea4358baf5755565dd990c7c7cbcbd53e155369e70710bf929bb92b0132f4a0ca54b5f965d7d784fcdce3f1888766eb9bfa6f5d989ab4acb79ba44c64a259d24ee51ee707d724f30a473a96ae53932465286eb526d555ba838c970ee2e27b0fc3e910abb206587ccc7c37b5f95d3d98d55d1b03637dd3db75dc3acb4f68d324972ee054c160794efd71ef08d727357ea95499a2aea286e6650e1528e28e76fbe0c36125d45dc54f977aa32946796115afd6292b749f9b7eedbf87d215f68756f4bba2e7ac5f35fb5bc9aed4181e6fa24348e5381f944c664ecb1470ea6c62fed2a55362f5cf6925d7ba29d1497d4191ea9aa12a8962b9f34edc82d9edcf3123aca9bd58ab5cee48aa61e690b429c2a2a3c60c461e9f751b532f4d64acf51da7f46486241b5cab8dab907b83c438147eb3ab56f5755275ca48da8a738caf070772959311f18cbd82e2b50f68b17b5ba74f801cbdbba90caaae644f2c3cedf04f26a269cdeb75c9b33330f89a132a28415281f981c4286d8d2ebba8b4c96b6a62536bea61449fa010cd595d57db1335593a7bd6c4d3cdcbcc256425e57de2624cd3759a8d509962e9a6db8b41532014b8b27031148c52868f0ca16406edb58ec56e72d5756cf396386c124e996e57a624973f2b4d2e36d2fc85ab1fbe3bc6d5ad38bd261944849d24e5f511c0fa6614d21aa147a1d41e7a5a9d843ae87820729df9c9e23957b5ae512c4fac4a2d2aa94c1985107fb3e3803d8662bb4d15009356b27ef56e9df53a6c028e17e699de332f4d21aa49ca65964e78e41863754b44afc989d4348a4125cd8800fba87f387fb597a9f94a995aaa54d52a65348724a79d64ed182ac83c7ae07786b752fac0b4abf2d48925519e4cdd19d6152734d762840f982bfbdf9c770cb145046c0e69bf82e6989d43a497494c1ce74fbaaf38a97964514f9b3136ea39e386a1bcafd32a541ae4c52ebb29e4cc21672807d3de1faad75616adc756a63d73d2e78224aa138e0f8705390ef6ce218dbfab343ae5e13353b7a59f6a594a20266544a89f7e7d23a14360db596a9bcd79e901853e4e21474a45210a0a5b9f8c23666616461048fc388c4bce4d257cbbc0fac3de0909c61ed859481b02e4a14896cadfda3b6e060c7a9dd4bb56e3d3696a0b2a0a984a8252a86128d55299c409b98506fd70aec60e2e2a84acd49252d1de71c157310da5f1bad75af3411c354d94f44960c6dfb35ffd9fcbc46aa1e5f023b3cda9a4ed567279e63c79f9f9f7894d3a94d8dc08d97a599af4c7a4054d1c9e0f78e2851f3001e91d772bfd5ff287e95275355beca52ea0b9b6a94c3994a8e002ac476bcec45d35d6da98207983f755981023e747eb7ad8eaa36b4800dcfb1587e5b5063b5f9264faa1b45d90d3c44caa737a599d438841f4c4222e2d65ac3b2b2f495ccb9b1b936f6ff081023bbe4363310c06174e012c73c8fbecb4558f3512dde91947d6ebb6dfb9f748cdac80ac80550f8e9a758f7138f091abad6a2578c81981022d78fe5bc131483554c2d71e57b6fbd9437c11b582c17beadaa6d6b2bd5ad36aab45e62a128a437e627eea88ef109b597a69abe925d6c9794cbd23f1a90821ec9049f6810235793e6765ec79d86d16d13d8db8f0e7b8f026dba4a43724782484cdbb5b99ba26adda3a1b5aa697f3171780043e5d38f4bcf4faddb82eba8b696e5d1b594b7f37681022e19d719ada1c2008481ab7bf5fc54887e72a5ac3c8a37d4c92a753275326d4b04a654fd9948ef08dafdc6c20b49f82de54a05449c0c7b40810ec1cba6859a89dc5d0ca684f44a4a04a5226e55993329f2baa0a23fe11a6a9d9949a5d35caa4820b2ea65d43723f7863b408110249a78f1385a1c6ce3ba9ec0d8e17003a2743c376934895b4272df9d69494cf3aa7169472140fa98e5af7a436735a90ec8d1d8506cab2b278810239d54545453711aadf1bc8bb2f6bed71ff0069cf2598409073dffa2f0d0e8346b0e6c4fb52fe66700e467f387f2cead89ab61aa935b885a404a49c40811971d69968db33c924fb14aca33c9f2d2df1693f7af73197de07eea527720673927bc78ae72e196752d286e528a471d93881022b30584a001cd74995b71cd459d7e6aa1469a5aa5dc48429b51751fdf57a0311fee5a84d381c4e400b1cb638da7f181023d29945dab0d6dc2e4b89b032b5cd092f31f64a521c5288523beeec441716de7141617b891f36e3d8fb408117869b354002cbd92d4d71d03781fc63d52f6887f869dce7dcc0810c7bc8582595ede4bd32b66154ca1a79de0ab1c183bacdb0cd2e4d090bc9dbc408110dce3db59427cf239c01ea931514add5e7681b4620bbc958576f581022646a7b0696ecbd2d4bef21c48e0f11e9fd5cf1e401fc60408ca9cbffd9'##"
    ),
    'Greek'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book_Copies
# ------------------------------------------------------------

INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (1, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (1, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (1, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (1, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (2, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (2, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (2, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (2, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (3, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (3, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (3, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (3, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (4, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (4, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (4, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (4, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (5, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (5, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (5, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (5, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (6, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (6, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (6, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (6, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (7, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (7, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (7, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (7, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (8, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (8, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (8, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (8, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (9, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (9, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (9, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (9, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (10, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (10, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (10, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (10, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (11, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (11, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (11, 3, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (11, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (12, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (12, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (12, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (12, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (13, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (13, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (13, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (13, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (14, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (14, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (14, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (14, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (15, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (15, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (15, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (15, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (16, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (16, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (16, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (16, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (17, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (17, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (17, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (17, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (18, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (18, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (18, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (18, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (19, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (19, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (19, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (19, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (20, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (20, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (20, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (20, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (21, 1, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (21, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (21, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (21, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (22, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (22, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (22, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (22, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (23, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (23, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (23, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (23, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (24, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (24, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (24, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (24, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (25, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (25, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (25, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (25, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (26, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (26, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (26, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (26, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (27, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (27, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (27, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (27, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (28, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (28, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (28, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (28, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (29, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (29, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (29, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (29, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (30, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (30, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (30, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (30, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (31, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (31, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (31, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (31, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (32, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (32, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (32, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (32, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (33, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (33, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (33, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (33, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (34, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (34, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (34, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (34, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (35, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (35, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (35, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (35, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (36, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (36, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (36, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (36, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (37, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (37, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (37, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (37, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (38, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (38, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (38, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (38, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (39, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (39, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (39, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (39, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (40, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (40, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (40, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (40, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (41, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (41, 2, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (41, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (41, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (42, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (42, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (42, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (42, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (43, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (43, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (43, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (43, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (44, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (44, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (44, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (44, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (45, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (45, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (45, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (45, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (46, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (46, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (46, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (46, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (47, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (47, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (47, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (47, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (48, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (48, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (48, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (48, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (49, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (49, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (49, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (49, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (50, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (50, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (50, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (50, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (51, 1, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (51, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (51, 3, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (51, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (52, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (52, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (52, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (52, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (53, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (53, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (53, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (53, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (54, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (54, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (54, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (54, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (55, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (55, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (55, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (55, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (56, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (56, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (56, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (56, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (57, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (57, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (57, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (57, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (58, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (58, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (58, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (58, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (59, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (59, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (59, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (59, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (60, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (60, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (60, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (60, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (61, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (61, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (61, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (61, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (62, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (62, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (62, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (62, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (63, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (63, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (63, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (63, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (64, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (64, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (64, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (64, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (65, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (65, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (65, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (65, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (66, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (66, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (66, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (66, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (67, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (67, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (67, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (67, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (68, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (68, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (68, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (68, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (69, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (69, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (69, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (69, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (70, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (70, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (70, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (70, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (71, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (71, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (71, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (71, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (72, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (72, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (72, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (72, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (73, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (73, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (73, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (73, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (74, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (74, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (74, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (74, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (75, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (75, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (75, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (75, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (76, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (76, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (76, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (76, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (77, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (77, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (77, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (77, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (78, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (78, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (78, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (78, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (79, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (79, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (79, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (79, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (80, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (80, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (80, 3, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (80, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (81, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (81, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (81, 3, 5);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (81, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (82, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (82, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (82, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (82, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (83, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (83, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (83, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (83, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (84, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (84, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (84, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (84, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (85, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (85, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (85, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (85, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (86, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (86, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (86, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (86, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (87, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (87, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (87, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (87, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (88, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (88, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (88, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (88, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (89, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (89, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (89, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (89, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (90, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (90, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (90, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (90, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (91, 1, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (91, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (91, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (91, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (92, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (92, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (92, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (92, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (93, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (93, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (93, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (93, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (94, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (94, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (94, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (94, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (95, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (95, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (95, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (95, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (96, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (96, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (96, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (96, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (97, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (97, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (97, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (97, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (98, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (98, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (98, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (98, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (99, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (99, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (99, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (99, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (100, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (100, 2, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (100, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (100, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (101, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (101, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (101, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (101, 4, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (102, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (102, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (102, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (102, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (103, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (103, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (103, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (103, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (104, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (104, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (104, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (104, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (105, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (105, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (105, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (105, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (106, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (106, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (106, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (106, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (107, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (107, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (107, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (107, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (108, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (108, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (108, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (108, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (109, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (109, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (109, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (109, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (110, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (110, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (110, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (110, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (111, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (111, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (111, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (111, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (112, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (112, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (112, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (112, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (113, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (113, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (113, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (113, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (114, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (114, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (114, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (114, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (115, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (115, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (115, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (115, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (116, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (116, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (116, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (116, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (117, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (117, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (117, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (117, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (118, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (118, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (118, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (118, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (119, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (119, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (119, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (119, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (120, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (120, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (120, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (120, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (121, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (121, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (121, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (121, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (122, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (122, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (122, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (122, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (123, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (123, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (123, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (123, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (124, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (124, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (124, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (124, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (125, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (125, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (125, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (125, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (126, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (126, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (126, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (126, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (127, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (127, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (127, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (127, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (128, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (128, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (128, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (128, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (129, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (129, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (129, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (129, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (130, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (130, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (130, 3, 6);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (130, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (131, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (131, 2, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (131, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (131, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (132, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (132, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (132, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (132, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (133, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (133, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (133, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (133, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (134, 1, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (134, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (134, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (134, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (135, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (135, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (135, 3, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (135, 4, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (136, 1, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (136, 2, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (136, 3, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (136, 4, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (137, 1, 7);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (137, 2, 8);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (137, 3, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (137, 4, 9);
INSERT INTO
  `Book_Copies` (`Book_id`, `School_id`, `Copies`)
VALUES
  (138, 1, 50);

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
  (2, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (3, 17);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (4, 12);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (5, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (6, 44);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (7, 2);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (8, 26);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (9, 25);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (10, 46);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (11, 5);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (12, 35);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (13, 12);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (14, 4);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (15, 34);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (16, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (17, 36);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (18, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (19, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (20, 38);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (21, 25);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (22, 13);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (23, 37);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (24, 48);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (25, 29);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (26, 49);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (27, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (28, 43);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (29, 40);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (30, 19);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (31, 25);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (32, 16);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (33, 5);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (34, 26);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (35, 14);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (36, 43);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (37, 24);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (38, 37);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (39, 15);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (40, 14);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (41, 25);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (42, 30);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (43, 27);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (44, 45);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (45, 44);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (46, 31);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (47, 26);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (48, 35);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (49, 45);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (50, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (51, 20);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (52, 37);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (53, 24);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (54, 7);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (55, 12);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (56, 40);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (57, 14);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (58, 50);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (59, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (60, 30);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (61, 33);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (62, 22);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (63, 11);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (64, 38);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (65, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (66, 15);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (67, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (68, 35);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (69, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (70, 25);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (71, 7);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (72, 11);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (73, 33);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (74, 33);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (75, 14);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (76, 20);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (77, 8);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (78, 29);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (79, 20);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (80, 11);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (81, 46);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (82, 45);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (83, 37);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (84, 48);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (85, 31);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (86, 10);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (87, 7);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (88, 3);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (89, 45);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (90, 16);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (91, 45);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (92, 25);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (93, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (94, 30);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (95, 24);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (96, 30);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (97, 27);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (98, 45);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (99, 44);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (100, 35);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (101, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (102, 48);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (103, 19);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (104, 49);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (105, 40);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (106, 50);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (107, 32);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (108, 7);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (109, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (110, 32);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (111, 39);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (112, 46);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (113, 14);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (114, 29);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (115, 4);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (116, 32);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (117, 47);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (118, 38);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (119, 48);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (120, 26);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (121, 37);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (122, 6);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (123, 20);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (124, 32);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (125, 47);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (126, 38);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (127, 1);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (128, 41);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (129, 49);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (130, 24);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (131, 21);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (132, 31);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (133, 43);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (134, 19);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (135, 19);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (136, 35);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (137, 17);
INSERT INTO
  `Book_authors` (`Book_id`, `Author_id`)
VALUES
  (138, 51);

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
INSERT INTO
  `Book_categories` (`Book_id`, `Category_id`)
VALUES
  (138, 29);

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
INSERT INTO
  `Book_keywords` (`Book_id`, `Keyword_id`)
VALUES
  (138, 2);

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
INSERT INTO
  `Keyword` (`Keyword_id`, `Keyword`)
VALUES
  (2, 'Ναρκωτικά');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Loan
# ------------------------------------------------------------

INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    1,
    '2023-03-05',
    '2023-04-10',
    '2023-04-08',
    'RETURNED',
    10,
    60
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    2,
    '2023-03-06',
    '2023-04-11',
    '2023-04-10',
    'RETURNED',
    20,
    30
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    3,
    '2023-03-07',
    '2023-04-12',
    '2023-04-11',
    'RETURNED',
    30,
    40
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    4,
    '2023-03-08',
    '2023-04-13',
    '2023-04-12',
    'RETURNED',
    40,
    60
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    5,
    '2023-03-09',
    '2023-04-14',
    '2023-04-13',
    'RETURNED',
    50,
    5
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    6,
    '2023-03-10',
    '2023-04-15',
    '2023-04-14',
    'RETURNED',
    60,
    15
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    7,
    '2022-03-11',
    '2023-04-16',
    '2023-04-15',
    'RETURNED',
    70,
    55
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    8,
    '2023-04-12',
    '2023-04-17',
    '2023-04-16',
    'RETURNED',
    80,
    35
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    9,
    '2023-04-13',
    '2023-04-18',
    '2023-04-17',
    'RETURNED',
    90,
    45
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    10,
    '2023-04-14',
    '2023-04-19',
    '2023-04-18',
    'RETURNED',
    100,
    1
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    11,
    '2023-04-15',
    '2023-04-20',
    '2023-04-19',
    'RETURNED',
    110,
    11
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    12,
    '2023-04-16',
    '2023-04-21',
    '2023-04-20',
    'RETURNED',
    120,
    21
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    13,
    '2023-04-17',
    '2023-04-22',
    '2023-04-21',
    'RETURNED',
    130,
    51
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    14,
    '2023-04-18',
    '2023-04-23',
    '2023-04-22',
    'RETURNED',
    10,
    41
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    15,
    '2023-04-19',
    '2023-04-24',
    '2023-04-23',
    'RETURNED',
    1,
    6
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    16,
    '2023-04-20',
    '2023-04-25',
    '2023-04-24',
    'RETURNED',
    11,
    16
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    17,
    '2023-04-21',
    '2023-04-26',
    '2023-04-25',
    'RETURNED',
    21,
    26
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    18,
    '2023-04-22',
    '2023-04-27',
    '2023-04-26',
    'RETURNED',
    31,
    36
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    19,
    '2023-04-23',
    '2023-04-28',
    '2023-04-27',
    'RETURNED',
    41,
    46
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    20,
    '2023-04-24',
    '2023-04-29',
    '2023-04-28',
    'RETURNED',
    51,
    2
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    21,
    '2023-05-05',
    '2023-06-07',
    NULL,
    'BORROWED',
    60,
    7
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    22,
    '2023-05-06',
    '2023-06-08',
    NULL,
    'BORROWED',
    70,
    17
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    23,
    '2023-05-07',
    '2023-06-09',
    NULL,
    'BORROWED',
    80,
    27
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    24,
    '2023-05-08',
    '2023-06-10',
    NULL,
    'BORROWED',
    90,
    37
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    25,
    '2023-04-09',
    '2023-06-11',
    NULL,
    'BORROWED',
    100,
    47
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    26,
    '2023-04-10',
    '2023-06-12',
    NULL,
    'BORROWED',
    110,
    3
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    27,
    '2023-04-11',
    '2023-06-13',
    NULL,
    'BORROWED',
    120,
    13
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    28,
    '2023-04-12',
    '2023-06-14',
    NULL,
    'BORROWED',
    130,
    53
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    29,
    '2023-04-13',
    '2023-06-15',
    NULL,
    'BORROWED',
    14,
    33
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    30,
    '2023-04-14',
    '2023-06-16',
    NULL,
    'BORROWED',
    1,
    43
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    31,
    '2023-04-15',
    '2023-06-17',
    NULL,
    'BORROWED',
    11,
    8
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    32,
    '2023-04-16',
    '2023-06-18',
    NULL,
    'BORROWED',
    21,
    18
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    33,
    '2023-04-17',
    '2023-06-19',
    NULL,
    'BORROWED',
    31,
    58
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    34,
    '2023-04-18',
    '2023-06-20',
    NULL,
    'BORROWED',
    41,
    38
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    35,
    '2023-04-19',
    '2023-06-21',
    NULL,
    'BORROWED',
    51,
    48
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    36,
    '2023-04-20',
    '2023-06-22',
    NULL,
    'BORROWED',
    61,
    4
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    37,
    '2023-04-21',
    '2023-06-23',
    NULL,
    'BORROWED',
    71,
    1
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    38,
    '2023-04-22',
    '2023-06-24',
    NULL,
    'BORROWED',
    81,
    24
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    39,
    '2023-04-23',
    '2023-06-25',
    NULL,
    'BORROWED',
    91,
    1
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    40,
    '2023-04-24',
    '2023-06-26',
    NULL,
    'BORROWED',
    101,
    44
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    41,
    '2023-04-18',
    '2023-06-20',
    NULL,
    'BORROWED',
    41,
    1
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    42,
    '2023-04-19',
    '2023-06-21',
    NULL,
    'BORROWED',
    51,
    1
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    43,
    '2023-04-20',
    '2023-06-22',
    NULL,
    'BORROWED',
    61,
    4
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    44,
    '2023-04-21',
    '2023-06-23',
    NULL,
    'BORROWED',
    71,
    4
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    45,
    '2023-04-22',
    '2023-06-24',
    NULL,
    'BORROWED',
    81,
    4
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    46,
    '2023-04-23',
    '2023-06-25',
    NULL,
    'BORROWED',
    91,
    4
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (
    47,
    '2023-04-24',
    '2023-06-26',
    NULL,
    'BORROWED',
    101,
    4
  );
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (48, '2023-04-05', '2023-06-05', NULL, 'LATE', 62, 9);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (49, '2023-04-06', '2023-06-04', NULL, 'LATE', 72, 19);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (50, '2023-04-07', '2023-06-03', NULL, 'LATE', 82, 29);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (51, '2023-04-08', '2023-06-02', NULL, 'LATE', 92, 39);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (52, '2023-04-09', '2023-06-01', NULL, 'LATE', 102, 49);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (53, '2023-04-10', '2023-06-05', NULL, 'LATE', 112, 51);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (54, '2023-04-11', '2023-06-04', NULL, 'LATE', 122, 15);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (55, '2023-04-12', '2023-06-03', NULL, 'LATE', 132, 25);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (56, '2023-04-13', '2023-06-02', NULL, 'LATE', 6, 35);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (57, '2023-04-14', '2023-06-01', NULL, 'LATE', 16, 45);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (58, '2023-04-15', '2023-06-05', NULL, 'LATE', 26, 10);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (59, '2023-04-16', '2023-06-04', NULL, 'LATE', 36, 20);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (60, '2023-04-17', '2023-06-03', NULL, 'LATE', 46, 30);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (61, '2023-04-18', '2023-06-02', NULL, 'LATE', 56, 40);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (62, '2023-04-19', '2023-06-01', NULL, 'LATE', 66, 50);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (63, '2023-04-20', '2023-06-05', NULL, 'LATE', 76, 6);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (64, '2023-04-21', '2023-06-04', NULL, 'LATE', 86, 16);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (65, '2023-04-22', '2023-06-03', NULL, 'LATE', 96, 26);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (66, '2023-04-23', '2023-06-02', NULL, 'LATE', 106, 36);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (67, '2023-04-24', '2023-06-01', NULL, 'LATE', 116, 46);
INSERT INTO
  `Loan` (
    `Loan_id`,
    `Date_out`,
    `Due_date`,
    `Return_date`,
    `Status`,
    `Book_id`,
    `User_id`
  )
VALUES
  (68, '2023-06-08', '2023-06-15', NULL, 'BORROWED', 2, 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Reservation
# ------------------------------------------------------------

INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (1, '2023-04-05', 10, 15);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (2, '2023-04-05', 20, 25);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (3, '2023-04-05', 30, 35);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (4, '2023-04-05', 40, 45);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (5, '2023-04-05', 50, 5);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (6, '2023-04-05', 60, 60);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (7, '2023-04-05', 70, 20);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (8, '2023-04-05', 80, 30);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (9, '2023-04-05', 90, 40);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (10, '2023-04-05', 100, 50);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (11, '2023-04-05', 110, 15);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (12, '2023-04-05', 120, 25);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (13, '2023-04-05', 130, 35);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (14, '2023-04-05', 1, 45);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (15, '2023-04-05', 11, 5);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (16, '2023-04-05', 21, 10);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (17, '2023-04-05', 31, 20);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (18, '2023-04-05', 41, 30);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (19, '2023-04-05', 51, 40);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (20, '2023-04-06', 61, 50);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (21, '2023-04-06', 71, 15);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (22, '2023-04-06', 81, 25);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (23, '2023-04-06', 91, 35);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (24, '2023-04-06', 101, 45);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (25, '2023-04-06', 111, 5);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (26, '2023-04-06', 121, 10);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (27, '2023-04-06', 131, 20);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (28, '2023-04-06', 2, 30);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (29, '2023-04-06', 12, 40);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (30, '2023-04-06', 22, 50);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (31, '2023-04-06', 32, 15);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (32, '2023-04-06', 42, 25);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (33, '2023-04-06', 52, 35);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (34, '2023-04-06', 62, 45);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (35, '2023-04-06', 72, 5);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (36, '2023-04-06', 82, 10);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (37, '2023-04-06', 92, 20);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (38, '2023-04-06', 102, 30);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (39, '2023-04-06', 112, 40);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (40, '2023-04-06', 122, 50);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (41, '2023-04-07', 132, 15);
INSERT INTO
  `Reservation` (`Reservation_id`, `Date_`, `Book_id`, `User_id`)
VALUES
  (42, '2023-04-07', 3, 25);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Review
# ------------------------------------------------------------

INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (1, 4, 'Great book!', 1, 1);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (2, 5, 'Highly recommended!', 2, 2);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (3, 3, 'Average read.', 1, 3);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (4, 2, 'Not impressed.', 3, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (5, 5, 'Loved it!', 4, 4);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (6, 4, 'Well written.', 5, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (7, 5, 'Amazing!', 137, 10);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (8, 4, 'Enjoyable.', 50, 8);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (9, 3, 'Decent book.', 6, 5);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (10, 2, 'Disappointing.', 7, 6);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (11, 4, 'Intriguing plot.', 8, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (12, 5, 'A must-read!', 9, 7);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (13, 4, 'Well-crafted characters.', 10, 9);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (14, 1, 'Terrible!', 11, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (15, 3, 'Okay read.', 12, 15);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (16, 5, 'Couldnt put it down!', 13, 12);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (17, 4, 'Thought-provoking.', 14, 11);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (18, 5, 'Brilliant masterpiece!', 15, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (19, 2, 'Not my cup of tea.', 16, 14);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (20, 4, 'Captivating story.', 17, 16);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (21, 3, 'Meh.', 18, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (22, 5, 'Exceeded my expectations!', 19, 17);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (23, 4, 'Highly engaging.', 20, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (24, 2, 'Couldn\'t get into it.', 21, 18);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (25, 4, 'Well-researched.', 22, 20);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (26, 3, 'Good but not great.', 23, 21);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (27, 5, 'Absolutely loved it!', 24, 23);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (28, 4, 'Impressive writing style.', 25, 22);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (29, 1, 'Worst book ever!', 26, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (30, 3, 'Not bad.', 27, 26);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (31, 5, 'Couldnt stop reading!', 28, 24);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (32, 4, 'Unique storyline.', 29, 25);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (33, 5, 'A new favorite!', 30, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (34, 2, 'Didnt enjoy it.', 31, 28);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (35, 4, 'Kept me hooked till the end.', 32, 30);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (36, 3, 'Fairly enjoyable.', 33, 29);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (37, 5, 'Absolutely mesmerizing!', 34, 32);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (38, 4, 'Solid book.', 35, 31);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (39, 1, 'Total waste of time.', 36, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (40, 3, 'Decent read.', 37, 36);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (41, 5, 'Couldnt recommend it enough!', 38, 34);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (42, 4, 'Gripping narrative.', 39, 33);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (43, 5, 'A true page-turner!', 40, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (44, 2, 'Didnt meet my expectations.', 41, 39);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (45, 4, 'Well-paced storyline.', 42, 41);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (46, 3, 'Just okay.', 43, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (47, 5, 'Unputdownable!', 44, 43);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (48, 4, 'Compelling characters.', 45, 42);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (49, 1, 'Awful!', 46, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (50, 3, 'Nothing special.', 47, 46);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (51, 5, 'Masterfully written!', 48, 45);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (52, 4, 'Enjoyed every page.', 49, 44);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (53, 5, 'An absolute gem!', 50, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (54, 4, 'Great book!', 1, 1);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (55, 5, 'Highly recommended!', 2, 2);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (56, 3, 'Average read.', 1, 53);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (57, 2, 'Not impressed.', 3, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (58, 5, 'Loved it!', 4, 54);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (59, 4, 'Well written.', 5, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (60, 5, 'Amazing!', 17, 6);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (61, 4, 'Enjoyable.', 50, 8);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (62, 3, 'Decent book.', 6, 5);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (63, 2, 'Disappointing.', 7, 6);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (64, 4, 'Intriguing plot.', 8, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (65, 5, 'A must-read!', 9, 57);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (66, 4, 'Well-crafted characters.', 10, 9);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (67, 1, 'Terrible!', 11, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (68, 3, 'Okay read.', 12, 6);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (69, 5, 'Couldnt put it down!', 13, 6);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (70, 4, 'Thought-provoking.', 14, 6);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (71, 5, 'Brilliant masterpiece!', 15, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (72, 2, 'Not my cup of tea.', 16, 6);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (73, 4, 'Captivating story.', 17, 6);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (74, 3, 'Meh.', 18, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (75, 5, 'Exceeded my expectations!', 19, 6);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (76, 4, 'Highly engaging.', 20, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (77, 2, 'Couldnt get into it.', 21, 28);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (78, 4, 'Well-researched.', 22, 20);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (79, 3, 'Good but not great.', 23, 7);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (80, 5, 'Absolutely loved it!', 24, 7);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (81, 4, 'Impressive writing style.', 25, 7);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (82, 1, 'Worst book ever!', 26, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (83, 3, 'Not bad.', 27, 7);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (84, 5, 'Couldnt stop reading!', 28, 7);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (85, 4, 'Unique storyline.', 29, 7);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (86, 5, 'A new favorite!', 30, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (87, 2, 'Didnt enjoy it.', 31, 38);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (88, 4, 'Kept me hooked till the end.', 32, 8);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (89, 3, 'Fairly enjoyable.', 33, 3);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (90, 5, 'Absolutely mesmerizing!', 34, 2);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (91, 4, 'Solid book.', 35, 8);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (92, 1, 'Total waste of time.', 36, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (93, 3, 'Decent read.', 37, 8);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (94, 5, 'Couldnt recommend it enough!', 38, 8);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (95, 4, 'Gripping narrative.', 39, 8);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (96, 5, 'A true page-turner!', 40, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (97, 2, 'Didnt meet my expectations.', 41, 8);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (98, 4, 'Well-paced storyline.', 42, 9);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (99, 3, 'Just okay.', 43, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (100, 5, 'Unputdownable!', 44, 3);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (101, 4, 'Compelling characters.', 45, 9);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (102, 1, 'Awful!', 46, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (103, 3, 'Nothing special.', 47, 9);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (104, 5, 'Masterfully written!', 48, 9);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (105, 4, 'Enjoyed every page.', 49, 9);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (106, 5, 'An absolute gem!', 50, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (107, 4, 'Great book!', 1, 11);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (108, 5, 'Highly recommended!', 2, 12);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (109, 3, 'Average read.', 1, 13);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (110, 2, 'Not impressed.', 3, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (111, 5, 'Loved it!', 4, 10);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (112, 4, 'Well written.', 5, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (113, 5, 'Amazing!', 137, 11);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (114, 4, 'Enjoyable.', 50, 10);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (115, 3, 'Decent book.', 6, 10);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (116, 2, 'Disappointing.', 7, 10);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (117, 4, 'Intriguing plot.', 8, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (118, 5, 'A must-read!', 9, 10);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (119, 4, 'Well-crafted characters.', 10, 10);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (120, 1, 'Terrible!', 11, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (121, 3, 'Okay read.', 12, 15);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (122, 5, 'Couldnt put it down!', 13, 12);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (123, 4, 'Thought-provoking.', 14, 11);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (124, 5, 'Brilliant masterpiece!', 15, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (125, 2, 'Not my cup of tea.', 16, 14);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (126, 4, 'Captivating story.', 17, 16);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (127, 3, 'Meh.', 18, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (128, 5, 'Exceeded my expectations!', 19, 17);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (129, 4, 'Highly engaging.', 20, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (130, 2, 'Couldnt get into it.', 21, 18);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (131, 4, 'Well-researched.', 22, 20);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (132, 3, 'Good but not great.', 23, 21);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (133, 5, 'Absolutely loved it!', 24, 23);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (134, 4, 'Impressive writing style.', 25, 22);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (135, 1, 'Worst book ever!', 26, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (136, 3, 'Not bad.', 27, 26);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (137, 5, 'Couldnt stop reading!', 28, 24);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (138, 4, 'Unique storyline.', 29, 25);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (139, 5, 'A new favorite!', 30, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (140, 2, 'Didnt enjoy it.', 31, 28);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (141, 4, 'Kept me hooked till the end.', 32, 30);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (142, 3, 'Fairly enjoyable.', 33, 29);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (143, 5, 'Absolutely mesmerizing!', 34, 32);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (144, 4, 'Solid book.', 35, 31);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (145, 1, 'Total waste of time.', 36, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (146, 3, 'Decent read.', 37, 36);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (147, 5, 'Couldnt recommend it enough!', 38, 14);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (148, 4, 'Gripping narrative.', 39, 33);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (149, 5, 'A true page-turner!', 40, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (150, 2, 'Didnt meet my expectations.', 41, 1);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (151, 4, 'Well-paced storyline.', 42, 1);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (152, 3, 'Just okay.', 43, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (153, 5, 'Unputdownable!', 44, 1);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (154, 4, 'Compelling characters.', 45, 1);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (155, 1, 'Awful!', 46, NULL);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (156, 3, 'Nothing special.', 47, 1);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (157, 5, 'Masterfully written!', 48, 41);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (158, 4, 'Enjoyed every page.', 49, 21);
INSERT INTO
  `Review` (
    `Review_id`,
    `Rating`,
    `Review`,
    `Book_id`,
    `User_id`
  )
VALUES
  (159, 5, 'An absolute gem!', 50, NULL);

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
    '1ο Λύκειο Αθηνών',
    'Σταδίου 40',
    'Αθήνα',
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
    '2ο Γυμνάσιο Πατρών',
    'Χίου 2',
    'Πάτρα',
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
    'Λύκειο Πάρου',
    'Κολοκοτρώνη 10',
    'Παροικιά',
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
    '3ο Λύκειο Γλυφάδας',
    'Κύπρου 36',
    'Γλυφάδα',
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
    IF NEW.Status = 'BORROWED' THEN
	    UPDATE Book_Copies b INNER JOIN User u ON u.User_id = NEW.User_id
        SET b.Copies = b.Copies - 1
        WHERE b.Book_id = NEW.Book_id AND b.School_id = u.School_id;
    END IF;;
DELIMITER ;

# ------------------------------------------------------------
# TRIGGER DUMP FOR: subtract_copies_after_loan_granted
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS subtract_copies_after_loan_granted;
DELIMITER ;;
CREATE TRIGGER IF NOT EXISTS subtract_copies_after_loan_granted
AFTER UPDATE ON Loan FOR EACH ROW
    IF OLD.Status = 'REQUESTED' AND NEW.Status = 'BORROWED' THEN
	    UPDATE Book_Copies b INNER JOIN User u ON u.User_id = NEW.User_id
        SET b.Copies = b.Copies - 1
        WHERE b.Book_id = NEW.Book_id AND b.School_id = u.School_id;
    END IF;;
DELIMITER ;

# ------------------------------------------------------------
# TRIGGER DUMP FOR: add_copy_after_return
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS add_copy_after_return;
DELIMITER ;;
CREATE TRIGGER IF NOT EXISTS add_copy_after_return
AFTER UPDATE ON Loan FOR EACH ROW
    IF NEW.Status = 'RETURNED' AND OLD.Status <> 'RETURNED' THEN
        UPDATE Book_Copies b INNER JOIN User u ON u.User_id = NEW.User_id
        SET b.Copies = b.Copies - 1
        WHERE b.Book_id = NEW.Book_id AND b.School_id = u.School_id;
    END IF;;
DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
