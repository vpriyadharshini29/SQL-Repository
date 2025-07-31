-- Total loans issued per officer
SELECT o.first_name, COUNT(l.loan_id) AS loan_count
FROM officers o
INNER JOIN loans l ON o.officer_id = l.officer_id
GROUP BY o.first_name;

-- Clients with repayment > ₹1,00,000
SELECT c.first_name, SUM(r.amount) AS total_repayment
FROM clients c
INNER JOIN loans l ON c.client_id = l.client_id
INNER JOIN repayments r ON l.loan_id = r.loan_id
GROUP BY c.first_name
HAVING SUM(r.amount) > 100000;

-- Officers approving more than 10 loans
SELECT o.first_name, COUNT(l.loan_id) AS loan_count
FROM officers o
INNER JOIN loans l ON o.officer_id = l.officer_id
GROUP BY o.first_name
HAVING COUNT(l.loan_id) > 10;

-- INNER JOIN clients, loans, officers
SELECT c.first_name, l.loan_amount, o.first_name AS officer
FROM clients c
INNER JOIN loans l ON c.client_id = l.client_id
INNER JOIN officers o ON l.officer_id = o.officer_id;

-- FULL OUTER JOIN loans and repayments
SELECT l.loan_id, r.repayment_id
FROM loans l
FULL OUTER JOIN repayments r ON l.loan_id = r.loan_id;

-- SELF JOIN clients from same city
SELECT c1.first_name AS client1, c2.first_name AS client2, c1.city
FROM clients c1
INNER JOIN clients c2 ON c1.city = c2.city AND c1.client_id < c2.client_id;