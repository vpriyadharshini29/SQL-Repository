CREATE DATABASE airline_db;
USE airline_db;

CREATE TABLE airports (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  code VARCHAR(10)
);

CREATE TABLE flights (
  id INT PRIMARY KEY AUTO_INCREMENT,
  flight_number VARCHAR(10),
  origin_id INT,
  destination_id INT,
  FOREIGN KEY (origin_id) REFERENCES airports(id),
  FOREIGN KEY (destination_id) REFERENCES airports(id)
);

CREATE TABLE passengers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100)
);

CREATE TABLE bookings (
  id INT PRIMARY KEY AUTO_INCREMENT,
  passenger_id INT,
  flight_id INT,
  FOREIGN KEY (passenger_id) REFERENCES passengers(id),
  FOREIGN KEY (flight_id) REFERENCES flights(id)
);

-- Sample data
INSERT INTO airports (name, code) VALUES ('New York', 'JFK'), ('Los Angeles', 'LAX'), ('Chicago', 'ORD');

INSERT INTO flights (flight_number, origin_id, destination_id) VALUES
('AA101', 1, 2), ('UA202', 2, 3), ('DL303', 3, 1), ('BA404', 1, 3), ('AF505', 2, 1);

INSERT INTO passengers (name) VALUES ('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eve'), ('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Judy');

INSERT INTO bookings (passenger_id, flight_id) VALUES
(1, 1), (2, 1), (3, 2), (4, 2), (5, 3), (6, 4), (7, 4), (8, 5), (9, 5), (10, 5);

-- Queries
SELECT * FROM flights WHERE origin_id = 1 AND destination_id = 3;
SELECT passenger_id FROM bookings WHERE flight_id = 5;
