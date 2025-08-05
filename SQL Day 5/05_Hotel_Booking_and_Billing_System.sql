-- Hotel Booking and Billing System

-- 1. Create Tables
CREATE TABLE guests (
    guest_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    room_number VARCHAR(10),
    room_capacity INT,
    status VARCHAR(20) -- 'Available', 'Occupied'
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    checkin_date DATE,
    checkout_date DATE,
    number_of_guests INT,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    booking_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

-- 2. Insert Guest
INSERT INTO guests (guest_id, name, phone) 
VALUES (1, 'Priya Kumar', '9876543210');

-- 3. Update Room Status on Check-in
UPDATE rooms
SET status = 'Occupied'
WHERE room_id = 101;

-- 4. Update Room Status on Check-out
UPDATE rooms
SET status = 'Available'
WHERE room_id = 101;

-- 5. Delete Booking → Cascade to Payments
DELETE FROM bookings
WHERE booking_id = 5001;

-- 6. CHECK: number_of_guests ≤ room_capacity
ALTER TABLE bookings
ADD CONSTRAINT chk_guest_capacity CHECK (number_of_guests <= 5); -- Assuming max 5

-- 7. Modify and Drop Constraint on Minimum Stay (at least 1 day)
ALTER TABLE bookings
ADD CONSTRAINT chk_stay_duration CHECK (checkout_date > checkin_date);

-- Drop the constraint later if needed
ALTER TABLE bookings
DROP CONSTRAINT chk_stay_duration;

-- 8. Transaction: Booking + Payment
BEGIN;

-- Booking Insert
INSERT INTO bookings (booking_id, guest_id, room_id, checkin_date, checkout_date, number_of_guests)
VALUES (5002, 1, 101, '2025-08-10', '2025-08-13', 2);

-- Payment Insert
INSERT INTO payments (payment_id, booking_id, amount, payment_date)
VALUES (9001, 5002, 4500.00, CURRENT_DATE);

-- Simulate payment failure
-- ROLLBACK;

-- If everything succeeds
COMMIT;
