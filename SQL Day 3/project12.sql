-- Total rentals per vehicle
SELECT v.vehicle_id, v.model, COUNT(r.rental_id) AS rental_count
FROM vehicles v
INNER JOIN rentals r ON v.vehicle_id = r.vehicle_id
GROUP BY v.vehicle_id, v.model;

-- Vehicles rented more than 10 times
SELECT v.vehicle_id, v.model, COUNT(r.rental_id) AS rental_count
FROM vehicles v
INNER JOIN rentals r ON v.vehicle_id = r.vehicle_id
GROUP BY v.vehicle_id, v.model
HAVING COUNT(r.rental_id) > 10;

-- Average rental cost per car type
SELECT v.vehicle_type, AVG(p.amount) AS avg_rental_cost
FROM vehicles v
INNER JOIN rentals r ON v.vehicle_id = r.vehicle_id
INNER JOIN payments p ON r.rental_id = p.rental_id
GROUP BY v.vehicle_type;

-- INNER JOIN rentals and vehicles
SELECT v.model, r.rental_date
FROM vehicles v
INNER JOIN rentals r ON v.vehicle_id = r.vehicle_id;

-- LEFT JOIN vehicles and payments
SELECT v.vehicle_id, v.model, p.amount
FROM vehicles v
LEFT JOIN rentals r ON v.vehicle_id = r.vehicle_id
LEFT JOIN payments p ON r.rental_id = p.rental_id;

-- SELF JOIN cars of same model and type
SELECT v1.vehicle_id AS vehicle1, v2.vehicle_id AS vehicle2, v1.model, v1.vehicle_type
FROM vehicles v1
INNER JOIN vehicles v2 ON v1.model = v2.model AND v1.vehicle_type = v2.vehicle_type AND v1.vehicle_id < v2.vehicle_id;