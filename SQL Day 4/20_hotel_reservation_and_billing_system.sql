-- Project 10: Hotel Reservation & Billing System

-- Bill summary per guest
SELECT guest_id, SUM(amount) AS total_bill
FROM payments
GROUP BY guest_id;

-- Room type labels
SELECT room_id, type,
       CASE type
           WHEN 'Economy' THEN 'Economy'
           WHEN 'Deluxe' THEN 'Deluxe'
           ELSE 'Suite'
       END AS room_label
FROM rooms;

-- Completed and upcoming bookings
SELECT * FROM bookings WHERE check_out < DATE('now')
UNION
SELECT * FROM bookings WHERE check_in >= DATE('now');

-- Most frequent guest per room type
SELECT room_type, guest_id
FROM (
    SELECT r.type AS room_type, b.guest_id, COUNT(*) AS stays,
           RANK() OVER (PARTITION BY r.type ORDER BY COUNT(*) DESC) AS rnk
    FROM bookings b
    JOIN rooms r ON b.room_id = r.room_id
    GROUP BY r.type, b.guest_id
) WHERE rnk = 1;

-- Revenue per room type
SELECT r.type, SUM(p.amount) AS revenue
FROM payments p
JOIN bookings b ON p.booking_id = b.booking_id
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.type;

-- Check-in/check-out analytics
SELECT * FROM bookings WHERE check_in BETWEEN DATE('now', '-30 days') AND DATE('now');
