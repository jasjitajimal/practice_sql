/*********************************************
  Script: query_recursive_cte.sql
  Description: Queries demonstrating the use of recursive Common Table Expressions (CTEs) in SQL.
**********************************************/

-- Create Tables

-- Table: Employees
CREATE TABLE IF NOT EXISTS dbo.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    ManagerID INT REFERENCES dbo.Employees(EmployeeID)
);

-- End of Table Creation

-- Insert Sample Data

INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, ManagerID) VALUES
(1, 'John', 'Doe', NULL),
(2, 'Jane', 'Smith', 1),
(3, 'Bob', 'Johnson', 2),
(4, 'Alice', 'Williams', 2),
(5, 'Charlie', 'Brown', 1),
(6, 'Eva', 'Davis', 5);

-- End of Data Insertion

-- Recursive CTE Query 1: Basic Recursive Query
-- Retrieves the hierarchical structure of employees.
-- Comments:
-- - Uses a recursive CTE to traverse the employee hierarchy.
-- - The anchor member selects top-level employees (those with ManagerID IS NULL).
-- - The recursive member selects employees reporting to each manager.
-- - The final SELECT statement retrieves the hierarchical structure.

WITH RecursiveEmployeeCTE AS (
    -- Anchor Member
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        ManagerID,
        0 AS Level
    FROM
        dbo.Employees
    WHERE
        ManagerID IS NULL

    UNION ALL

    -- Recursive Member
    SELECT
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.ManagerID,
        rec.Level + 1 AS Level
    FROM
        dbo.Employees e
    INNER JOIN
        RecursiveEmployeeCTE rec ON e.ManagerID = rec.EmployeeID
)

-- Final SELECT
SELECT
    EmployeeID,
    FirstName,
    LastName,
    ManagerID,
    Level
FROM
    RecursiveEmployeeCTE;

-- Recursive CTE Query 2: Counting Levels in Hierarchy
-- Retrieves the hierarchical structure of employees with level counts.
-- Comments:
-- - Adds a column to count the level in the hierarchy.
-- - Demonstrates the use of the Level column in recursion.

WITH RecursiveEmployeeCTE AS (
    -- Anchor Member
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        ManagerID,
        1 AS Level -- Start counting levels from 1
    FROM
        dbo.Employees
    WHERE
        ManagerID IS NULL

    UNION ALL

    -- Recursive Member
    SELECT
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.ManagerID,
        rec.Level + 1 AS Level
    FROM
        dbo.Employees e
    INNER JOIN
        RecursiveEmployeeCTE rec ON e.ManagerID = rec.EmployeeID
)

-- Final SELECT
SELECT
    EmployeeID,
    FirstName,
    LastName,
    ManagerID,
    Level
FROM
    RecursiveEmployeeCTE;

-- Recursive CTE Query 3: Finding Subordinates of a Manager
-- Retrieves all employees reporting directly or indirectly to a specified manager.
-- Comments:
-- - Specifies a specific manager ID to find subordinates.
-- - The anchor member selects the specified manager.
-- - The recursive member selects all employees reporting to the identified manager.

DECLARE @TargetManagerID INT = 2; -- Specify the manager ID
WITH RecursiveSubordinatesCTE AS (
    -- Anchor Member
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        ManagerID,
        0 AS Level
    FROM
        dbo.Employees
    WHERE
        EmployeeID = @TargetManagerID

    UNION ALL

    -- Recursive Member
    SELECT
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.ManagerID,
        rec.Level + 1 AS Level
    FROM
        dbo.Employees e
    INNER JOIN
        RecursiveSubordinatesCTE rec ON e.ManagerID = rec.EmployeeID
)

-- Final SELECT
SELECT
    EmployeeID,
    FirstName,
    LastName,
    ManagerID,
    Level
FROM
    RecursiveSubordinatesCTE;

-- Recursive CTE Query 4: Organizational Chart
-- Retrieves the organizational chart with employee hierarchy.
-- Comments:
-- - Includes formatting to represent the hierarchy visually.

WITH RecursiveOrganizationalChartCTE AS (
    -- Anchor Member
    SELECT
        EmployeeID,
        FirstName + ' ' + LastName AS EmployeeName,
        ManagerID,
        CAST('' AS NVARCHAR(MAX)) AS ManagerPath
    FROM
        dbo.Employees
    WHERE
        ManagerID IS NULL

    UNION ALL

    -- Recursive Member
    SELECT
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        e.ManagerID,
        rec.ManagerPath + ' > ' + e.FirstName + ' ' + e.LastName AS ManagerPath
    FROM
        dbo.Employees e
    INNER JOIN
        RecursiveOrganizationalChartCTE rec ON e.ManagerID = rec.EmployeeID
)

-- Final SELECT
SELECT
    EmployeeID,
    EmployeeName,
    ManagerID,
    ManagerPath
FROM
    RecursiveOrganizationalChartCTE;



-- Add more queries following the same pattern for various recursive scenarios.

-- End of Script
