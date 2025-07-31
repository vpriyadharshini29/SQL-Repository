-- Revenue generated per seller
SELECT s.seller_id, s.seller_name, SUM(p.price * pu.quantity) AS revenue
FROM sellers s
INNER JOIN products p ON s.seller_id = p.seller_id
INNER JOIN purchases pu ON p.product_id = pu.product_id
GROUP BY s.seller_id, s.seller_name;

-- Most purchased products
SELECT p.product_name, COUNT(pu.purchase_id) AS purchase_count
FROM products p
INNER JOIN purchases pu ON p.product_id = pu.product_id
GROUP BY p.product_name
ORDER BY purchase_count DESC;

-- Sellers with revenue > ₹1,00,000
SELECT s.seller_name, SUM(p.price * pu.quantity) AS revenue
FROM sellers s
INNER JOIN products p ON s.seller_id = p.seller_id
INNER JOIN purchases pu ON p.product_id = pu.product_id
GROUP BY s.seller_name
HAVING SUM(p.price * pu.quantity) > 100000;

-- INNER JOIN purchases, products, sellers
SELECT s.seller_name, p.product_name, pu.purchase_date
FROM sellers s
INNER JOIN products p ON s.seller_id = p.seller_id
INNER JOIN purchases pu ON p.product_id = pu.product_id;

-- LEFT JOIN sellers and products
SELECT s.seller_name, p.product_name
FROM sellers s
LEFT JOIN products p ON s.seller_id = p.seller_id;

-- SELF JOIN sellers from same city
SELECT s1.seller_name AS seller1, s2.seller_name AS seller2, s1.city
FROM sellers s1
INNER JOIN sellers s2 ON s1.city = s2.city AND s1.seller_id < s2.seller_id;