-- Vehicle Rental Management System

-- 1. Create Tables
CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    model VARCHAR(100),
    available BOOLEAN,
    mileage INT,
    fuel_level DECIMAL(5,2)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE rentals (
    rental_id INT PRIMARY KEY,
    vehicle_id INT,
    customer_id INT,
    rental_date DATE,
    return_date DATE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CHECK (return_date > rental_date)
);

CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY,
    rental_id INT,
    amount DECIMAL(10, 2),
    payment_status VARCHAR(20),
    FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);

-- 2. Insert Rentals With Vehicle Availability Constraint
-- Only allow rentals for available vehicles
INSERT INTO rentals (rental_id, vehicle_id, customer_id, rental_date, return_date)
SELECT 1, 101, 201, '2025-08-01', '2025-08-05'
WHERE EXISTS (
    SELECT 1 FROM vehicles WHERE vehicle_id = 101 AND available = TRUE
);

-- 3. Update Mileage and Fuel After Return
UPDATE vehicles
SET mileage = mileage + 300,
    fuel_level = 20.0,
    available = TRUE
WHERE vehicle_id = 101;

-- 4. Delete Completed Rentals Older Than 3 Months
DELETE FROM rentals
WHERE return_date < CURRENT_DATE - INTERVAL '3 months';

-- 5. CHECK (return_date > rental_date) is already added in table creation

-- 6. Use SAVEPOINT During Rental, Rollback on Pricing Error
BEGIN;

SAVEPOINT start_rental;

-- Insert rental
INSERT INTO rentals (rental_id, vehicle_id, customer_id, rental_date, return_date)
VALUES (2, 102, 202, '2025-08-03', '2025-08-08');

-- Insert invoice
INSERT INTO invoices (invoice_id, rental_id, amount, payment_status)
VALUES (2, 2, -1500.00, 'Pending');

-- Validate price
DO $$
BEGIN
  IF (SELECT amount FROM invoices WHERE invoice_id = 2) < 0 THEN
    ROLLBACK TO SAVEPOINT start_rental;
  END IF;
END;
$$;

COMMIT;

-- 7. Demonstrate Durability (e.g., COMMIT ensures persistence even after crash)
-- After COMMIT, data remains even if connection is lost
