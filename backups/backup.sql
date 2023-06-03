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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Book
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Book` (
  `Book_id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(80) NOT NULL,
  `Publisher` varchar(30) NOT NULL,
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

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
  `Copies` between 1
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
  PRIMARY KEY (`Category_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: Keyword
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `Keyword` (
  `Keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `Keyword` varchar(30) NOT NULL,
  PRIMARY KEY (`Keyword_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

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
  CONSTRAINT `Loan_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Loan_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `User` (`User_id`) ON DELETE CASCADE
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
  CONSTRAINT `Reservation_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Reservation_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `User` (`User_id`) ON DELETE CASCADE
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
  CONSTRAINT `Review_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`) ON DELETE CASCADE,
  CONSTRAINT `Review_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `User` (`User_id`) ON DELETE
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
  `Head_id` int(11) DEFAULT NULL,
  `Library_op_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`School_id`),
  KEY `Head_id` (`Head_id`),
  KEY `Library_op_id` (`Library_op_id`),
  CONSTRAINT `School_ibfk_1` FOREIGN KEY (`Head_id`) REFERENCES `User` (`User_id`) ON DELETE
  SET
  NULL,
  CONSTRAINT `School_ibfk_2` FOREIGN KEY (`Library_op_id`) REFERENCES `User` (`User_id`) ON DELETE
  SET
  NULL,
  CONSTRAINT `CONSTRAINT_1` CHECK (`Email` regexp '.+@.+(.com|.gr)$')
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: User
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `User` (
  `User_id` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Usertype` enum('Admin', 'Library Operator', 'Student', 'Teacher') NOT NULL,
  `School_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`User_id`),
  UNIQUE KEY `Username` (`Username`),
  KEY `School_id` (`School_id`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`School_id`) REFERENCES `School` (`School_id`) ON DELETE
  SET
  NULL
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Author
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book_Copies
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book_authors
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book_categories
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Book_keywords
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Category
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: Keyword
# ------------------------------------------------------------


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


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: User
# ------------------------------------------------------------

INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    1,
    'admin',
    '$2b$10$rqhAkhPihA.dZLA/JZXh.ekeDGm026C0dGYLg/Eog4oHFTtI4yPiS',
    'Sweller',
    'Admin',
    NULL
  );
INSERT INTO
  `User` (
    `User_id`,
    `Username`,
    `Password`,
    `Name`,
    `Usertype`,
    `School_id`
  )
VALUES
  (
    2,
    'admin2',
    '$2b$10$ctbGpYU50Lc.GCn2DuKibu.jwrmEaxSnuNS57q7pUtu8Q1422twNi',
    'Sweller',
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
