CREATE DATABASE event_portal;
USE event_portal;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    event_date DATE
);

CREATE TABLE registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

-- Sample Queries
-- Show number of registrations per event
SELECT event_id, COUNT(*) AS registrations
FROM registrations
GROUP BY event_id;

-- List upcoming events
SELECT * FROM events
WHERE event_date > CURDATE();
