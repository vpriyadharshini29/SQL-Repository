-- Table
CREATE TABLE movies (
  movie_id INT,
  title VARCHAR(100),
  genre VARCHAR(50),
  price DECIMAL(10,2),
  rating DECIMAL(3,1),
  available BOOLEAN
);

-- Queries
SELECT title, genre, rating FROM movies WHERE available = TRUE AND genre IN ('Action', 'Thriller');
SELECT * FROM movies WHERE title LIKE '%Star%';
SELECT * FROM movies WHERE rating IS NULL;
SELECT DISTINCT genre FROM movies;
SELECT * FROM movies ORDER BY rating DESC, price ASC;
