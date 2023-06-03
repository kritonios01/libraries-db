INSERT INTO School (Name, Address, City, Phone, Email)
VALUES
('1ο Λύκειο Αθηνών','Σταδίου 40','Αθήνα', '2102324000', '1ogel@gmail.com'),
('2ο Γυμνάσιο Πατρών','Χίου 2','Πάτρα', '3452324000', '2opatr@gmail.com'),
('Λύκειο Πάρου','Κολοκοτρώνη 10','Παροικιά', '5432324000', 'lykparou@gmail.com'),
('3ο Λύκειο Γλυφάδας','Κύπρου 36','Γλυφάδα', '2102325430', '3olyk@gmail.com');



SET @password = '123456789';

INSERT INTO User (Username, Password, Name, Age, Usertype, School_id)
VALUES
('student1', @password, 'John Smith', 12, 'Student', 1),
('student2', @password, 'Jane Doe', 13, 'Student', 1),
('student3', @password, 'Mike Johnson', 14, 'Student', 2),
('student4', @password, 'Emily Brown', 15, 'Student', 3),
('student5', @password, 'David Wilson', 16, 'Student', 4),
('student6', @password, 'Sarah Davis', 17, 'Student', 2),
('student7', @password, 'Michael Miller', 18, 'Student', 1),
('student8', @password, 'Emma Garcia', 12, 'Student', 3),
('student9', @password, 'Daniel Martinez', 13, 'Student', 4),
('student10', @password, 'Olivia Smith', 14, 'Student', 2),
('student11', @password, 'Ethan Johnson', 15, 'Student', 3),
('student12', @password, 'Ava Davis', 16, 'Student', 4),
('student13', @password, 'Noah Wilson', 17, 'Student', 1),
('student14', @password, 'Isabella Brown', 18, 'Student', 2),
('student15', @password, 'William Garcia', 12, 'Student', 3),
('student16', @password, 'Sophia Martinez', 13, 'Student', 4),
('student17', @password, 'James Smith', 14, 'Student', 1),
('student18', @password, 'Mia Doe', 15, 'Student', 1),
('student19', @password, 'Benjamin Johnson', 16, 'Student', 2),
('student20', @password, 'Charlotte Brown', 17, 'Student', 3),
('student21', @password, 'Liam Wilson', 18, 'Student', 4),
('student22', @password, 'Amelia Davis', 12, 'Student', 2),
('student23', @password, 'Henry Miller', 13, 'Student', 1),
('student24', @password, 'Evelyn Garcia', 14, 'Student', 3),
('student25', @password, 'Alexander Martinez', 15, 'Student', 4),
('student26', @password, 'Sofia Smith', 16, 'Student', 2),
('student27', @password, 'Joseph Johnson', 17, 'Student', 3),
('student28', @password, 'Harper Davis', 18, 'Student', 4),
('student29', @password, 'David Wilson', 12, 'Student', 1),
('student30', @password, 'Abigail Brown', 13, 'Student', 2),
('student31', @password, 'Daniel Garcia', 14, 'Student', 3),
('student32', @password, 'Victoria Martinez', 15, 'Student', 4),
('student33', @password, 'Michael Smith', 16, 'Student', 1),
('student34', @password, 'Sophia Johnson', 17, 'Student', 2),
('student35', @password, 'James Davis', 18, 'Student', 3),
('student36', @password, 'Mia Wilson', 12, 'Student', 4),
('student37', @password, 'Benjamin Brown', 13, 'Student', 1),
('student38', @password, 'Charlotte Garcia', 14, 'Student', 2),
('student39', @password, 'Liam Martinez', 15, 'Student', 3),
('student40', @password, 'Amelia Smith', 16, 'Student', 4),
('student41', @password, 'Henry Johnson', 17, 'Student', 1),
('student42', @password, 'Evelyn Davis', 18, 'Student', 2),
('student43', @password, 'Alexander Wilson', 12, 'Student', 3),
('student44', @password, 'Sofia Brown', 13, 'Student', 4),
('student45', @password, 'Joseph Garcia', 14, 'Student', 1),
('student46', @password, 'Harper Martinez', 15, 'Student', 1),
('student47', @password, 'David Smith', 16, 'Student', 2),
('student48', @password, 'Abigail Johnson', 17, 'Student', 3),
('student49', @password, 'Daniel Davis', 18, 'Student', 4),
('student50', @password, 'Victoria Brown', 12, 'Student', 2),
('teacher1', @password, 'Robert Johnson', 32, 'Teacher', 1),
('teacher2', @password, 'Jennifer Smith', 29, 'Teacher', 2),
('teacher3', @password, 'Michael Brown', 35, 'Teacher', 3),
('teacher4', @password, 'Jessica Wilson', 37, 'Teacher', 1),
('teacher5', @password, 'Christopher Davis', 41, 'Teacher', 2),
('teacher6', @password, 'Emily Miller', 33, 'Teacher', 3),
('teacher7', @password, 'Matthew Garcia', 39, 'Teacher', 4),
('teacher8', @password, 'Ashley Martinez', 31, 'Teacher', 1),
('teacher9', @password, 'Daniel Smith', 28, 'Teacher', 2),
('teacher10', @password, 'Sophia Johnson', 36, 'Teacher', 3),
('director1', @password, 'John Anderson', 55, 'Director', 1),
('director2', @password, 'Sarah Thompson', 61, 'Director', 2),
('director3', @password, 'David Johnson', 58, 'Director', 3),
('director4', @password, 'Emily Wilson', 49, 'Director', 4),
('operator1', @password, 'Michael Davis', 28, 'Library Operator', 1),
('operator2', @password, 'Jessica Rodriguez', 35, 'Library Operator', 2),
('operator3', @password, 'Christopher Martinez', 31, 'Library Operator', 3),
('operator4', @password, 'Amanda Thompson', 26, 'Library Operator', 4),
('director', @password, 'John Smith', 90, 'Admin', 1);





INSERT INTO Book (Title, Publisher, ISBN, Pages, Summary, Image, Language)
VALUES
    ('The Alchemist', 'HarperOne', '9780062315007', 208, 'A story about following your dreams and finding your purpose in life.', NULL, 'English'),
    ('Pride and Prejudice', 'Penguin Books', '9780141439518', 432, 'A classic romantic novel by Jane Austen.', NULL, 'English'),
    ('To Kill a Mockingbird', 'Harper Perennial', '9780060935467', 336, 'A powerful story of racial injustice and the loss of innocence.', NULL, 'English'),
    ('1984', 'Signet Classics', '9780451524935', 328, 'A dystopian novel depicting a totalitarian society ruled by Big Brother.', NULL, 'English'),
    ('The Great Gatsby', 'Scribner', '9780743273565', 180, 'A tragic love story set in the Jazz Age.', NULL, 'English'),
    ('Moby Dick', 'Penguin Classics', '9780142437247', 720, 'A novel about a sea captains obsession with hunting a white whale.', NULL, 'English'),
    ('The Catcher in the Rye', 'Little, Brown and Company', '9780316769488', 234, 'A coming-of-age novel by J.D. Salinger.', NULL, 'English'),
    ('Jane Eyre', 'Penguin Classics', '9780141441146', 624, 'A Gothic novel by Charlotte Bronte.', NULL, 'English'),
    ('Brave New World', 'Harper Perennial', '9780060850524', 288, 'A dystopian novel by Aldous Huxley.', NULL, 'English'),
    ('The Lord of the Rings', 'Mariner Books', '9780544003415', 1216, 'An epic fantasy trilogy by J.R.R. Tolkien.', NULL, 'English'),
    ('Harry Potter and the Sorcerers Stone', 'Scholastic', '9780590353427', 320, 'The first book in the Harry Potter series by J.K. Rowling.', NULL, 'English'),
    ('The Hobbit', 'Mariner Books', '9780547928227', 400, 'A fantasy novel by J.R.R. Tolkien.', NULL, 'English'),
    ('The Chronicles of Narnia', 'HarperCollins', '9780066238500', 767, 'A series of fantasy novels by C.S. Lewis.', NULL, 'English'),
    ('Animal Farm', 'Signet Classics', '9780451526342', 112, 'A satirical novella by George Orwell.', NULL, 'English'),
    ('The Da Vinci Code', 'Anchor', '9780307474278', 597, 'A thriller novel by Dan Brown.', NULL, 'English'),
    ('Gone with the Wind', 'Grand Central Publishing', '9781451635621', 960, 'A historical novel by Margaret Mitchell.', NULL, 'English'),
    ('The Hunger Games', 'Scholastic', '9780439023481', 384, 'A dystopian novel by Suzanne Collins.', NULL, 'English'),
    ('The Fault in Our Stars', 'Dutton Books', '9780525478812', 313, 'A young adult novel by John Green.', NULL, 'English'),
    ('The Kite Runner', 'Riverhead Books', '9781594631931', 371, 'A novel by Khaled Hosseini.', NULL, 'English'),
    ('The Girl on the Train', 'Riverhead Books', '9781594634024', 323, 'A psychological thriller novel by Paula Hawkins.', NULL, 'English'),
    ('The Shining', 'Anchor', '9780345806789', 688, 'A horror novel by Stephen King.', NULL, 'English'),
    ('The Picture of Dorian Gray', 'Penguin Classics', '9780141439570', 272, 'A philosophical novel by Oscar Wilde.', NULL, 'English'),
    ('Wuthering Heights', 'Penguin Classics', '9780141439556', 416, 'A Gothic novel by Emily Bronte.', NULL, 'English'),
    ('The Book Thief', 'Knopf Books for Young Readers', '9780375842207', 584, 'A historical novel by Markus Zusak.', NULL, 'English'),
    ('The Maze Runner', 'Delacorte Press', '9780385737951', 400, 'A young adult dystopian novel by James Dashner.', NULL, 'English'),
    ('The Help', 'Penguin Books', '9780143118233', 544, 'A novel by Kathryn Stockett.', NULL, 'English'),
    ('The Giver', 'HMH Books for Young Readers', '9780544340688', 240, 'A young adult dystopian novel by Lois Lowry.', NULL, 'English'),
    ('The Girl with the Dragon Tattoo', 'Vintage Crime/Black Lizard', '9780307454546', 672, 'A crime thriller novel by Stieg Larsson.', NULL, 'English'),
    ('The Lion, the Witch, and the Wardrobe', 'HarperCollins', '9780064404990', 208, 'A fantasy novel by C.S. Lewis.', NULL, 'English'),
    ('The Secret Life of Bees', 'Penguin Books', '9780142001745', 336, 'A novel by Sue Monk Kidd.', NULL, 'English'),
    ('The Color Purple', 'Mariner Books', '9780156028356', 288, 'A novel by Alice Walker.', NULL, 'English'),
    ('Fahrenheit 451', 'Simon & Schuster', '9781451673319', 249, 'A dystopian novel by Ray Bradbury.', NULL, 'English'),
    ('The Odyssey', 'Penguin Classics', '9780140268867', 560, 'An ancient Greek epic poem attributed to Homer.', NULL, 'English'),
    ('The Catcher in the Rye', 'Little, Brown and Company', '9780316769488', 234, 'A coming-of-age novel by J.D. Salinger.', NULL, 'English'),
    ('One Hundred Years of Solitude', 'Harper Perennial', '9780060883287', 417, 'A novel by Gabriel Garcia Marquez.', NULL, 'English'),
    ('Slaughterhouse-Five', 'Dial Press', '9780385333849', 275, 'A science fiction-infused anti-war novel by Kurt Vonnegut.', NULL, 'English'),
    ('The Count of Monte Cristo', 'Penguin Classics', '9780140449266', 1276, 'An adventure novel by Alexandre Dumas.', NULL, 'English'),
    ('Lord of the Flies', 'Penguin Books', '9780140283334', 224, 'A novel by William Golding.', NULL, 'English'),
    ('LÉtranger', 'Gallimard', '9782070360024', 186, 'Un roman de labsurde écrit par Albert Camus.', NULL, 'French'),
    ('Les Misérables', 'A. Lacroix, Verboeckhoven & Cie', '9780140444308', 1488, 'Un roman épique de Victor Hugo sur la vie des personnages pauvres et marginalisés en France du 19e siècle.', NULL, 'French'),
    ('Le Petit Prince', 'Gallimard', '9782070612758', 96, 'Un conte philosophique de Antoine de Saint-Exupéry.', NULL, 'French'),
    ('Madame Bovary', 'Michel Lévy Frères', '9780199535651', 368, 'Un roman réaliste de Gustave Flaubert sur la vie dEmma Bovary.', NULL, 'French'),
    ('Les Fleurs du Mal', 'Auguste Poulet-Malassis et de Broise', '9780199535651', 324, 'Un recueil de poèmes de Charles Baudelaire.', NULL, 'French'),
    ('Le Comte de Monte-Cristo', 'Pétion', '9781406792194', 464, 'Un roman daventures de Alexandre Dumas sur la vengeance.', NULL, 'French'),
    ('Les Trois Mousquetaires', 'Baudry', '9781406793269', 704, 'Un roman daventures de Alexandre Dumas sur les mousquetaires.', NULL, 'French'),
    ('Germinal', 'Charpentier', '9782253004223', 624, 'Un roman de Émile Zola sur la vie des mineurs en France.', NULL, 'French'),
    ('Candide', 'Cramer', '9780486266893', 144, 'Un conte philosophique de Voltaire.', NULL, 'French'),
    ('Le Rouge et le Noir', 'Levasseur', '9782253010699', 576, 'Un roman psychologique de Stendhal sur lascension sociale.', NULL, 'French'),
    ('Les Liaisons dangereuses', 'Durand', '9780486278957', 400, 'Un roman épistolaire de Pierre Choderlos de Laclos sur les jeux de séduction.', NULL, 'French'),
    ('Le Grand Meaulnes', 'Fasquelle', '9782080703111', 256, 'Un roman dinitiation de Alain-Fournier.', NULL, 'French'),
    ('La Peste', 'Gallimard', '9782070200610', 288, 'Un roman allégorique de Albert Camus sur une épidémie de peste.', NULL, 'French'),
    ('Le Horla', 'Fasquelle', '9782253093838', 112, 'Un recueil de nouvelles fantastiques de Guy de Maupassant.', NULL, 'French'),
    ('Voyage au bout de la nuit', 'Denoël et Steele', '9782070360284', 464, 'Un roman de Louis-Ferdinand Céline sur la condition humaine.', NULL, 'French'),
    ('Bel-Ami', 'Ollendorff', '9782080703968', 432, 'Un roman réaliste de Guy de Maupassant sur lascension sociale.', NULL, 'French'),
    ('La Nausée', 'Gallimard', '9782070368075', 240, 'Un roman existentialiste de Jean-Paul Sartre sur labsurdité de lexistence.', NULL, 'French'),
    ('Les Chants de Maldoror', 'Léon Genonceaux', '9782253004575', 304, 'Un poème en prose de Comte de Lautréamont.', NULL, 'French'),
    ('Les Fourmis', 'Albin Michel', '9782226057940', 352, 'Un roman de science-fiction de Bernard Werber.', NULL, 'French'),
    ('Le Parfum', 'Fayard', '9782253174872', 318, 'Un roman de Patrick Süskind sur un tueur en série obsédé par les odeurs.', NULL, 'French'),
    ('Au Bonheur des Dames', 'Charpentier', '9782253004155', 496, 'Un roman réaliste de Émile Zola sur les grands magasins.', NULL, 'French'),
    ('LAssommoir', 'Charpentier', '9782253004179', 480, 'Un roman réaliste de Émile Zola sur la vie ouvrière à Paris.', NULL, 'French'),
    ('Les Enfants Terribles', 'Gallimard', '9782070360802', 160, 'Un roman de Jean Cocteau sur une relation toxique entre frère et sœur.', NULL, 'French'),
    ('Le Ravissement de Lol V. Stein', 'Gallimard', '9782070368136', 256, 'Un roman de Marguerite Duras sur la passion et la perte.', NULL, 'French'),
    ('Huis clos', 'Gallimard', '9782070368075', 160, 'Une pièce de théâtre de Jean-Paul Sartre sur lenfer des relations humaines.', NULL, 'French'),
    ('Bonjour tristesse', 'Éditions du Seuil', '9782253004117', 192, 'Un roman de Françoise Sagan sur ladolescence et le désir.', NULL, 'French'),
    ('Le Tour du monde en quatre-vingts jours', 'Pierre-Jules Hetzel', '9782253004155', 256, 'Un roman daventures de Jules Verne sur un voyage autour du monde.', NULL, 'French'),
    ('Les Contemplations', 'Charles Gosselin', '9782253010507', 688, 'Un recueil de poèmes de Victor Hugo.', NULL, 'French'),
    ('Les Rêveries du promeneur solitaire', 'Garnier-Flammarion', '9782080711826', 192, 'Une œuvre autobiographique de Jean-Jacques Rousseau.', NULL, 'French'),
    ('Les Paradis artificiels', 'Michel Lévy Frères', '9782253083150', 256, 'Un essai sur lusage des drogues de Charles Baudelaire.', NULL, 'French'),
    ('La Poupée', 'Fasquelle', '9782253011351', 144, 'Un roman de fiction de Pierre Louÿs.', NULL, 'French'),
    ('Ο Αλχημιστής', 'Εκδόσεις Ψυχογιός', '9789604537876', 224, 'Ένα βιβλίο που μιλάει για τα όνειρα και τον εντοπισμό του πραγματικού νοήματος της ζωής.', NULL, 'Greek'),
    ('Το Νησί', 'Εκδόσεις Κέδρος', '9789600425036', 456, 'Ένα μυθιστόρημα του Βίκτορ Πέλεβιν που περιγράφει τη ζωή ενός ανθρώπου σε ένα απομονωμένο νησί.', NULL, 'Greek'),
    ('Ο Λόρδος των Μυγών', 'Εκδόσεις Πατάκη', '9789601612189', 256, 'Ένα αλληγορικό μυθιστόρημα του Ουίλιαμ Γκόλντινγκ για την εξέλιξη της κοινωνίας και τη φύση του ανθρώπου.', NULL, 'Greek'),
    ('Ο Δράκουλας', 'Εκδόσεις Κλειδάριθμος', '9789602090646', 432, 'Ένα γοτθικό μυθιστόρημα του Μπραμ Στόκερ για τον βρικόλακα Δράκουλα.', NULL, 'Greek'),
    ('Η Οδύσσεια', 'Εκδόσεις Εστία', '9789600515900', 544, 'Έπος του Όμηρου που περιγράφει την περιπέτεια του Οδυσσέα κατά τον επιστροφή του από τον Τρωικό πόλεμο.', NULL, 'Greek'),
    ('Ο Ιλιάδα', 'Εκδόσεις Εστία', '9789600515603', 608, 'Έπος του Όμηρου που περιγράφει τον Τρωικό πόλεμο και τις μάχες των αρχαίων ηρώων.', NULL, 'Greek'),
    ('Τα Μεταμορφωμένα Τεστάμενα', 'Εκδόσεις Κάκτος', '9789603824330', 224, 'Μια συλλογή από παραμύθια του Αντώνη Σαμαρά.', NULL, 'Greek'),
    ('Ο Τζούλιους Καίσαρ', 'Εκδόσεις Βιβλιοπωλείον της Εστίας', '9789600514453', 368, 'Ένα βιογραφικό μυθιστόρημα του Ουίλιαμ Σαίξπηρ για τον Ρωμαίο ηγέτη Ιούλιο Καίσαρ.', NULL, 'Greek'),
    ('Τα Παιδιά της Αγάπης', 'Εκδόσεις Ψυχογιός', '9789604533540', 416, 'Ένα μυθιστόρημα της Ελίφ Σαφάκ που εξερευνά την αγάπη και την ταυτότητα στην Τουρκία του 20ού αιώνα.', NULL, 'Greek'),
    ('Ο Μικρός Πρίγκιπας', 'Εκδόσεις Ωκεανίδα', '9789604101087', 96, 'Ένα φιλοσοφικό παραμύθι του Αντουάν ντε Σαιντ-Εξυπερύ.', NULL, 'Greek'),
    ('Το Έγκλημα του Λόρενς Γιαρντίνερ', 'Εκδόσεις Πατάκη', '9789601602821', 208, 'Ένα αστυνομικό μυθιστόρημα του Άγκαθα Κρίστι για μια δολοφονία σε μια πολυτελή έπαυλη.', NULL, 'Greek'),
    ('Η Συμμορία των Μεταναστών', 'Εκδόσεις Κέδρος', '9789600427306', 352, 'Ένα μυθιστόρημα του Βίκτορ Πέλεβιν για μια συμμορία κλεφτών της δεκαετίας του 1920.', NULL, 'Greek'),
    ('Ο Κόκκινος Δράκος', 'Εκδόσεις Πατάκη', '9789601610864', 464, 'Ένα αστυνομικό μυθιστόρημα του Τόμας Χάρις για τον δολοφόνο Σεριάλ Κίλερ.', NULL, 'Greek'),
    ('Το Όνομα του Ανέμου', 'Εκδόσεις Ψυχογιός', '9789604537388', 464, 'Ένα μυθιστόρημα του Πάτρικ Ρόθφους για έναν άνδρα που αναζητά την αλήθεια πίσω από την τραγωδία που έζησε.', NULL, 'Greek'),
    ('Η Αλίκη στη Χώρα των Θαυμάτων', 'Εκδόσεις Σαββάλας', '9789601637823', 208, 'Ένα παραμυθένιο μυθιστόρημα του Λιούις Κάρολ για τις περιπέτειες της Αλίκης σε έναν παράξενο κόσμο.', NULL, 'Greek'),
    ('Το Μεγάλο Τείχος', 'Εκδόσεις Εκάτη', '9789604251962', 432, 'Ένα επιστημονικο-φανταστικό μυθιστόρημα του Τζον Σμίθ για ένα μεγάλο τείχος που προστατεύει την ανθρωπότητα.', NULL, 'Greek'),
    ('Ο Υποβρύχιος Κόσμος', 'Εκδόσεις Ωκεανίδα', '9789604103722', 368, 'Ένα αριστούργημα του Ζιλ Βέρν για την περιπέτεια κάτω από την επιφάνεια των ωκεανών.', NULL, 'Greek'),
    ('Ο Μικρός Πρίγκιπας', 'Εκδόσεις Κέδρος', '9789600423001', 112, 'Ένα φιλοσοφικό παραμύθι του Αντουάν ντε Σαιντ-Εξυπερύ.', NULL, 'Greek'),
    ('Η Επιστροφή του Σερίφη', 'Εκδόσεις Ψυχογιός', '9789604539788', 352, 'Ένα αστυνομικό μυθιστόρημα του Ντέιβιντ Μπαλντάτσι για τον αποφυλακισμένο πρώην σερίφη Τζον Ρέινολντς που αναζητά δικαίωση.', NULL, 'Greek'),
    ('Η Πόλη των Καταραμένων', 'Εκδόσεις Κλειδάριθμος', '9789602090813', 608, 'Ένα φανταστικό μυθιστόρημα της Κέλσεϋ Ντρέικ για μια πόλη όπου οι κάτοικοι είναι καταραμένοι να ζουν κάτω από την θάλασσα.', NULL, 'Greek'),
    ('Το Σώμα της Αθηνάς', 'Εκδόσεις Πατάκη', '9789601611618', 208, 'Ένα ιστορικό μυθιστόρημα της Μάντας Τσικλήρη για μια ομάδα αρχαιολόγων που ανακαλύπτουν ένα μυστήριο αρχαίο θησαυρό.', NULL, 'Greek'),
    ('Ο Εραστής της Λαίδης Τσατλίν', 'Εκδόσεις Ψυχογιός', '9789604541095', 464, 'Ένα ιστορικό μυθιστόρημα της Ρόμπιν Μπέρνς για τη ζωή του Τζόρτζ Τσάρλες Γκόρντον Μπάϊρον, του διάσημου ποιητή του 19ου αιώνα.', NULL, 'Greek'),
    ('Ο Ναυαγός των Παγετώνων', 'Εκδόσεις Κλειδάριθμος', '9789602090721', 352, 'Ένα περιπετειώδες μυθιστόρημα του Τζούλς Βέρν για ένα ναυάγιο σε έναν απομονωμένο παγετώνα.', NULL, 'Greek'),
    ('Ο Μαέστρος και η Μαργαρίτα', 'Εκδόσεις Σαββάλας', '9789601637557', 512, 'Ένα μυθιστόρημα του Μιχαήλ Μπουλγκάκωφ για τον συνάντηση του Ντιάβολου με τον Μαέστρο στη Μόσχα.', NULL, 'Greek'),
    ('Η Καλύβα', 'Εκδόσεις Εστία', '9789600514606', 256, 'Ένα πνευματώδες μυθιστόρημα του Γιάννη Ξενάκη για την ανθρώπινη ψυχή και την αναζήτηση του νοήματος της ζωής.', NULL, 'Greek'),
    ('Οι Αδελφοί Καραμαζόφ', 'Εκδόσεις Κάκτος', '9789603823166', 672, 'Ένα κλασικό μυθιστόρημα του Φιόντορ Ντοστογιέφσκι για τις πολιτικές και ηθικές διλήμματα του Ντμίτρι Καραμαζόφ.', NULL, 'Greek'),
    ('Το Αφεντικό των Μυρμηγκιών', 'Εκδόσεις Πατάκη', '9789601610871', 176, 'Ένα παραμυθένιο μυθιστόρημα του Μαύρου Σεληνοφώτη για την περιπέτεια ενός αγοριού που βρίσκεται στον κόσμο των μυρμηγκιών.', NULL, 'Greek'),
    ('Το Αντίθετο της Αγάπης', 'Εκδόσεις Ψυχογιός', '9789604539832', 352, 'Ένα μυθιστόρημα της Κέλσεϋ Ντρέικ για μια γυναίκα που ανακαλύπτει την αλήθεια για την οικογένειά της μετά το θάνατο της μητέρας της.', NULL, 'Greek'),
    ('Το Βιβλίο των Χαμένων Πραγμάτων', 'Εκδόσεις Κέδρος', '9789600423002', 456, 'Ένα παραμυθένιο μυθιστόρημα της Τζον Κόννολυ για ένα αγόρι που μπαίνει στον μαγικό κόσμο των βιβλίων.', NULL, 'Greek'),
    ('Ο Τελευταίος Μάγος', 'Εκδόσεις Εκάτη', '9789604253171', 384, 'Ένα φανταστικό μυθιστόρημα του Τζον Γκρίσαμ για έναν μάγο που προσπαθεί να σώσει τη μαγεία από την εξαφάνιση.', NULL, 'Greek'),
    ('Η Κόκκινη Πύργος', 'Εκδόσεις Πατάκη', '9789601637113', 336, 'Ένα ιστορικό μυθιστόρημα του Σαντρό Λεμπλάν για την επανάσταση των Μποντουανώ στη Γαλλία του 19ου αιώνα.', NULL, 'Greek'),
    ('Το Στίγμα του Δαίμονα', 'Εκδόσεις Κλειδάριθμος', '9789602090424', 448, 'Ένα φανταστικό μυθιστόρημα του Έρνεστ Κλάιν για έναν νεαρό που ανακαλύπτει ότι έχει εξαιρετικές δυνάμεις και προορίζεται να γίνει μάγος.', NULL, 'Greek'),
    ('Ο Αστερίξ και η Λατραβιάτα', 'Εκδόσεις Εστία', '9789600513364', 48, 'Ένα κλασικό κόμικ των Ρενέ Γκοσινί και Αλμπέρ Ουντερζό για τις περιπέτειες του Αστερίξ και του Οβελίξ στην Ιταλία.', NULL, 'Greek'),
    ('Ο Χαμένος Κόσμος', 'Εκδόσεις Πατάκη', '9789601637045', 352, 'Ένα περιπετειώδες μυθιστόρημα του Άρθουρ Κόναν Ντόιλ για μια εξερεύνηση σε έναν απομακρυσμένο βραζιλιάνικο ποταμό.', NULL, 'Greek'),
    ('Η Πόλη του Ήλιου', 'Εκδόσεις Εκάτη', '9789604253188', 368, 'Ένα επιστημονικο-φανταστικό μυθιστόρημα του Ρέι Μπράντμπερι για μια μυστηριώδη πόλη που ακουλουθεί τον ήλιο σε μια παράλληλη διάσταση.', NULL, 'Greek'),
    ('Η Κάστα', 'Εκδόσεις Κάκτος', '9789603824972', 640, 'Ένα ιστορικό μυθιστόρημα της Μάρτα Στέφανοβα για την εποχή της Ρωσικής Επανάστασης και τη ζωή της αριστοκρατικής οικογένειας Ρομάνοφ.', NULL, 'Greek'),
    ('Ο Πόλεμος των Κόσμων', 'Εκδόσεις Κέδρος', '9789600423170', 240, 'Ένα επιστημονικο-φανταστικό μυθιστόρημα του Χ.Τ. Ουέλς για την εισβολή εξωγήινων πλασμάτων στη Γη.', NULL, 'Greek'),
    ('Οι Περιπέτειες του Τσαρλι και του Σάμπλι', 'Εκδόσεις Ψυχογιός', '9789604540524', 336, 'Ένα παιδικό μυθιστόρημα του Ρόαλντ Ντάλ είναι ένα κόμικ τρυφερής φιλίας μεταξύ ενός αγοριού και ενός κουνελιού.', NULL, 'Greek'),
    ('Ο Στρατηγός των Σκιών', 'Εκδόσεις Κλειδάριθμος', '9789602090462', 544, 'Ένα ιστορικό μυθιστόρημα του Ζήνωνα Σιαλέα για τη ζωή και την πολεμική πορεία του Αλέξανδρου του Μακεδόνα.', NULL, 'Greek'),
    ('Οι Περιπέτειες του Τομ Σώγιερ', 'Εκδόσεις Πατάκη', '9789601638684', 320, 'Ένα κλασικό παιδικό μυθιστόρημα του Μαρκ Τουαίν για τις περιπέτειες του αγοριού Τομ Σώγιερ στον μισητό του θείο.', NULL, 'Greek'),
    ('Ο Πορτραίτο του Ντόριαν Γκρέυ', 'Εκδόσεις Εστία', '9789600514576', 352, 'Ένα φιλοσοφικό μυθιστόρημα του Όσκαρ Ουάιλντ για τον νέο αριστοκράτη Ντόριαν Γκρέυ και την απελευθέρωσή του μέσω της τέχνης και της αισθητικής.', NULL, 'Greek'),
    ('Το Νησί του Θησαυρού', 'Εκδόσεις Εκάτη', '9789604253140', 320, 'Ένα περιπετειώδες μυθιστόρημα του Ρόμπερτ Λούις Στίβενσον για τον νεαρό Τζιμ Χόκινς και την αναζήτησή του για έναν θησαυρό σε ένα απομακρυσμένο νησί.', NULL, 'Greek'),
    ('Η Μυστηριώδης Υπόθεση του Στύξ', 'Εκδόσεις Κλειδάριθμος', '9789602090486', 416, 'Ένα αστυνομικό μυθιστόρημα της Αγκάθα Κρίστι για τον διάσημο ντετέκτιβ Ερκιούλ Πουαρό και την εξιχνίαση μιας μυστηριώδους δολοφονίας σε μια απομονωμένη έπαυλη.', NULL, 'Greek'),
    ('Το Μυστικό της Προδοσίας', 'Εκδόσεις Ψυχογιός', '9789604536381', 480, 'Ένα ιστορικό μυθιστόρημα της Κατρίν Ντελάρι για την εποχή της Γαλλικής Επανάστασης και την αποκάλυψη ενός μυστικού που μπορεί να ανατρέψει την πολιτική κατάσταση.', NULL, 'Greek'),
    ('Οι Περιπέτειες του Χάκλεμπερυ Φιν', 'Εκδόσεις Πατάκη', '9789601638721', 368, 'Ένα κλασικό παιδικό μυθιστόρημα του Μαρκ Τουαίν για τις περιπέτειες του αγοριού Χάκλεμπερυ Φιν κατά τη διάρκεια του ταξιδιού του κατά μήκος του ποταμού Μισισιπή.', NULL, 'Greek'),
    ('Οι Σταχτοπούτες Πεθερές', 'Εκδόσεις Εστία', '9789600513777', 336, 'Ένα μυθιστόρημα της Μάριας Στέφανου για μια ομάδα γυναικών που αναζητούν την ευτυχία και την αυτοπραγμάτωσή τους μετά το γάμο.', NULL, 'Greek'),
    ('Η Περίπτωση του Υποδικαστή Φολς', 'Εκδόσεις Κέδρος', '9789600423125', 416, 'Ένα αστυνομικό μυθιστόρημα του Τζον Γκρίσαμ για τον ντετέκτιβ Άλεξ Κρος και την ανακάλυψη της αλήθειας πίσω από μια περίπλοκη υπόθεση δολοφονίας.', NULL, 'Greek'),
    ('Ο Τύπος της Κυριακής', 'Εκδόσεις Πατάκη', '9789601638240', 336, 'Ένα μυθιστόρημα του Νίκου Αθανασίου για μια δημοσιογράφο που αποκαλύπτει ένα σκάνδαλο στον κυριακάτικο τύπο και βρίσκεται αντιμέτωπη με τις συνέπειές του.', NULL, 'Greek'),
    ('Ο Κύριος Νόρις Αλλάζει Τρένα', 'Εκδόσεις Ψυχογιός', '9789604536992', 272, 'Ένα αστυνομικό μυθιστόρημα του Κρίστοφερ Ισέργουντ για τον ντετέκτιβ Γουίλ Μπάντερ, που προσπαθεί να λύσει μια υπόθεση απαγωγής σε ένα εκκλησάκι της εξοχής.', NULL, 'Greek'),
    ('Η Παράδοση της Αντιγόνης', 'Εκδόσεις Κλειδάριθμος', '9789602090431', 480, 'Ένα ιστορικό μυθιστόρημα του Μανόλη Γλέζου για την αντίσταση και τη ζωή της Αντιγόνης Καλλέργη κατά τη διάρκεια της κατοχής.', NULL, 'Greek'),
    ('Ο Μεγάλος Φιλόσοφος', 'Εκδόσεις Εκάτη', '9789604253034', 288, 'Ένα μυθιστόρημα της Έφης Μιχαηλίδου για τη ζωή και τη φιλοσοφία του Σωκράτη, καθώς αυτές εκτυλίσσονται μέσα από την περιπέτεια ενός νεαρού αγοριού.', NULL, 'Greek'),
    ('Ο Ναυτικός Υπόλοχαγός', 'Εκδόσεις Πατάκη', '9789601638660', 352, 'Ένα ιστορικό μυθιστόρημα του Πάτρικ Ο Μπράιαν για τον ναυτικό υπόλοχαγό Τζακ Ο Μπράιαν και τις περιπέτειές του στα κύματα του Ατλαντικού.', NULL, 'Greek'),
    ('Οι Περιπέτειες του Χάρι Πότερ', 'Εκδόσεις Εστία', '9789600514644', 320, 'Ένα φανταστικό μυθιστόρημα της Τζ.Κ. Ρόουλινγκ για τον μαγικό κόσμο του Χάρι Πότερ και τις περιπέτειές του στο Χόγκουαρτς.', NULL, 'Greek'),
    ('Το Στοίχημα του Δικαστή', 'Εκδόσεις Κέδρος', '9789600423064', 384, 'Ένα αστυνομικό μυθιστόρημα του Μίκαελ Κονέν για τον δικηγόρο Μάικλ Χόλμπεργκ και την αποδοκιμασία ενός φόνου που έχει εμπλακεί μια κομμένη χειρ.', NULL, 'Greek'),
    ('Οι Χορευτές του Μπαλέτου', 'Εκδόσεις Ψυχογιός', '9789604536251', 352, 'Ένα μυθιστόρημα της Βίκυς Μαρκοπούλου για μια ομάδα χορευτών σε ένα θέατρο του μπαλέτου και τις προσπάθειές τους να επιβιώσουν και να εκπληρώσουν τα όνειρά τους.', NULL, 'Greek'),
    ('Ο Ανεκπλήρωτος Έρωτας της Σαρλότ', 'Εκδόσεις Πατάκη', '9789601638646', 384, 'Ένα μυθιστόρημα της Μαρίας Τολούση για μια γυναίκα που αναζητά τον ανεκπλήρωτο έρωτα και την αυτοπραγμάτωσή της μέσα από τις σχέσεις της με τους άντρες στη ζωή της.', NULL, 'Greek'),
    ('Ο Φάντασμα της Όπερας', 'Εκδόσεις Εκάτη', '9789604253492', 320, 'Ένα ρομαντικό μυθιστόρημα του Γκαστόν Λερού για το μυστηριώδες φάντασμα που κατοικεί στην όπερα του Παρισιού και τη σχέση του με μια νεαρή τραγουδίστρια.', NULL, 'Greek'),
    ('Ο Αμερικάνος', 'Εκδόσεις Κλειδάριθμος', '9789602091278', 400, 'Ένα ιστορικό μυθιστόρημα του Μάρτιν Κρους για τον Ρόμπερτ Ντε Λα Ρόσ, έναν Αμερικανό που μετακομίζει στη Γαλλία και εμπλέκεται σε μια επαναστατική οργάνωση.', NULL, 'Greek'),
    ('Οι Αθάνατοι Έρωτες της Αλεξίας', 'Εκδόσεις Πατάκη', '9789601638523', 336, 'Ένα ιστορικό μυθιστόρημα της Αλίκης Μιντ Ραουφ για την Αλεξία, μια νεαρή γυναίκα που αναζητά τον έρωτα και την αυτοπραγμάτωσή της στην Κωνσταντινούπολη του 19ου αιώνα.', NULL, 'Greek'),
    ('Η Εκδίκηση του Μόντε Κρίστο', 'Εκδόσεις Εστία', '9789600511896', 624, 'Ένα ιστορικό μυθιστόρημα του Αλεξάντρ Ντιμά για τον Έντμοντ Νταντές, που επιστρέφει από τον θάνατο για να εκδικηθεί όσους του έκαναν κακό.', NULL, 'Greek'),
    ('Το Απαγορευμένο Βιβλίο', 'Εκδόσεις Πατάκη', '9789601638530', 320, 'Ένα μυθιστόρημα του Ντόναλντ Ρέι για έναν μυστηριώδη συγγραφέα και το απαγορευμένο βιβλίο που αποκαλύπτει μυστικά και σκοτεινές δυνάμεις.', NULL, 'Greek'),
    ('Η Εραστής', 'Εκδόσεις Ψυχογιός', '9789604536985', 432, 'Ένα ιστορικό μυθιστόρημα της Έφης Μιχαηλίδου για τη ζωή της Φραγκοφονικής Αιγύπτου και τη σχέση της με τον ποιητή Κωνσταντίνο Καβάφη.', NULL, 'Greek'),
    ('Η Κόκκινη Πύλη', 'Εκδόσεις Κέδρος', '9789600423071', 400, 'Ένα αστυνομικό μυθιστόρημα του Ίρβιν Γουόλας για μια ομάδα εγκληματιών που σχεδιάζουν μια ληστεία σε ένα αποθηκευτικό χώρο μέσω μιας κόκκινης πύλης.', NULL, 'Greek'),
    ('Ο Πλούτος των Εθνών', 'Εκδόσεις Εκάτη', '9789604253942', 736, 'Ένα οικονομικό βιβλίο του Άνταμ Σμιθ που αναλύει τις οικονομικές αρχές και τις αντιλήψεις για τον πλούτο των εθνών.', NULL, 'Greek'),
    ('Η Άσπρη Καμήλα', 'Εκδόσεις Πατάκη', '9789601638905', 352, 'Ένα μυθιστόρημα της Ειρήνης Καρύδη για μια γυναίκα που επιστρέφει στην πατρίδα της, την Ελλάδα, και αναζητά την αποδοχή και την ευτυχία.', NULL, 'Greek'),
    ('Τα Παιδιά της Λυκανθρώπου', 'Εκδόσεις Εστία', '9789600513371', 352, 'Ένα φανταστικό μυθιστόρημα του Κώστα Χατζησάββα για μια ομάδα παιδιών που ανακαλύπτουν ότι έχουν υβριδικές δυνάμεις λυκανθρώπων και πρέπει να προστατεύσουν τον κόσμο από τον κίνδυνο.', NULL, 'Greek'),
    ('Ο Πόλεμος των Κόσμων', 'Εκδόσεις Πατάκη', '9789601638653', 400, 'Ένα επιστημονικό-φαντασίας μυθιστόρημα του Χ.Γ. Ουέλς για μια εισβολή εξωγήινων στη Γη και την αντίσταση της ανθρωπότητας.', NULL, 'Greek'),
    ('Το Τατουάζ', 'Εκδόσεις Εκάτη', '9789604253416', 272, 'Ένα μυθιστόρημα του Φίλιπ Πολ για μια γυναίκα που αποφασίζει να κάνει ένα τατουάζ στην πλάτη της και την επιρροή που έχει αυτή η επιλογή στη ζωή της.', NULL, 'Greek');



INSERT INTO Category (Category) VALUES
    ('Action and Adventure'),
    ('Art'),
    ('Biography'),
    ('Business and Economics'),
    ('Comics and Graphic Novels'),
    ('Computing and Technology'),
    ('Cookbooks and Food'),
    ('Crafts and Hobbies'),
    ('Crime and Mystery'),
    ('Drama'),
    ('Education and Teaching'),
    ('Fantasy'),
    ('Fiction'),
    ('Health and Wellness'),
    ('Historical Fiction'),
    ('History'),
    ('Horror'),
    ('Humor'),
    ('Inspirational and Motivational'),
    ('LGBTQ+'),
    ('Literary Fiction'),
    ('Music'),
    ('Parenting and Family'),
    ('Philosophy'),
    ('Poetry'),
    ('Politics and Social Sciences'),
    ('Religion and Spirituality'),
    ('Romance'),
    ('Science'),
    ('Science Fiction'),
    ('Self-Help and Personal Development'),
    ('Sports'),
    ('Thriller'),
    ('Travel'),
    ('True Crime'),
    ('Western');



INSERT INTO Book_categories (Book_id, Category_id) VALUES
(1, 1), -- The Alchemist: Action and Adventure
(1, 19), -- The Alchemist: Inspirational and Motivational
(1, 23), -- The Alchemist: Philosophy
(2, 5), -- Pride and Prejudice: Comics and Graphic Novels
(2, 22), -- Pride and Prejudice: Parenting and Family
(2, 30), -- Pride and Prejudice: Travel
(3, 3), -- To Kill a Mockingbird: Biography
(3, 9), -- To Kill a Mockingbird: Crime and Mystery
(3, 16), -- To Kill a Mockingbird: Health and Wellness
(4, 4), -- 1984: Business and Economics
(4, 24), -- 1984: Politics and Social Sciences
(4, 31), -- 1984: True Crime
(5, 2), -- The Great Gatsby: Art
(5, 12), -- The Great Gatsby: Literary Fiction
(5, 21), -- The Great Gatsby: Music
(6, 3), -- Moby Dick: Biography
(6, 4), -- Moby Dick: Business and Economics
(6, 26), -- Moby Dick: Religion and Spirituality
(7, 6), -- The Catcher in the Rye: Computing and Technology
(7, 11), -- The Catcher in the Rye: Fantasy
(7, 18), -- The Catcher in the Rye: Inspirational and Motivational
(8, 2), -- Jane Eyre: Art
(8, 10), -- Jane Eyre: Drama
(8, 22), -- Jane Eyre: Parenting and Family
(9, 4), -- Brave New World: Business and Economics
(9, 14), -- Brave New World: Humor
(9, 28), -- Brave New World: Science Fiction
(10, 11), -- The Lord of the Rings: Fantasy
(10, 12), -- The Lord of the Rings: Literary Fiction
(10, 27), -- The Lord of the Rings: Romance
(11, 11), -- Harry Potter and the Sorcerer's Stone: Fantasy
(11, 12), -- Harry Potter and the Sorcerer's Stone: Literary Fiction
(11, 25), -- Harry Potter and the Sorcerer's Stone: Religion and Spirituality
(12, 11), -- The Hobbit: Fantasy
(12, 23), -- The Hobbit: Philosophy
(12, 30), -- The Hobbit: Travel
(13, 11), -- The Chronicles of Narnia: Fantasy
(13, 12), -- The Chronicles of Narnia: Literary Fiction
(13, 23), -- The Chronicles of Narnia: Philosophy
(14, 12), -- Animal Farm: Literary Fiction
(14, 16), -- Animal Farm: Health and Wellness
(14, 24), -- Animal Farm: Politics and Social Sciences
(15, 7), -- The Da Vinci Code: Cookbooks and Food
(15, 14), -- The Da Vinci Code: Humor
(15, 32), -- The Da Vinci Code: Thriller
(16, 15), -- Gone with the Wind: Historical Fiction
(16, 22), -- Gone with the Wind: Parenting and Family
(16, 27), -- Gone with the Wind: Romance
(17, 4), -- The Hunger Games: Business and Economics
(17, 18), -- The Hunger Games: Inspirational and Motivational
(17, 23), -- The Hunger Games: Philosophy
(18, 18), -- The Fault in Our Stars: Inspirational and Motivational
(18, 21), -- The Fault in Our Stars: Music
(18, 32), -- The Fault in Our Stars: Thriller
(19, 9), -- The Kite Runner: Crime and Mystery
(19, 16), -- The Kite Runner: Health and Wellness
(19, 27), -- The Kite Runner: Romance
(20, 16), -- The Girl on the Train: Health and Wellness
(20, 24), -- The Girl on the Train: Politics and Social Sciences
(20, 32), -- The Girl on the Train: Thriller
(21, 14), -- The Shining: Humor
(21, 17), -- The Shining: Horror
(21, 29), -- The Shining: Romance
(22, 14), -- The Picture of Dorian Gray: Humor
(22, 24), -- The Picture of Dorian Gray: Politics and Social Sciences
(22, 25), -- The Picture of Dorian Gray: Religion and Spirituality
(23, 15), -- Wuthering Heights: Historical Fiction
(23, 18), -- Wuthering Heights: Inspirational and Motivational
(23, 23), -- Wuthering Heights: Philosophy
(24, 13), -- The Book Thief: Fiction
(24, 16), -- The Book Thief: Health and Wellness
(24, 26), -- The Book Thief: Religion and Spirituality
(25, 12), -- The Maze Runner: Literary Fiction
(25, 20), -- The Maze Runner: LGBTQ+
(25, 27), -- The Maze Runner: Romance
(26, 12), -- The Help: Literary Fiction
(26, 22), -- The Help: Parenting and Family
(26, 30), -- The Help: Travel
(27, 1), -- The Giver: Action and Adventure
(27, 9), -- The Giver: Crime and Mystery
(27, 14), -- The Giver: Humor
(28, 2), -- The Girl with the Dragon Tattoo: Art
(28, 9), -- The Girl with the Dragon Tattoo: Crime and Mystery
(28, 29), -- The Girl with the Dragon Tattoo: Romance
(29, 11), -- The Lion, the Witch, and the Wardrobe: Fantasy
(29, 12), -- The Lion, the Witch, and the Wardrobe: Literary Fiction
(29, 23), -- The Lion, the Witch, and the Wardrobe: Philosophy
(30, 12), -- The Secret Life of Bees: Literary Fiction
(30, 22), -- The Secret Life of Bees: Parenting and Family
(30, 26), -- The Secret Life of Bees: Religion and Spirituality
(31, 16), -- The Color Purple: Health and Wellness
(31, 18), -- The Color Purple: Inspirational and Motivational
(31, 23), -- The Color Purple: Philosophy
(32, 31), -- Fahrenheit 451: Self-Help and Personal Development
(32, 32), -- Fahrenheit 451: Thriller
(33, 11), -- The Odyssey: Fantasy
(33, 15), -- The Odyssey: Historical Fiction
(33, 23), -- The Odyssey: Philosophy
(34, 7), -- The Catcher in the Rye: Cookbooks and Food
(34, 9), -- The Catcher in the Rye: Crime and Mystery
(34, 14), -- The Catcher in the Rye: Humor
(35, 25), -- One Hundred Years of Solitude: Religion and Spirituality
(35, 26), -- One Hundred Years of Solitude: Romance
(35, 30), -- One Hundred Years of Solitude: Travel
(36, 15), -- Slaughterhouse-Five: Historical Fiction
(36, 19), -- Slaughterhouse-Five: LGBTQ+
(36, 23), -- Slaughterhouse-Five: Philosophy
(37, 3), -- The Count of Monte Cristo: Biography
(37, 6), -- The Count of Monte Cristo: Computing and Technology
(37, 15), -- The Count of Monte Cristo: Historical Fiction
(38, 10), -- Lord of the Flies: Drama
(38, 11), -- Lord of the Flies: Fantasy
(38, 27), -- Lord of the Flies: Romance
(39, 1), -- L'Étranger: Action and Adventure
(39, 9), -- L'Étranger: Crime and Mystery
(39, 23), -- L'Étranger: Philosophy
(40, 15), -- Les Misérables: Historical Fiction
(40, 18), -- Les Misérables: Inspirational and Motivational
(40, 24), -- Les Misérables: Politics and Social Sciences
(41, 10), -- Le Petit Prince: Drama
(41, 11), -- Le Petit Prince: Fantasy
(41, 16), -- Le Petit Prince: Health and Wellness
(42, 15), -- Madame Bovary: Historical Fiction
(42, 19), -- Madame Bovary: LGBTQ+
(42, 23), -- Madame Bovary: Philosophy
(43, 12), -- Les Fleurs du Mal: Literary Fiction
(43, 14), -- Les Fleurs du Mal: Humor
(43, 27), -- Les Fleurs du Mal: Romance
(44, 3), -- Le Comte de Monte-Cristo: Biography
(44, 6), -- Le Comte de Monte-Cristo: Computing and Technology
(44, 15), -- Le Comte de Monte-Cristo: Historical Fiction
(45, 11), -- Les Trois Mousquetaires: Fantasy
(45, 15), -- Les Trois Mousquetaires: Historical Fiction
(45, 25), -- Les Trois Mousquetaires: Religion and Spirituality
(46, 15), -- Germinal: Historical Fiction
(46, 16), -- Germinal: Health and Wellness
(46, 28), -- Germinal: Science and Nature
(47, 2), -- Candide: Art
(47, 21), -- Candide: Music
(47, 23), -- Candide: Philosophy
(48, 15), -- Le Rouge et le Noir: Historical Fiction
(48, 17), -- Le Rouge et le Noir: Horror
(48, 27), -- Le Rouge et le Noir: Romance
(49, 14), -- Les Liaisons dangereuses: Humor
(49, 20), -- Les Liaisons dangereuses: Literary Criticism
(49, 24), -- Les Liaisons dangereuses: Politics and Social Sciences
(50, 12), -- Le Grand Meaulnes: Literary Fiction
(50, 15), -- Le Grand Meaulnes: Historical Fiction
(50, 28), -- Le Grand Meaulnes: Science and Nature
(51, 15), -- La Peste: Historical Fiction
(51, 23), -- La Peste: Philosophy
(51, 29), -- La Peste: Romance
(52, 17), -- Le Horla: Horror
(52, 18), -- Le Horla: Inspirational and Motivational
(52, 28), -- Le Horla: Science and Nature
(53, 1), -- Voyage au bout de la nuit: Action and Adventure
(53, 15), -- Voyage au bout de la nuit: Historical Fiction
(53, 23), -- Voyage au bout de la nuit: Philosophy
(54, 3), -- Bel-Ami: Biography
(54, 15), -- Bel-Ami: Historical Fiction
(54, 27), -- Bel-Ami: Romance
(55, 23), -- La Nausée: Philosophy
(55, 24), -- La Nausée: Politics and Social Sciences
(55, 28), -- La Nausée: Science and Nature
(56, 12), -- Les Chants de Maldoror: Literary Fiction
(56, 16), -- Les Chants de Maldoror: Health and Wellness
(56, 28), -- Les Chants de Maldoror: Science and Nature
(57, 5), -- Les Fourmis: Biographies and Memoirs
(57, 15), -- Les Fourmis: Historical Fiction
(57, 28), -- Les Fourmis: Science and Nature
(58, 3), -- Le Parfum: Biography
(58, 9), -- Le Parfum: Crime and Mystery
(58, 26), -- Le Parfum: Romance
(59, 15), -- Au Bonheur des Dames: Historical Fiction
(59, 20), -- Au Bonheur des Dames: Literary Criticism
(59, 22), -- Au Bonheur des Dames: Parenting and Family
(60, 15), -- L'Assommoir: Historical Fiction
(60, 16), -- L'Assommoir: Health and Wellness
(60, 22), -- L'Assommoir: Parenting and Family
(61, 15), -- Les Enfants Terribles: Historical Fiction
(61, 19), -- Les Enfants Terribles: LGBTQ+
(61, 23), -- Les Enfants Terribles: Philosophy
(62, 15), -- Le Ravissement de Lol V. Stein: Historical Fiction
(62, 19), -- Le Ravissement de Lol V. Stein: LGBTQ+
(62, 27), -- Le Ravissement de Lol V. Stein: Romance
(63, 10), -- Huis clos: Drama
(63, 15), -- Huis clos: Historical Fiction
(63, 24), -- Huis clos: Politics and Social Sciences
(64, 15), -- Bonjour tristesse: Historical Fiction
(64, 18), -- Bonjour tristesse: Inspirational and Motivational
(64, 27), -- Bonjour tristesse: Romance
(65, 1), -- Le Tour du monde en quatre-vingts jours: Action and Adventure
(65, 11), -- Le Tour du monde en quatre-vingts jours: Fantasy
(65, 28), -- Le Tour du monde en quatre-vingts jours: Science and Nature
(66, 12), -- Les Contemplations: Literary Fiction
(66, 15), -- Les Contemplations: Historical Fiction
(66, 25), -- Les Contemplations: Religion and Spirituality
(67, 12), -- Les Rêveries du promeneur solitaire: Literary Fiction
(67, 23), -- Les Rêveries du promeneur solitaire: Philosophy
(67, 25), -- Les Rêveries du promeneur solitaire: Religion and Spirituality
(68, 14), -- Les Paradis artificiels: Humor
(68, 20), -- Les Paradis artificiels: Literary Criticism
(68, 28), -- Les Paradis artificiels: Science and Nature
(69, 12), -- La Poupée: Literary Fiction
(69, 19), -- La Poupée: LGBTQ+
(69, 27), -- La Poupée: Romance
(70, 1),  -- Ο Αλχημιστής: Action and Adventure
(70, 18), -- Ο Αλχημιστής: Inspirational and Motivational
(70, 24), -- Ο Αλχημιστής: Philosophy
(71, 4),  -- Το Νησί: Business and Economics
(71, 5),  -- Το Νησί: Comics and Graphic Novels
(71, 30), -- Το Νησί: Travel
(72, 3),  -- Ο Λόρδος των Μυγών: Biography
(72, 9),  -- Ο Λόρδος των Μυγών: Crime and Mystery
(72, 12), -- Ο Λόρδος των Μυγών: Fantasy
(73, 9),  -- Ο Δράκουλας: Crime and Mystery
(73, 18), -- Ο Δράκουλας: Inspirational and Motivational
(73, 25), -- Ο Δράκουλας: Religion and Spirituality
(74, 11), -- Η Οδύσσεια: Education and Teaching
(74, 16), -- Η Οδύσσεια: History
(74, 29), -- Η Οδύσσεια: Science Fiction
(75, 11), -- Ο Ιλιάδα: Education and Teaching
(75, 16), -- Ο Ιλιάδα: History
(75, 28), -- Ο Ιλιάδα: Science
(76, 2),  -- Τα Μεταμορφωμένα Τεστάμενα: Art
(76, 13), -- Τα Μεταμορφωμένα Τεστάμενα: Health and Wellness
(76, 25), -- Τα Μεταμορφωμένα Τεστάμενα: Religion and Spirituality
(77, 3),  -- Ο Τζούλιους Καίσαρ: Biography
(77, 13), -- Ο Τζούλιους Καίσαρ: Health and Wellness
(77, 26), -- Ο Τζούλιους Καίσαρ: Romance
(78, 1),  -- Τα Παιδιά της Αγάπης: Action and Adventure
(78, 14), -- Τα Παιδιά της Αγάπης: LGBTQ+
(78, 23), -- Τα Παιδιά της Αγάπης: Philosophy
(79, 10), -- Ο Μικρός Πρίγκιπας: Drama
(79, 15), -- Ο Μικρός Πρίγκιπας: Literary Fiction
(79, 27), -- Ο Μικρός Πρίγκιπας: Self-Help and Personal Development
(80, 9),  -- Το Έγκλημα του Λόρενς Γιαρντίνερ: Crime and Mystery
(80, 16), -- Το Έγκλημα του Λόρενς Γιαρντίνερ: History
(80, 31), -- Το Έγκλημα του Λόρενς Γιαρντίνερ: True Crime
(81, 5),  -- Η Συμμορία των Μεταναστών: Comics and Graphic Novels
(81, 12), -- Η Συμμορία των Μεταναστών: Fantasy
(81, 17), -- Η Συμμορία των Μεταναστών: Horror
(82, 9),  -- Ο Κόκκινος Δράκος: Crime and Mystery
(82, 19), -- Ο Κόκκινος Δράκος: Inspirational and Motivational
(82, 25); -- Ο Κόκκινος Δράκος: Religion and Spirituality



DELIMITER //
FOR i IN 1..3
DO
    INSERT INTO Book_Copies (Book_id, School_id, Copies)
    VALUES
        (i, 1, FLOOR(RAND() * 3)),
        (i, 2, FLOOR(RAND() * 3)),
        (i, 3, FLOOR(RAND() * 3)),
        (i, 4, FLOOR(RAND() * 3));
END FOR;
//
DELIMITER ;