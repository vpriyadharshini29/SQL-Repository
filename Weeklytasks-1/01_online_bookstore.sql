-- Online Bookstore Inventory & Sales Analysis

-- 1. Tables
CREATE TABLE authors (author_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE books (book_id INT PRIMARY KEY, title VARCHAR(100), genre VARCHAR(50), author_id INT, price DECIMAL(10,2), FOREIGN KEY (author_id) REFERENCES authors(author_id));
CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE orders (order_id INT PRIMARY KEY, book_id INT, customer_id INT, order_date DATE, quantity INT, FOREIGN KEY (book_id) REFERENCES books(book_id), FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

-- 2. Select books, filter by genre
SELECT * FROM books WHERE genre = 'Fiction';

-- 3. Join books with authors and sales
SELECT b.title, a.name, o.quantity FROM books b JOIN authors a ON b.author_id = a.author_id JOIN orders o ON b.book_id = o.book_id;

-- 4. Total and average sales per author
SELECT a.name, SUM(o.quantity) AS total_sales, AVG(o.quantity) AS avg_sales
FROM authors a JOIN books b ON a.author_id = b.author_id JOIN orders o ON b.book_id = o.book_id
GROUP BY a.name;

-- 5. Filter duplicate books
SELECT DISTINCT title FROM books;

-- 6. Orders between dates
SELECT * FROM orders WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31';

-- 7. Books never sold
SELECT title FROM books WHERE book_id NOT IN (SELECT book_id FROM orders);

-- 8. CASE WHEN to classify sales performance
SELECT b.title, SUM(o.quantity) AS total_sold,
CASE
  WHEN SUM(o.quantity) >= 100 THEN 'High'
  WHEN SUM(o.quantity) >= 50 THEN 'Medium'
  ELSE 'Low'
END AS performance
FROM books b JOIN orders o ON b.book_id = o.book_id
GROUP BY b.title;

-- 9. Sort books by revenue and author
SELECT b.title, a.name, SUM(o.quantity * b.price) AS revenue
FROM books b JOIN authors a ON b.author_id = a.author_id JOIN orders o ON b.book_id = o.book_id
GROUP BY b.title, a.name
ORDER BY revenue DESC, a.name;

-- 10. UNION of physical and eBook sales
SELECT book_id, customer_id, order_date FROM orders WHERE book_id IN (SELECT book_id FROM books WHERE genre != 'eBook')
UNION
SELECT book_id, customer_id, order_date FROM orders WHERE book_id IN (SELECT book_id FROM books WHERE genre = 'eBook');