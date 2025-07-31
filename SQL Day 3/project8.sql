-- Total orders per restaurant
SELECT r.restaurant_name, COUNT(o.order_id) AS order_count
FROM restaurants r
INNER JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name;

-- Sum of order values per delivery agent
SELECT d.agent_id, d.first_name, SUM(o.order_value) AS total_value
FROM delivery_agents d
INNER JOIN orders o ON d.agent_id = o.agent_id
GROUP BY d.agent_id, d.first_name;

-- Restaurants with revenue > ₹50,000
SELECT r.restaurant_name, SUM(o.order_value) AS revenue
FROM restaurants r
INNER JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
HAVING SUM(o.order_value) > 50000;

-- INNER JOIN restaurants and orders
SELECT r.restaurant_name, o.order_id, o.order_date
FROM restaurants r
INNER JOIN orders o ON r.restaurant_id = o.restaurant_id;

-- LEFT JOIN delivery agents and orders
SELECT d.first_name, o.order_id
FROM delivery_agents d
LEFT JOIN orders o ON d.agent_id = o.agent_id;

-- SELF JOIN restaurants in same location
SELECT r1.restaurant_name AS restaurant1, r2.restaurant_name AS restaurant2, r1.location
FROM restaurants r1
INNER JOIN restaurants r2 ON r1.location = r2.location AND r1.restaurant_id < r2.restaurant_id;