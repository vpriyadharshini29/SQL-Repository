-- Flight Booking and Passenger Management System

-- 1. Create Tables
CREATE TABLE flights (
    flight_id INT PRIMARY KEY,
    flight_no VARCHAR(10),
    flight_date DATE CHECK (flight_date >= CURRENT_DATE),
    status VARCHAR(20),
    seat_count INT
);

CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    seat_no VARCHAR(10),
    booking_date DATE,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    ticket_id INT,
    amount DECIMAL(10, 2),
    payment_status VARCHAR(20),
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);

-- 2. Insert a Ticket With Foreign Key to Passenger and Flight
INSERT INTO tickets (ticket_id, passenger_id, flight_id, seat_no, booking_date)
VALUES (1, 201, 101, '12A', CURRENT_DATE);

-- 3. Update Flight Status and Seat Count
UPDATE flights
SET status = 'Departed',
    seat_count = seat_count - 1
WHERE flight_id = 101;

-- 4. Delete Unpaid Tickets Using Date Filter
DELETE FROM tickets
WHERE ticket_id IN (
    SELECT t.ticket_id
    FROM tickets t
    LEFT JOIN payments p ON t.ticket_id = p.ticket_id
    WHERE p.payment_status IS NULL AND booking_date < CURRENT_DATE - INTERVAL '1 DAY'
);

-- 5. Drop and Recreate NOT NULL on seat_no
ALTER TABLE tickets ALTER COLUMN seat_no DROP NOT NULL;
-- ... some operations ...
ALTER TABLE tickets ALTER COLUMN seat_no SET NOT NULL;

-- 6. Transaction: Insert Ticket + Payment; Rollback if Payment Fails
BEGIN;

-- Insert ticket
INSERT INTO tickets (ticket_id, passenger_id, flight_id, seat_no, booking_date)
VALUES (2, 202, 102, '15B', CURRENT_DATE);

-- Insert payment
INSERT INTO payments (payment_id, ticket_id, amount, payment_status)
VALUES (2, 2, -1000.00, 'Pending');

-- Check for invalid payment
DO $$
BEGIN
  IF (SELECT amount FROM payments WHERE payment_id = 2) < 0 THEN
    RAISE EXCEPTION 'Negative payment amount!';
  END IF;
END;
$$;

COMMIT;
-- Or ROLLBACK on error
