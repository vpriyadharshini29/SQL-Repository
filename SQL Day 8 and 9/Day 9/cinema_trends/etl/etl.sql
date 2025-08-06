
-- ETL for Cinema Ticket Sales and Trends
-- Example: Insert into data warehouse from OLTP
INSERT INTO fact_sales (sale_id, time_id, store_id, product_id, customer_id, amount)
SELECT
    o.order_id,
    EXTRACT(DOY FROM o.order_date) AS time_id,
    1 AS store_id,
    oi.product_id,
    o.customer_id,
    oi.quantity * p.price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;
