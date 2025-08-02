-- Project 7: Ride Sharing App Insights

-- Average ride duration per driver
SELECT driver_id, AVG(duration) AS avg_duration
FROM rides
GROUP BY driver_id;

-- Rider with most rides per city
SELECT city, rider_id
FROM (
    SELECT city, rider_id, COUNT(*) AS ride_count,
           RANK() OVER (PARTITION BY city ORDER BY COUNT(*) DESC) AS rnk
    FROM rides
    GROUP BY city, rider_id
) WHERE rnk = 1;

-- Ride type classification
SELECT ride_id, type,
       CASE type
           WHEN 'Shared' THEN 'Shared'
           WHEN 'Premium' THEN 'Premium'
           ELSE 'Economy'
       END AS ride_class
FROM rides;

-- Completed and cancelled rides
SELECT * FROM rides WHERE status = 'Completed'
UNION
SELECT * FROM rides WHERE status = 'Cancelled';

-- City-wise earnings
SELECT city, SUM(amount) AS total_earnings
FROM payments
JOIN rides ON payments.ride_id = rides.ride_id
GROUP BY city;

-- Peak hours
SELECT * FROM rides WHERE strftime('%H:%M', start_time) BETWEEN '07:00' AND '09:00';
