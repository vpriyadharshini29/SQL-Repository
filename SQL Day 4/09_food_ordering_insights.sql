-- Online Food Ordering Insights

CREATE TABLE restaurants (restaurant_id INT PRIMARY KEY, name VARCHAR(100), area VARCHAR(100));
CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE orders (order_id INT PRIMARY KEY, restaurant_id INT, customer_id INT, order_date DATE);
CREATE TABLE dishes (dish_id INT PRIMARY KEY, name VARCHAR(100), popularity_score INT);

-- Dish popularity %
SELECT dish_id, (popularity_score * 100 / (SELECT SUM(popularity_score) FROM dishes)) AS popularity_percent FROM dishes;

-- Order volume by area
SELECT r.area, COUNT(*) FROM orders o JOIN restaurants r ON o.restaurant_id = r.restaurant_id GROUP BY r.area;

-- Bucket customers
SELECT customer_id, COUNT(*) AS total_orders,
CASE
  WHEN COUNT(*) > 20 THEN 'Gold'
  WHEN COUNT(*) > 10 THEN 'Silver'
  ELSE 'Bronze'
END AS category FROM orders GROUP BY customer_id;

-- Top customer per area
SELECT * FROM customers c WHERE customer_id IN (
  SELECT customer_id FROM orders o JOIN restaurants r ON o.restaurant_id = r.restaurant_id
  WHERE r.area = 'Downtown' GROUP BY customer_id ORDER BY COUNT(*) DESC LIMIT 1
);

-- Delivery vs pickup
SELECT * FROM delivery_orders
UNION ALL
SELECT * FROM pickup_orders;

-- Orders by date
SELECT order_date, COUNT(*) FROM orders GROUP BY order_date;