-- Order Stages
SELECT *,
       ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY StageTime) AS OrderStage,
       LAG(StageTime) OVER (PARTITION BY CustomerID ORDER BY StageTime) AS PreviousStageTime,
       DATEDIFF(MINUTE, LAG(StageTime) OVER (PARTITION BY CustomerID ORDER BY StageTime), StageTime) AS TimeGap
FROM OrderStages;

-- Rank by Order Frequency
SELECT CustomerID,
       COUNT(OrderID) AS OrdersPlaced,
       RANK() OVER (ORDER BY COUNT(OrderID) DESC) AS FrequentRank
FROM Orders
GROUP BY CustomerID;
