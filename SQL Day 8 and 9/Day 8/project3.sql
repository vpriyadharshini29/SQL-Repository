-- Rank by Subject
SELECT *,
       RANK() OVER (PARTITION BY Subject ORDER BY Marks DESC) AS SubjectRank,
       ROW_NUMBER() OVER (PARTITION BY StudentID, Subject ORDER BY Semester) AS AttemptOrder,
       LAG(Marks) OVER (PARTITION BY StudentID, Subject ORDER BY Semester) AS PrevMarks
FROM StudentGrades;

-- Recursive Course Path
WITH RECURSIVE CoursePath AS (
    SELECT CourseID, PrerequisiteID
    FROM Courses
    WHERE PrerequisiteID IS NULL
    UNION ALL
    SELECT c.CourseID, c.PrerequisiteID
    FROM Courses c
    JOIN CoursePath cp ON c.PrerequisiteID = cp.CourseID
)
SELECT * FROM CoursePath;
