-- Movie Ticket Booking Analytics

CREATE TABLE movies (movie_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE bookings (booking_id INT PRIMARY KEY, movie_id INT, customer_id INT, booking_time TIME);
CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE theatres (theatre_id INT PRIMARY KEY, name VARCHAR(100));

-- Subquery: movies with bookings above average
SELECT * FROM movies m WHERE EXISTS (
  SELECT 1 FROM bookings b WHERE b.movie_id = m.movie_id GROUP BY b.movie_id
  HAVING COUNT(*) > (SELECT AVG(cnt) FROM (SELECT COUNT(*) AS cnt FROM bookings GROUP BY movie_id) t)
);

-- JOIN
SELECT b.*, m.name AS movie, c.name AS customer FROM bookings b
JOIN movies m ON b.movie_id = m.movie_id
JOIN customers c ON b.customer_id = c.customer_id;

-- CASE: booking time classification
SELECT booking_time,
CASE
  WHEN HOUR(booking_time) < 12 THEN 'Morning'
  WHEN HOUR(booking_time) < 17 THEN 'Afternoon'
  ELSE 'Evening'
END AS session FROM bookings;

-- INTERSECT: customers who watched Avengers and Batman
SELECT customer_id FROM bookings WHERE movie_id = (SELECT movie_id FROM movies WHERE name = 'Avengers')
INTERSECT
SELECT customer_id FROM bookings WHERE movie_id = (SELECT movie_id FROM movies WHERE name = 'Batman');

-- UNION ALL: weekday + weekend sales
SELECT * FROM bookings WHERE DAYOFWEEK(booking_time) IN (1,7)
UNION ALL
SELECT * FROM bookings WHERE DAYOFWEEK(booking_time) BETWEEN 2 AND 6;

-- Correlated subquery: most bookings in each theatre
SELECT * FROM customers c WHERE customer_id IN (
  SELECT customer_id FROM bookings b WHERE theatre_id = (SELECT theatre_id FROM theatres WHERE theatres.name = 'Main Hall')
  GROUP BY customer_id ORDER BY COUNT(*) DESC LIMIT 1
);