-- Weekly Sales Rank
SELECT *,
       RANK() OVER (PARTITION BY Week ORDER BY TotalSales DESC) AS WeeklyRank,
       LAG(TotalSales) OVER (PARTITION BY ProductID ORDER BY Week) AS LastWeekSales
FROM WeeklyProductSales;

-- Monthly CTE
WITH MonthlySales AS (
    SELECT ProductID, MONTH(SaleDate) AS Month, SUM(Amount) AS MonthlyRevenue
    FROM Sales
    GROUP BY ProductID, MONTH(SaleDate)
)
SELECT * FROM MonthlySales;
