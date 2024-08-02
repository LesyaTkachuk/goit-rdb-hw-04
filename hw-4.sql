-- create database and tables 
CREATE SCHEMA LibraryManagement;

USE LibraryManagement;

DROP SCHEMA LibraryManagement;

CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT, 
    author_name VARCHAR(255)
    );

CREATE TABLE genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT, 
    genre_name VARCHAR(255)
    );

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(255), 
    publication_year YEAR, 
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
    );
    
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT, 
    username VARCHAR(255), 
    email VARCHAR(255)
    );
    
CREATE TABLE borrowed_books (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    borrow_date DATE,
    return_date DATE
    );

--  insert fake data into tables   
INSERT INTO authors (author_id, author_name) VALUES (1, "George Orwell");

INSERT INTO authors (author_id, author_name) VALUES (2, "Fyodor Dostoevsky");

INSERT INTO authors (author_id, author_name) VALUES (3, "Erich Maria Remarque");

-- SELECT * FROM authors;

INSERT INTO genres (genre_id, genre_name) VALUES (1, "Political satire");

INSERT INTO genres (genre_id, genre_name) VALUES (2, "Science fiction");

INSERT INTO genres (genre_id, genre_name) VALUES (3, "Literary fiction");

INSERT INTO genres (genre_id, genre_name) VALUES (4, "Philosophical novel");

INSERT INTO genres (genre_id, genre_name) VALUES (5, "War novel");

-- SELECT * FROM genres;

INSERT INTO books (book_id, title, publication_year, author_id, genre_id) VALUES (1, "Animal Farm", "1945", 1, 1);

INSERT INTO books (book_id, title, publication_year, author_id, genre_id) VALUES (2, "Nineteen Eighty-Four", "1949", 1, 2);

INSERT INTO books (book_id, title, publication_year, author_id, genre_id) VALUES (3, "Arch of Triumph", "1945", 3, 5);

INSERT INTO books (book_id, title, publication_year, author_id, genre_id) VALUES (4, "Three Comrades", "1937", 3, 5);

INSERT INTO books (book_id, title, publication_year, author_id, genre_id) VALUES (5, "The Idiot", "1969", 2, 4);

INSERT INTO books (book_id, title, publication_year, author_id, genre_id) VALUES (6, "Demons", "1972", 2, 4);

-- SELECT * FROM books;

INSERT INTO users (user_id, username, email) VALUES (1, "Lesya Tkachuk", "qwerty@gmail.com");

INSERT INTO users (user_id, username, email) VALUES (2, "John Donovan", "qwerty123@gmail.com");

-- SELECT * FROM users;

INSERT INTO borrowed_books (borrow_id, book_id, user_id, borrow_date, return_date) VALUES (1,6,2, "2023-09-09","2023-10-09");

INSERT INTO borrowed_books (borrow_id, book_id, user_id, borrow_date, return_date) VALUES (2,1,1, "2024-07-09",NULL);

-- SELECT * FROM borrowed_books;

-- join all tables from module 3
USE mydb;

SELECT * FROM orders o
INNER JOIN order_details od ON o.id=od.order_id
INNER JOIN customers c ON c.id=o.customer_id
INNER JOIN employees e ON e.employee_id=o.employee_id
INNER JOIN shippers s ON s.id=o.shipper_id
INNER JOIN products p ON p.id=od.product_id
INNER JOIN categories cat ON cat.id=p.category_id
INNER JOIN suppliers sp ON p.supplier_id=sp.id;

-- write queries
-- count rows 
SELECT COUNT(*) as inner_join_count FROM orders o
INNER JOIN order_details od ON o.id=od.order_id
INNER JOIN customers c ON c.id=o.customer_id
INNER JOIN employees e ON e.employee_id=o.employee_id
INNER JOIN shippers s ON s.id=o.shipper_id
INNER JOIN products p ON p.id=od.product_id
INNER JOIN categories cat ON cat.id=p.category_id
INNER JOIN suppliers sp ON p.supplier_id=sp.id;

-- count LEFT JOIN rows 
SELECT COUNT(*) as left_join_count FROM orders o
LEFT JOIN order_details od ON o.id=od.order_id
LEFT JOIN customers c ON c.id=o.customer_id
LEFT JOIN employees e ON e.employee_id=o.employee_id
LEFT JOIN shippers s ON s.id=o.shipper_id
LEFT JOIN products p ON p.id=od.product_id
LEFT JOIN categories cat ON cat.id=p.category_id
LEFT JOIN suppliers sp ON p.supplier_id=sp.id;

-- count RIGHT JOIN rows 
SELECT COUNT(*) as right_join_count FROM orders o
RIGHT JOIN order_details od ON o.id=od.order_id
RIGHT JOIN customers c ON c.id=o.customer_id
RIGHT JOIN employees e ON e.employee_id=o.employee_id
RIGHT JOIN shippers s ON s.id=o.shipper_id
RIGHT JOIN products p ON p.id=od.product_id
RIGHT JOIN categories cat ON cat.id=p.category_id
RIGHT JOIN suppliers sp ON p.supplier_id=sp.id;

-- we see that there is no difference between inner, left and right join of the tables orders, order_details, products,
-- categories, customers, shippers, employees, suppliers. We have the same number of rows equals to 518 because we have no missed or empty data.
-- For this reason we have the same correspondence of rows for each type of join.

-- select rows where employee_id is greater than 3 and less or equal than 10
SELECT * FROM orders o
INNER JOIN order_details od ON o.id=od.order_id
INNER JOIN customers c ON c.id=o.customer_id
INNER JOIN employees e ON e.employee_id=o.employee_id
INNER JOIN shippers s ON s.id=o.shipper_id
INNER JOIN products p ON p.id=od.product_id
INNER JOIN categories cat ON cat.id=p.category_id
INNER JOIN suppliers sp ON p.supplier_id=sp.id
WHERE o.employee_id>3 AND o.employee_id<=10; 

-- group by category name
SELECT cat.name as category_name, COUNT(*) as rows_count, AVG(od.quantity) as avg_prod_quantity FROM orders o
INNER JOIN order_details od ON o.id=od.order_id
INNER JOIN customers c ON c.id=o.customer_id
INNER JOIN employees e ON e.employee_id=o.employee_id
INNER JOIN shippers s ON s.id=o.shipper_id
INNER JOIN products p ON p.id=od.product_id
INNER JOIN categories cat ON cat.id=p.category_id
INNER JOIN suppliers sp ON p.supplier_id=sp.id
GROUP BY cat.name;

-- group by category name where average product quantity is greater than 21
SELECT cat.name as category_name, COUNT(*) as rows_count, AVG(od.quantity) as avg_prod_quantity FROM orders o
INNER JOIN order_details od ON o.id=od.order_id
INNER JOIN customers c ON c.id=o.customer_id
INNER JOIN employees e ON e.employee_id=o.employee_id
INNER JOIN shippers s ON s.id=o.shipper_id
INNER JOIN products p ON p.id=od.product_id
INNER JOIN categories cat ON cat.id=p.category_id
INNER JOIN suppliers sp ON p.supplier_id=sp.id
GROUP BY cat.name
HAVING avg_prod_quantity > 21;

-- group by category name and sort by rows count descending order
SELECT cat.name as category_name, COUNT(*) as rows_count, AVG(od.quantity) as avg_prod_quantity FROM orders o
INNER JOIN order_details od ON o.id=od.order_id
INNER JOIN customers c ON c.id=o.customer_id
INNER JOIN employees e ON e.employee_id=o.employee_id
INNER JOIN shippers s ON s.id=o.shipper_id
INNER JOIN products p ON p.id=od.product_id
INNER JOIN categories cat ON cat.id=p.category_id
INNER JOIN suppliers sp ON p.supplier_id=sp.id
GROUP BY cat.name
HAVING avg_prod_quantity > 21
ORDER BY rows_count DESC;

-- group by category name and get 4 rows except the first one
SELECT cat.name as category_name, COUNT(*) as rows_count, AVG(od.quantity) as avg_prod_quantity FROM orders o
INNER JOIN order_details od ON o.id=od.order_id
INNER JOIN customers c ON c.id=o.customer_id
INNER JOIN employees e ON e.employee_id=o.employee_id
INNER JOIN shippers s ON s.id=o.shipper_id
INNER JOIN products p ON p.id=od.product_id
INNER JOIN categories cat ON cat.id=p.category_id
INNER JOIN suppliers sp ON p.supplier_id=sp.id
GROUP BY cat.name
HAVING avg_prod_quantity > 21
ORDER BY rows_count DESC
LIMIT 4
OFFSET 1;
