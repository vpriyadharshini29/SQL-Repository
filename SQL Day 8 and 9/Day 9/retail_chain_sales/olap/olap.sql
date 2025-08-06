
-- OLAP Queries for Retail Chain Sales Analysis System
-- Daily Sales Report
SELECT t.date, SUM(f.amount) AS total_sales
FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
GROUP BY t.date
ORDER BY t.date;

-- Monthly Sales
SELECT t.month, t.year, SUM(f.amount) AS monthly_sales
FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
GROUP BY t.year, t.month
ORDER BY t.year, t.month;

-- Quarterly Sales
SELECT t.quarter, t.year, SUM(f.amount) AS quarterly_sales
FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
GROUP BY t.year, t.quarter
ORDER BY t.year, t.quarter;
