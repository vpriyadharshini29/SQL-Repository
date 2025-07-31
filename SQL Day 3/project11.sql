-- Top-selling authors
SELECT a.author_name, SUM(s.quantity) AS total_sales
FROM authors a
INNER JOIN books b ON a.author_id = b.author_id
INNER JOIN sales s ON b.book_id = s.book_id
GROUP BY a.author_name
ORDER BY total_sales DESC;

-- Books with rating > 4.5 and sold > 100 times
SELECT b.title, b.rating, SUM(s.quantity) AS total_sold
FROM books b
INNER JOIN sales s ON b.book_id = s.book_id
GROUP BY b.title, b.rating
HAVING b.rating > 4.5 AND SUM(s.quantity) > 100;

-- Customers with > 5 purchases
SELECT c.first_name, COUNT(s.sale_id) AS purchase_count
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.first_name
HAVING COUNT(s.sale_id) > 5;

-- INNER JOIN books, sales, customers
SELECT b.title, c.first_name, s.sale_date
FROM books b
INNER JOIN sales s ON b.book_id = s.book_id
INNER JOIN customers c ON s.customer_id = c.customer_id;

-- FULL OUTER JOIN authors and books
SELECT a.author_name, b.title
FROM authors a
FULL OUTER JOIN books b ON a.author_id = b.author_id;

-- SELF JOIN books with same genre
SELECT b1.title AS book1, b2.title AS book2, b1.genre
FROM books b1
INNER JOIN books b2 ON b1.genre = b2.genre AND b1.book_id < b2.book_id;