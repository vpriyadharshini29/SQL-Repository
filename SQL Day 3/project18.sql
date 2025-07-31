-- Count properties listed per agent
SELECT a.first_name, COUNT(p.property_id) AS property_count
FROM agents a
INNER JOIN properties p ON a.agent_id = p.agent_id
GROUP BY a.first_name;

-- Average property price per location
SELECT p.location, AVG(p.price) AS avg_price
FROM properties p
GROUP BY p.location;

-- Agents with > 20 inquiries
SELECT a.first_name, COUNT(i.inquiry_id) AS inquiry_count
FROM agents a
INNER JOIN inquiries i ON a.agent_id = i.agent_id
GROUP BY a.first_name
HAVING COUNT(i.inquiry_id) > 20;

-- INNER JOIN properties, agents, inquiries
SELECT a.first_name, p.address, i.inquiry_date
FROM agents a
INNER JOIN properties p ON a.agent_id = p.agent_id
INNER JOIN inquiries i ON p.property_id = i.property_id;

-- LEFT JOIN properties and inquiries
SELECT p.address, i.inquiry_id
FROM properties p
LEFT JOIN inquiries i ON p.property_id = i.property_id;

-- SELF JOIN agents working in same area
SELECT a1.first_name AS agent1, a2.first_name AS agent2, a1.area
FROM agents a1
INNER JOIN agents a2 ON a1.area = a2.area AND a1.agent_id < a2.agent_id;