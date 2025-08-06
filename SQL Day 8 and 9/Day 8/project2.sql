-- Recursive Location Hierarchy
WITH RECURSIVE LocationTree AS (
    SELECT RegionID, RegionName, ParentRegionID
    FROM Regions
    WHERE ParentRegionID IS NULL
    UNION ALL
    SELECT r.RegionID, r.RegionName, r.ParentRegionID
    FROM Regions r
    JOIN LocationTree lt ON r.ParentRegionID = lt.RegionID
)
SELECT * FROM LocationTree;

-- Weekly, Monthly Sales
WITH WeeklySales AS (
    SELECT RegionID, DATEPART(WEEK, SaleDate) AS WeekNum, SUM(Amount) AS WeeklyRevenue
    FROM Sales
    GROUP BY RegionID, DATEPART(WEEK, SaleDate)
),
MonthlySales AS (
    SELECT RegionID, DATEPART(MONTH, SaleDate) AS MonthNum, SUM(Amount) AS MonthlyRevenue
    FROM Sales
    GROUP BY RegionID, DATEPART(MONTH, SaleDate)
)
SELECT * FROM WeeklySales;

-- Ranking and Flagging
SELECT *,
       RANK() OVER (PARTITION BY WeekNum ORDER BY WeeklyRevenue DESC) AS RankInWeek,
       LAG(WeeklyRevenue) OVER (PARTITION BY RegionID ORDER BY WeekNum) AS LastWeekRevenue,
       CASE WHEN WeeklyRevenue > 100000 THEN 'Top' ELSE 'Normal' END AS PerformanceFlag
FROM WeeklySales;
