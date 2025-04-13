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


--Table:customer

CREATE TABLE customer (
    Customer_id INT NOT NULL AUTO_INCREMENT,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone_number VARCHAR(20),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY (customer_id)
);
-- Table: address
CREATE TABLE address (
    Address_id INT NOT NULL AUTO_INCREMENT,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Country_id INT(11) NOT NULL,
    PRIMARY KEY (address_id),
    FOREIGN KEY (country_id) REFERENCES country(Country_id)
);

-- Table: country
CREATE TABLE country (
    country_id INT NOT NULL AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL,
    PRIMARY KEY (country_id)
);

-- Table: customer_address
-- This table is used to store the relationship between customers and their addresses
-- It includes a foreign key reference to the customer and address tables
CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
     FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

ALTER TABLE customer_address
 ADD address_status INT(1) NOT NULL DEFAULT 1, -- 1 means active
 ADD is_primary INT(1) NOT NULL DEFAULT 0; -- means not primary

-- Table: address_status
-- This table is used to store the status of the address (active, inactive, etc.)
CREATE TABLE address_status (
    status_id INT  NOT NULL,
    status_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (status_id)
);

INSERT INTO country (country_name, country_code) VALUES
('Kenya', 'Ke'),
('Uganda', 'Ug'),
('South Africa', 'SA'),
('Tanzania', 'Tz');

INSERT INTO customer (first_name, last_name, email, phone_number) VALUES
('Dennis', 'Mwangi', 'dennismwangi@gmail.com', '+254 734598430'),
('Brian', 'johns', 'brianjohns@gmail.com', '+256 75 123 4567'),
('Alice', 'Macheredze', 'alicemacheredze@gmail.com', '+27 82 123 4567'),
('Fridah', 'Salama', 'fridahsalama@gmail.com', '+255 75 123 4567');

INSERT INTO address (street, city, country_id) VALUES
('Moi avenue', 'Nairobi',  1),
('kampala road', 'Kampala',  2),
('commissioner street', 'Johannesburg',  3),
('kikuyu avenue', 'Dodoma', 'Tanzania', 4);

INSERT INTO customer_address (customer_id, address_id, address_status, is_primary) VALUES
(1, 1, 1, 1), -- dennis mwangi with address 1, active and primary
(2, 2, 1, 1), -- brian johns with address 2, active and primary
(3, 3, 0, 1), -- Alice macheredze with address 3, inactive but primary
(4, 4, 1, 1); -- fridah salama with address 4, active and primary
 
INSERT INTO address_status (status_id, status_name) VALUES (1, 'Active');
INSERT INTO address_status (status_id, status_name) VALUES (2, 'Inactive');
INSERT INTO address_status (status_id, status_name) VALUES (3, 'Primary');
INSERT INTO address_status (status_id, status_name) VALUES (4, 'Billing');
INSERT INTO address_status (status_id, status_name) VALUES (5, 'Shipping');
 
-- Table:cust_order
-- This table stores customer orders.
--   Each order has a customer, shipping method, and status.
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
-- table: order_line
 -- This table represents the details of each item in a customer order.
-- Each row corresponds to one book in an order, including its quantity.

CREATE TABLE order_line (
    order_id INT,                      -- Foreign key referencing the order
    book_id INT,                       -- Foreign key referencing the book
    quantity INT,                      -- Quantity of the book ordered

    PRIMARY KEY (order_id, book_id),   -- Composite primary key to ensure uniqueness per order and book
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Table: shipping_method
-- This table stores the available shipping methods that can be selected for an order.
-- Each method has a unique ID and a descriptive name.

CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique identifier for each shipping method
    method_name VARCHAR(100)                   -- Name of the shipping method (e.g., Standard, Express)
);

-- Table: order_history
-- This table keeps a log of all status changes for customer orders.
-- It allows tracking the progress of an order over time (e.g., from 'Processing' to 'Shipped').

CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each history record
    order_id INT,                               -- The ID of the order whose status changed
    status_id INT,                              -- The new status ID assigned to the order
    changed_on DATETIME,                        -- Timestamp when the status change occurred

    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),        -- Links to the relevant order
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)     -- Links to the new status
);

-- TABLE order_status
-- This table defines all possible statuses an order can have.
-- Examples of statuses: 'Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'.

CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each order status
    status_name VARCHAR(50)                    -- Descriptive name of the status
);

