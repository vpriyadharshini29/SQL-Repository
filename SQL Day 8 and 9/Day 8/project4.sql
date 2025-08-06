-- Category Tree
WITH RECURSIVE CategoryTree AS (
    SELECT CategoryID, Name, ParentID
    FROM Categories
    WHERE ParentID IS NULL
    UNION ALL
    SELECT c.CategoryID, c.Name, c.ParentID
    FROM Categories c
    JOIN CategoryTree ct ON c.ParentID = ct.CategoryID
)
SELECT * FROM CategoryTree;

-- Rank by Product Count
SELECT CategoryID,
       COUNT(ProductID) AS TotalProducts,
       RANK() OVER (ORDER BY COUNT(ProductID) DESC) AS ProductRank
FROM Products
GROUP BY CategoryID;
