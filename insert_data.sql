INSERT INTO School
(`Name`,`Address`,`City`, 'Phone', 'Email', 'Head_id', 'Library_op_id')
VALUES
(`1ο Λύκειο Αθηνών`,`Σταδίου 40`,`Αθήνα`, '2102324000', '1ogel@gmail.com', '1', '5')
;

INSERT INTO School
(`Name`,`Address`,`City`, 'Phone', 'Email', 'Head_id', 'Library_op_id')
VALUES
(`2ο Γυμνάσιο Πατρών`,`Χίου 2`,`Πάτρα`, '3452324000', '2opatr@gmail.com', '2', '6')
;

INSERT INTO School
(`Name`,`Address`,`City`, 'Phone', 'Email', 'Head_id', 'Library_op_id')
VALUES
(`Λύκειο Πάρου`,`Κολοκοτρώνη 10`,`Παροικιά`, '5432324000', 'lykparou@gmail.com', '3', '7')
;

INSERT INTO School
(`Name`,`Address`,`City`, 'Phone', 'Email', 'Head_id', 'Library_op_id')
VALUES
(`3ο Λύκειο Γλυφάδας`,`Κύπρου 36`,`Γλυφάδα`, '2102325430', '3olyk@gmail.com', '4', '8')
;

-- Set the number of entries you want to generate
SET @num_entries = 120;

-- Declare variables for the loop
SET @counter = 1;

-- List of common book titles
SET @book_titles = '["The Great Gatsby", "To Kill a Mockingbird", "1984", "Pride and Prejudice", "The Catcher in the Rye", "Harry Potter and the Sorcerer''s Stone", "The Hobbit", "The Lord of the Rings", "The Da Vinci Code", "The Hunger Games", "The Alchemist", "The Girl with the Dragon Tattoo", "Gone Girl", "The Fault in Our Stars", "Brave New World", "The Chronicles of Narnia", "The Shining", "A Game of Thrones", "The Kite Runner", "The Book Thief"]';

-- List of publishers
SET @publishers = '["Κλειδάριθμος", "Πατάκης", "Σαββάλας", "Spigel", "McMuffin", "Eulap", "Kyknos"]';

-- List of languages
SET @languages = '["Greek", "English", "French", "German", "Russian", "Spanish", "Italian", "Chinese", "Japanese", "Portuguese"]';

-- Start the loop
WHILE @counter <= @num_entries DO
    -- Generate random values or select a random title from the list
    SET @title = JSON_UNQUOTE(JSON_EXTRACT(@book_titles, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@book_titles)), ']')));
    SET @publisher = JSON_UNQUOTE(JSON_EXTRACT(@publishers, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@publishers)), ']')));
    SET @isbn = LPAD(FLOOR(RAND() * 9999999999999) + 1, 13, '0'); -- Generate 13-digit random number
    SET @pages = FLOOR(RAND() * 9999) + 1; -- Random value between 1 and 9999
    SET @summary = 'Summary';
    SET @language = JSON_UNQUOTE(JSON_EXTRACT(@languages, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@languages)), ']')));
    
    -- Insert the values into the Book table
    INSERT INTO Book (Title, Publisher, ISBN, Pages, Summary, Language)
    VALUES (@title, @publisher, @isbn, @pages, @summary, @language);
    
    -- Increment the counter
    SET @counter = @counter + 1;
END WHILE;


INSERT INTO User
(`Name`,`Address`,`City`, 'Phone', 'Email', 'Head_id', 'Library_op_id')
VALUES
(`3ο Λύκειο Γλυφάδας`,`Κύπρου 36`,`Γλυφάδα`, '2102325430', '3olyk@gmail.com', '4', '8')
;

INSERT INTO School
(`Name`,`Address`,`City`, 'Phone', 'Email', 'Head_id', 'Library_op_id')
VALUES
(`3ο Λύκειο Γλυφάδας`,`Κύπρου 36`,`Γλυφάδα`, '2102325430', '3olyk@gmail.com', '4', '8')
;

INSERT INTO School
(`Name`,`Address`,`City`, 'Phone', 'Email', 'Head_id', 'Library_op_id')
VALUES
(`3ο Λύκειο Γλυφάδας`,`Κύπρου 36`,`Γλυφάδα`, '2102325430', '3olyk@gmail.com', '4', '8')
;

INSERT INTO School
(`Name`,`Address`,`City`, 'Phone', 'Email', 'Head_id', 'Library_op_id')
VALUES
(`3ο Λύκειο Γλυφάδας`,`Κύπρου 36`,`Γλυφάδα`, '2102325430', '3olyk@gmail.com', '4', '8')
;


-- Set the number of entries you want to generate
SET @num_entries = 50;

-- Declare variables for the loop
SET @counter = 1;

-- List of common book titles
SET @book_titles = '["The Great Gatsby", "To Kill a Mockingbird", "1984", "Pride and Prejudice", "The Catcher in the Rye", "Harry Potter and the Sorcerer''s Stone", "The Hobbit", "The Lord of the Rings", "The Da Vinci Code", "The Hunger Games", "The Alchemist", "The Girl with the Dragon Tattoo", "Gone Girl", "The Fault in Our Stars", "Brave New World", "The Chronicles of Narnia", "The Shining", "A Game of Thrones", "The Kite Runner", "The Book Thief"]';

-- List of publishers
SET @publishers = '["Κλειδάριθμος", "Πατάκης", "Σαββάλας", "Spigel", "McMuffin", "Eulap", "Kyknos"]';

-- List of languages
SET @languages = '["Greek", "English", "French", "German", "Russian", "Spanish", "Italian", "Chinese", "Japanese", "Portuguese"]';

-- Start the loop
WHILE @counter <= @num_entries DO
    -- Generate random values or select a random title from the list
    SET @title = JSON_UNQUOTE(JSON_EXTRACT(@book_titles, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@book_titles)), ']')));
    SET @publisher = JSON_UNQUOTE(JSON_EXTRACT(@publishers, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@publishers)), ']')));
    SET @isbn = LPAD(FLOOR(RAND() * 9999999999999) + 1, 13, '0'); -- Generate 13-digit random number
    SET @pages = FLOOR(RAND() * 9999) + 1; -- Random value between 1 and 9999
    SET @summary = 'Summary';
    SET @language = JSON_UNQUOTE(JSON_EXTRACT(@languages, CONCAT('$[', FLOOR(RAND() * JSON_LENGTH(@languages)), ']')));
    
    -- Insert the values into the Book table
    INSERT INTO Book (Title, Publisher, ISBN, Pages, Summary, Language)
    VALUES (@title, @publisher, @isbn, @pages, @summary, @language);
    
    -- Increment the counter
    SET @counter = @counter + 1;
END WHILE;