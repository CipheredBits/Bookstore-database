-- Create the database
CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;

-- Table: Book_Language
CREATE TABLE Book_Language (
    language_id INT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

INSERT INTO Book_Language (language_id, language_name) VALUES
(1, 'English'),
(2, 'French'),
(3, 'Swahili'),
(4, 'Arabic'),
(5, 'German');

-- Table: Publisher
CREATE TABLE Publisher (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL
);

INSERT INTO Publisher (publisher_id, publisher_name) VALUES
(1, 'Penguin Random House'),
(2, 'HarperCollins'),
(3, 'Oxford University Press'),
(4, 'Macmillan Publishers'),
(5, 'East African Educational Publishers');


-- Table: Author
CREATE TABLE Author (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

INSERT INTO Author (author_id, author_name) VALUES
(1, 'Chinua Achebe'),
(2, 'Ngugi wa Thiongo'),
(3, 'J.K. Rowling'),
(4, 'George Orwell'),
(5, 'Tahar Ben Jelloun'),
(6, 'Wole Soyinka');


-- Table: Book
CREATE TABLE Book (
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    publisher_id INT,
    language_id INT,
    FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES Book_Language(language_id)
);

INSERT INTO Book (book_id, title, publisher_id, language_id) VALUES
(101, 'Things Fall Apart', 1, 1),
(102, 'Wizard of the Crow', 5, 1),
(103, 'Harry Potter and the Sorcerers Stone', 1, 1),
(104, '1984', 2, 1),
(105, 'The Hunger of the Human', 4, 2),
(106, 'The Trial of Dedan Kimathi', 5, 3),
(107, 'A Man of the People', 1, 1),
(108, 'Death and the King’s Horseman', 3, 1),
(109, 'La Nuit Sacrée', 2, 2);
  
  
-- Table: Book_Author
CREATE TABLE Book_Author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);
  
INSERT INTO Book_Author (book_id, author_id) VALUES
(101, 1),
(102, 2),
(103, 3),
(104, 4),
(105, 5),
(106, 2),
(107, 1),
(108, 6),
(109, 5);



