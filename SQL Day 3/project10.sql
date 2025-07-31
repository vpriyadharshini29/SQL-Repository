-- Count leads per sales rep
SELECT s.first_name, COUNT(l.lead_id) AS lead_count
FROM sales_reps s
INNER JOIN leads l ON s.rep_id = l.rep_id
GROUP BY s.first_name;

-- Average conversion time
SELECT s.first_name, AVG(DATEDIFF(l.conversion_date, l.created_date)) AS avg_conversion_time
FROM sales_reps s
INNER JOIN leads l ON s.rep_id = l.rep_id
WHERE l.conversion_date IS NOT NULL
GROUP BY s.first_name;

-- Reps who closed more than 5 deals
SELECT s.first_name, COUNT(l.lead_id) AS deal_count
FROM sales_reps s
INNER JOIN leads l ON s.rep_id = l.rep_id
WHERE l.status = 'CLOSED'
GROUP BY s.first_name
HAVING COUNT(l.lead_id) > 5;

-- INNER JOIN reps and leads
SELECT s.first_name, l.lead_id, l.status
FROM sales_reps s
INNER JOIN leads l ON s.rep_id = l.rep_id;

-- RIGHT JOIN reps and clients
SELECT s.first_name, c.client_id
FROM sales_reps s
RIGHT JOIN clients c ON s.rep_id = c.rep_id;

-- SELF JOIN reps from same region
SELECT s1.first_name AS rep1, s2.first_name AS rep2, s1.region
FROM sales_reps s1
INNER JOIN sales_reps s2 ON s1.region = s2.region AND s1.rep_id < s2.rep_id;