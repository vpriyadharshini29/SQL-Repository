CREATE DATABASE hotel_db;
USE hotel_db;

CREATE TABLE guests (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100)
);

CREATE TABLE rooms (
  id INT PRIMARY KEY AUTO_INCREMENT,
  room_type VARCHAR(100),
  price_per_night DECIMAL(10,2)
);

CREATE TABLE services (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  price DECIMAL(10,2)
);

CREATE TABLE bookings (
  id INT PRIMARY KEY AUTO_INCREMENT,
  guest_id INT,
  room_id INT,
  checkin DATE,
  checkout DATE,
  FOREIGN KEY (guest_id) REFERENCES guests(id),
  FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE guest_services (
  guest_id INT,
  service_id INT,
  FOREIGN KEY (guest_id) REFERENCES guests(id),
  FOREIGN KEY (service_id) REFERENCES services(id)
);

-- Sample data
INSERT INTO guests (name) VALUES ('John'), ('Jane');
INSERT INTO rooms (room_type, price_per_night) VALUES ('Single', 100), ('Double', 150);
INSERT INTO services (name, price) VALUES ('Spa', 50), ('Breakfast', 20);

INSERT INTO bookings (guest_id, room_id, checkin, checkout) VALUES (1, 1, '2025-07-29', '2025-08-01');

INSERT INTO guest_services (guest_id, service_id) VALUES (1, 1), (1, 2);

-- Queries
SELECT id, DATEDIFF(checkout, checkin) AS duration_days FROM bookings;
SELECT guest_id, SUM(price) AS total_service_cost FROM guest_services
JOIN services ON guest_services.service_id = services.id GROUP BY guest_id;
