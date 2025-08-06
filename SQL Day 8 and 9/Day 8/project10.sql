-- Document Versions
SELECT *,
       ROW_NUMBER() OVER (PARTITION BY DocumentID ORDER BY VersionNumber) AS VersionOrder,
       LAG(ContentHash) OVER (PARTITION BY DocumentID ORDER BY VersionNumber) AS PreviousHash
FROM DocumentVersions;

-- Recursive Dependencies
WITH RECURSIVE DocDeps AS (
    SELECT DocID, DependsOn
    FROM DocumentDependency
    WHERE DependsOn IS NULL
    UNION ALL
    SELECT d.DocID, d.DependsOn
    FROM DocumentDependency d
    JOIN DocDeps dp ON d.DependsOn = dp.DocID
)
SELECT * FROM DocDeps;
