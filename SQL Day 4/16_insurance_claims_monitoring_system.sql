-- Project 6: Insurance Claims Monitoring System

-- Average claim per insurance type
SELECT insurance_type, AVG(amount) AS avg_claim
FROM claims
GROUP BY insurance_type;

-- Claim status labels
SELECT claim_id, status,
       CASE status
           WHEN 'Approved' THEN 'Approved'
           WHEN 'Pending' THEN 'Pending'
           ELSE 'Rejected'
       END AS claim_status
FROM claims;

-- Old and new claims
SELECT * FROM claims WHERE claim_date < DATE('now', '-1 year')
UNION ALL
SELECT * FROM claims WHERE claim_date >= DATE('now', '-1 year');

-- Highest claim per client
SELECT client_id, MAX(amount) AS highest_claim
FROM claims
GROUP BY client_id;

-- Avg claims per agent
SELECT agent_id, AVG(amount) AS avg_claims
FROM claims
GROUP BY agent_id;

-- Claims filed this quarter
SELECT * FROM claims
WHERE strftime('%Y-%m', claim_date) BETWEEN strftime('%Y', 'now') || '-01' AND strftime('%Y', 'now') || '-03';
