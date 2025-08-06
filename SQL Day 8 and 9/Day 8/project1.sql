-- Create Employee table
CREATE TABLE EmployeePromotions (
    EmpID INT,
    EmpName VARCHAR(100),
    Role VARCHAR(100),
    Salary INT,
    PromotionDate DATE,
    ManagerID INT
);

-- Chronological Promotions
WITH RankedPromotions AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY EmpID ORDER BY PromotionDate) AS rn,
           LEAD(Salary) OVER (PARTITION BY EmpID ORDER BY PromotionDate) AS NextSalary,
           LEAD(Role) OVER (PARTITION BY EmpID ORDER BY PromotionDate) AS NextRole,
           LEAD(PromotionDate) OVER (PARTITION BY EmpID ORDER BY PromotionDate) AS NextPromotion
    FROM EmployeePromotions
)
SELECT *,
       DATEDIFF(DAY, PromotionDate, NextPromotion) AS DaysBetweenPromotions
FROM RankedPromotions;

-- Recursive Manager Hierarchy
WITH RECURSIVE Hierarchy AS (
    SELECT EmpID, EmpName, ManagerID, Role
    FROM EmployeePromotions
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmpID, e.EmpName, e.ManagerID, e.Role
    FROM EmployeePromotions e
    JOIN Hierarchy h ON e.ManagerID = h.EmpID
)
SELECT * FROM Hierarchy;

-- Fastest Promotion
WITH PromotionDuration AS (
    SELECT EmpID,
           MIN(PromotionDate) AS FirstPromotion,
           MAX(PromotionDate) AS LastPromotion,
           DATEDIFF(DAY, MIN(PromotionDate), MAX(PromotionDate)) AS TotalDays
    FROM EmployeePromotions
    GROUP BY EmpID
)
SELECT *, RANK() OVER (ORDER BY TotalDays) AS PromotionRank
FROM PromotionDuration;
