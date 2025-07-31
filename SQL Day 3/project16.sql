-- Total bookings per airline
SELECT a.airline_name, COUNT(b.booking_id) AS booking_count
FROM airlines a
INNER JOIN flights f ON a.airline_id = f.airline_id
INNER JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY a.airline_name;

-- Most frequent flyers
SELECT p.first_name, COUNT(b.booking_id) AS flight_count
FROM passengers p
INNER JOIN bookings b ON p.passenger_id = b.passenger_id
GROUP BY p.first_name
ORDER BY flight_count DESC;

-- Flights with avg occupancy > 80%
SELECT f.flight_id, AVG(b.occupancy) AS avg_occupancy
FROM flights f
INNER JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id
HAVING AVG(b.occupancy) > 80;

-- INNER JOIN bookings, flights, passengers
SELECT p.first_name, f.flight_number, b.booking_date
FROM passengers p
INNER JOIN bookings b ON p.passenger_id = b.passenger_id
INNER JOIN flights f ON b.flight_id = f.flight_id;

-- RIGHT JOIN airlines and flights
SELECT a.airline_name, f.flight_id
FROM flights f
RIGHT JOIN airlines a ON f.airline_id = a.airline_id;

-- SELF JOIN passengers who flew same routes
SELECT p1.first_name AS passenger1, p2.first_name AS passenger2, f.flight_number
FROM bookings b1
INNER JOIN bookings b2 ON b1.flight_id = b2.flight_id AND b1.passenger_id < b2.passenger_id
INNER JOIN passengers p1 ON b1.passenger_id = p1.passenger_id
INNER JOIN passengers p2 ON b2.passenger_id = p2.passenger_id
INNER JOIN flights f ON b1.flight_id = f.flight_id;