-- Project 3: Subscription-Based SaaS Analytics

-- Plan-wise average revenue
SELECT plan_id, AVG(amount) AS avg_revenue
FROM payments
GROUP BY plan_id;

-- User activity status
SELECT user_id, last_login,
       CASE
           WHEN trial = 1 THEN 'Trial'
           WHEN last_login >= DATE('now', '-30 days') THEN 'Active'
           ELSE 'Inactive'
       END AS activity_status
FROM users;

-- Merge paid and free-tier users
SELECT * FROM users WHERE plan_id IS NOT NULL
UNION
SELECT * FROM users WHERE plan_id IS NULL;

-- Monthly revenue trends
SELECT strftime('%Y-%m', payment_date) AS month, SUM(amount) AS revenue
FROM payments
GROUP BY month;

-- Longest-subscribed users
SELECT user_id FROM subscriptions s1
WHERE DATEDIFF('day', start_date, end_date) = (
    SELECT MAX(DATEDIFF('day', start_date, end_date))
    FROM subscriptions s2 WHERE s2.user_id = s1.user_id
);

-- Renewal reminders
SELECT * FROM subscriptions WHERE end_date BETWEEN DATE('now') AND DATE('now', '+7 days');
