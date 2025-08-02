-- Real Estate Property Listings Analyzer

CREATE TABLE agents (agent_id INT PRIMARY KEY, name VARCHAR(100), city VARCHAR(100));
CREATE TABLE properties (property_id INT PRIMARY KEY, agent_id INT, type VARCHAR(50), status VARCHAR(20));
CREATE TABLE sales (sale_id INT PRIMARY KEY, property_id INT, amount DECIMAL(10,2), sale_date DATE);
CREATE TABLE clients (client_id INT PRIMARY KEY, name VARCHAR(100));

-- Agents with above avg sales
SELECT agent_id FROM sales s JOIN properties p ON s.property_id = p.property_id GROUP BY agent_id HAVING SUM(amount) > (
  SELECT AVG(total) FROM (SELECT SUM(amount) AS total FROM sales s JOIN properties p ON s.property_id = p.property_id GROUP BY agent_id) t
);

-- CASE property type
SELECT type,
CASE
  WHEN type = 'R' THEN 'Residential'
  ELSE 'Commercial'
END AS type_label FROM properties;

-- UNION sold/listed
SELECT * FROM properties WHERE status = 'Sold'
UNION ALL
SELECT * FROM properties WHERE status = 'Listed';

-- Highest sale per agent
SELECT * FROM sales s1 WHERE amount = (
  SELECT MAX(amount) FROM sales s2 WHERE s2.property_id IN (
    SELECT property_id FROM properties WHERE agent_id = (SELECT agent_id FROM properties WHERE property_id = s1.property_id)
  )
);

-- Sales by city
SELECT a.city, SUM(s.amount) FROM agents a JOIN properties p ON a.agent_id = p.agent_id JOIN sales s ON p.property_id = s.property_id GROUP BY a.city;

-- Time between listing and sale
SELECT property_id, DATEDIFF(sale_date, (SELECT listing_date FROM listings WHERE listings.property_id = p.property_id)) AS days_on_market
FROM properties p JOIN sales s ON p.property_id = s.property_id;