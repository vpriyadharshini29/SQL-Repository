-- Movie Rental Store Management

-- 1. Tables
CREATE TABLE genres (genre_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE movies (movie_id INT PRIMARY KEY, title VARCHAR(100), genre_id INT, FOREIGN KEY (genre_id) REFERENCES genres(genre_id));
CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE rentals (rental_id INT PRIMARY KEY, movie_id INT, customer_id INT, rent_date DATE, return_date DATE, FOREIGN KEY (movie_id) REFERENCES movies(movie_id), FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

-- 2. Top 3 rented movies per genre
SELECT * FROM (
  SELECT m.title, g.name AS genre, COUNT(*) AS rent_count,
         RANK() OVER (PARTITION BY g.name ORDER BY COUNT(*) DESC) AS rank
  FROM rentals r JOIN movies m ON r.movie_id = m.movie_id JOIN genres g ON m.genre_id = g.genre_id
  GROUP BY m.title, g.name
) ranked_movies WHERE rank <= 3;

-- 3. LIKE for partial title
SELECT * FROM movies WHERE title LIKE '%Matrix%';

-- 4. Revenue per genre
SELECT g.name, SUM(10) AS revenue FROM rentals r JOIN movies m ON r.movie_id = m.movie_id JOIN genres g ON m.genre_id = g.genre_id GROUP BY g.name;

-- 5. Unreturned movies
SELECT * FROM rentals WHERE return_date IS NULL;

-- 6. CASE for late returns
SELECT rental_id, rent_date, return_date,
CASE
  WHEN return_date > rent_date + INTERVAL '7 days' THEN 'Late'
  ELSE 'On time'
END AS return_status FROM rentals;

-- 7. Combine rental and purchase (assume purchases table)
SELECT customer_id, movie_id, rent_date AS date, 'Rental' AS type FROM rentals
UNION ALL
SELECT customer_id, movie_id, purchase_date AS date, 'Purchase' AS type FROM purchases;

-- 8. JOIN to fetch full customer + rental info
SELECT c.name, m.title, r.rent_date FROM rentals r JOIN customers c ON r.customer_id = c.customer_id JOIN movies m ON r.movie_id = m.movie_id;