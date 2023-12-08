/*********************************************
  Script: query_cte.sql
  Description: Queries demonstrating the syntax and usage of Common Table Expressions (CTEs).
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

-- Query 1: Basic CTE
-- Retrieves employee details using a simple CTE.
-- Comments:
-- - CTEs are defined using the WITH keyword.
-- - Provides a named, temporary result set within a SELECT, INSERT, UPDATE, or DELETE statement.

WITH EmployeeCTE AS (
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        Salary
    FROM
        dbo.Employees
)
SELECT
    *
FROM
    EmployeeCTE;

-- Query 2: Recursive CTE
-- Retrieves the hierarchical structure of employees using a recursive CTE.
-- Comments:
-- - Recursive CTEs enable traversing hierarchical data.
-- - The CTE refers to itself in the recursion.

WITH RecursiveEmployeeCTE AS (
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        ManagerID
    FROM
        dbo.Employees
    WHERE
        ManagerID IS NULL

    UNION ALL

    SELECT
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.ManagerID
    FROM
        dbo.Employees e
    JOIN
        RecursiveEmployeeCTE r ON e.ManagerID = r.EmployeeID
)
SELECT
    *
FROM
    RecursiveEmployeeCTE;

-- Query 3: CTE with Aggregation
-- Calculates the average salary using a CTE with aggregation.
-- Comments:

-- - Aggregation functions can be applied to CTEs for summary calculations.

WITH AverageSalaryCTE AS (
    SELECT
        AVG(Salary) AS AvgSalary
    FROM
        dbo.Employees
)
SELECT
    *
FROM
    AverageSalaryCTE;

-- Query 4: CTE with ROW_NUMBER()
-- Assigns row numbers to employees based on salary using a CTE with ROW_NUMBER().
-- Comments:
-- - ROW_NUMBER() is a window function used in CTEs to assign unique row numbers.

WITH RowNumberCTE AS (
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        Salary,
        ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
    FROM
        dbo.Employees
)
SELECT
    *
FROM
    RowNumberCTE;

-- Query 5: Multiple CTEs
-- Uses multiple CTEs in a single query to organize and process data step by step.
-- Comments:
-- - Multiple CTEs can be defined, and they are referenced in subsequent CTEs or the final SELECT.

WITH
    HighSalaryCTE AS (
        SELECT
            EmployeeID,
            FirstName,
            LastName,
            Salary
        FROM
            dbo.Employees
        WHERE
            Salary > 80000
    ),
    ManagerCTE AS (
        SELECT
            e.EmployeeID,
            e.FirstName,
            e.LastName,
            m.ManagerName
        FROM
            HighSalaryCTE e
        LEFT JOIN
            dbo.Managers m ON e.EmployeeID = m.EmployeeID
    )
SELECT
    *
FROM
    ManagerCTE;

-- Query 6: CTE with DELETE Statement
-- Uses a CTE to delete records based on a condition.
-- Comments:
-- - CTEs can be used with DELETE, UPDATE, and INSERT statements.

WITH EmployeesToDeleteCTE AS (
    SELECT
        EmployeeID
    FROM
        dbo.Employees
    WHERE
        Salary < 50000
)
DELETE FROM
    dbo.Employees
WHERE
    EmployeeID IN (SELECT EmployeeID FROM EmployeesToDeleteCTE);

-- Query 7: CTE with INSERT Statement
-- Uses a CTE to insert records into a target table.
-- Comments:
-- - CTEs can be used to generate data for insertion.

WITH NewEmployeesCTE AS (
    SELECT
        'John' AS FirstName,
        'Doe' AS LastName,
        60000 AS Salary
)
INSERT INTO
    dbo.Employees (FirstName, LastName, Salary)
SELECT
    FirstName,
    LastName,
    Salary
FROM
    NewEmployeesCTE;

-- Query 8: CTE with UPDATE Statement
-- Uses a CTE to update records based on a condition.
-- Comments:
-- - CTEs can be used to update records in a target table.

WITH EmployeesToUpdateCTE AS (
    SELECT
        EmployeeID,
        Salary * 1.1 AS UpdatedSalary
    FROM
        dbo.Employees
    WHERE
        Salary < 70000
)
UPDATE
    dbo.Employees
SET
    Salary = u.UpdatedSalary
FROM
    dbo.Employees e
JOIN
    EmployeesToUpdateCTE u ON e.EmployeeID = u.EmployeeID;

-- Query 9: CTE in a View
-- Creates a view using a CTE for reuse in queries.
-- Comments:
-- - CTEs can be used within views to encapsulate complex logic.

CREATE VIEW EmployeeDetailsView AS
WITH EmployeeDetailsCTE AS (
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        Salary
    FROM
        dbo.Employees
)
SELECT
    *
FROM
    EmployeeDetailsCTE;

-- Query 10: CTE with MERGE Statement
-- Uses a CTE to perform a conditional update or insert using the MERGE statement.
-- Comments:
-- - MERGE is a powerful statement for handling conditional insert, update, and delete operations.

WITH EmployeeChangesCTE AS (
    SELECT
        EmployeeID,
        'Jane' AS FirstName,
        'Smith' AS LastName,
        75000 AS Salary
    FROM
        dbo.Employees
    WHERE
        DepartmentID = 2
)
MERGE INTO
    dbo.Employees AS target
USING
    EmployeeChangesCTE AS source ON target.EmployeeID = source.EmployeeID
WHEN MATCHED THEN
    UPDATE SET
        target.FirstName = source.FirstName,
        target.LastName = source.LastName,
        target.Salary = source.Salary
WHEN NOT MATCHED THEN
    INSERT (EmployeeID, FirstName, LastName, Salary)
    VALUES (source.EmployeeID, source.FirstName, source.LastName, source.Salary);

-- File Documentation:
-- This script demonstrates various uses of Common Table Expressions (CTEs) in SQL Server.
-- CTEs are temporary result sets used to organize and process data within a query.
-- The script includes examples of basic CTEs, recursive CTEs, CTEs with aggregation, and more.

-- End of Script
