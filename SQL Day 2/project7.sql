-- Table
CREATE TABLE feedback (
  feedback_id INT,
  customer_name VARCHAR(100),
  rating INT,
  comment TEXT,
  product VARCHAR(100),
  submitted_date DATE
);

-- Queries
SELECT customer_name, rating, comment FROM feedback WHERE rating >= 4 AND product = 'Smartphone';
SELECT * FROM feedback WHERE comment LIKE '%slow%';
SELECT * FROM feedback WHERE submitted_date BETWEEN CURRENT_DATE - INTERVAL 30 DAY AND CURRENT_DATE;
SELECT * FROM feedback WHERE comment IS NULL;
SELECT DISTINCT product FROM feedback;
SELECT * FROM feedback ORDER BY rating DESC, submitted_date DESC;
