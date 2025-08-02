-- Project 8: Warehouse Stock and Order Fulfillment

-- Products below reorder level
SELECT * FROM inventory WHERE stock < reorder_level;

-- Product movement category
SELECT product_id, stock,
       CASE
           WHEN stock < 50 THEN 'Fast'
           WHEN stock BETWEEN 50 AND 200 THEN 'Medium'
           ELSE 'Slow'
       END AS movement_category
FROM inventory;

-- Supplier with least delayed deliveries
SELECT supplier_id FROM (
    SELECT supplier_id, AVG(delivery_delay) AS avg_delay
    FROM orders
    GROUP BY supplier_id
) ORDER BY avg_delay ASC LIMIT 1;

-- Fulfillment rate by supplier
SELECT supplier_id,
       SUM(CASE WHEN fulfilled = 1 THEN 1 ELSE 0 END)*1.0 / COUNT(*) AS fulfillment_rate
FROM orders
GROUP BY supplier_id;

-- Online and offline stock
SELECT * FROM inventory WHERE channel = 'Online'
UNION ALL
SELECT * FROM inventory WHERE channel = 'Offline';

-- Expiry tracking
SELECT * FROM inventory WHERE expiry_date < DATE('now', '+30 days');
