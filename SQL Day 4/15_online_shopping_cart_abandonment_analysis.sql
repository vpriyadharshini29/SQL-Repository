-- Project 5: Online Shopping Cart Abandonment Analysis

-- Users who abandon carts more than 3 times
SELECT user_id
FROM carts
WHERE status = 'Abandoned'
GROUP BY user_id
HAVING COUNT(*) > 3;

-- Label cart status
SELECT cart_id, user_id,
       CASE status
           WHEN 'Completed' THEN 'Completed'
           ELSE 'Abandoned'
       END AS cart_status
FROM carts;

-- Items added vs purchased
SELECT * FROM carts
UNION
SELECT * FROM orders;

-- Most abandoned product per user
SELECT user_id, product_id
FROM carts c1
WHERE status = 'Abandoned' AND NOT EXISTS (
    SELECT 1 FROM carts c2
    WHERE c2.user_id = c1.user_id AND c2.status = 'Abandoned'
    GROUP BY product_id
    HAVING COUNT(*) > COUNT(*) -- force max
);

-- Abandonments in the last week
SELECT * FROM carts WHERE status = 'Abandoned' AND cart_date >= DATE('now', '-7 days');

-- Cart conversion rate
SELECT u.user_id, COUNT(o.order_id)*1.0 / COUNT(c.cart_id) AS conversion_rate
FROM users u
LEFT JOIN carts c ON u.user_id = c.user_id
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id;
