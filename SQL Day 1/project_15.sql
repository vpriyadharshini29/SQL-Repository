CREATE DATABASE rental_db;
USE rental_db;

CREATE TABLE vehicle_types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50)
);

CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(100),
    type_id INT,
    rate DECIMAL(8,2),
    FOREIGN KEY (type_id) REFERENCES vehicle_types(type_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE rentals (
    rental_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT,
    customer_id INT,
    start_date DATE,
    end_date DATE,
    cost DECIMAL(10,2),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Sample Queries
-- Vehicles rented in a date range
SELECT * FROM rentals
WHERE start_date BETWEEN '2025-01-01' AND '2025-12-31';

-- Total income per vehicle type
SELECT vt.type_name, SUM(r.cost) AS income
FROM rentals r
JOIN vehicles v ON r.vehicle_id = v.vehicle_id
JOIN vehicle_types vt ON v.type_id = vt.type_id
GROUP BY vt.type_name;
