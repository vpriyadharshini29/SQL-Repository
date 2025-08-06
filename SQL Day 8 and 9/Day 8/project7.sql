-- Recursive Course Paths
WITH RECURSIVE CoursePaths AS (
    SELECT CourseID, PrerequisiteID
    FROM Courses
    WHERE PrerequisiteID IS NULL
    UNION ALL
    SELECT c.CourseID, c.PrerequisiteID
    FROM Courses c
    JOIN CoursePaths cp ON c.PrerequisiteID = cp.CourseID
)
SELECT * FROM CoursePaths;

-- Next Recommended
SELECT *,
       LEAD(CourseID) OVER (PARTITION BY StudentID ORDER BY CompletionDate) AS NextCourse
FROM StudentCourses;
