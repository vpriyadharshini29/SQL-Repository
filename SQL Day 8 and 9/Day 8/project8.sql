-- Full Org Chart
WITH RECURSIVE OrgChart AS (
    SELECT EmpID, EmpName, ManagerID
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmpID, e.EmpName, e.ManagerID
    FROM Employees e
    JOIN OrgChart o ON e.ManagerID = o.EmpID
)
SELECT * FROM OrgChart;

-- Rank Managers
SELECT ManagerID,
       COUNT(*) AS TeamSize,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS ManagerRank
FROM Employees
WHERE ManagerID IS NOT NULL
GROUP BY ManagerID;
