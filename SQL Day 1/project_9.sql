CREATE DATABASE cinema_db;
USE cinema_db;

CREATE TABLE movies (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100)
);

CREATE TABLE screens (
  id INT PRIMARY KEY AUTO_INCREMENT,
  screen_number INT
);

CREATE TABLE customers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100)
);

CREATE TABLE bookings (
  id INT PRIMARY KEY AUTO_INCREMENT,
  movie_id INT,
  customer_id INT,
  screen_id INT,
  showtime DATETIME,
  seat_number VARCHAR(10),
  FOREIGN KEY (movie_id) REFERENCES movies(id),
  FOREIGN KEY (customer_id) REFERENCES customers(id),
  FOREIGN KEY (screen_id) REFERENCES screens(id)
);

-- Sample data
INSERT INTO movies (title) VALUES ('Movie A'), ('Movie B'), ('Movie C'), ('Movie D'), ('Movie E');
INSERT INTO screens (screen_number) VALUES (1), (2), (3);
INSERT INTO customers (name) VALUES ('C1'), ('C2'), ('C3'), ('C4'), ('C5'), ('C6'), ('C7'), ('C8');

-- Bookings
INSERT INTO bookings (movie_id, customer_id, screen_id, showtime, seat_number) VALUES
(1, 1, 1, '2025-07-30 18:00:00', 'A1'),
(1, 2, 1, '2025-07-30 18:00:00', 'A2'),
(2, 3, 2, '2025-07-30 20:00:00', 'B1'),
(3, 4, 3, '2025-07-30 22:00:00', 'C1'),
(1, 5, 1, '2025-07-30 18:00:00', 'A3');

-- Queries
SELECT showtime, seat_number FROM bookings WHERE movie_id = 1;
SELECT movie_id, COUNT(*) FROM bookings GROUP BY movie_id ORDER BY COUNT(*) DESC LIMIT 3;
