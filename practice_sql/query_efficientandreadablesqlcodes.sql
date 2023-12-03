/*********************************************
  Script: query_efficient_and_readable_sql_codes.sql
  Description: Demonstrates best practices in writing efficient and readable SQL code.
**********************************************/

-- Query 1: Use Table Aliases for Readability
-- Selects employee details along with department information.
-- Comments:
-- - Table aliases (e, d) improve code readability by shortening table names.
-- - Meaningful column names make the query self-explanatory.
-- - Proper indentation enhances visual structure.

SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary,
    d.DepartmentName
FROM
    dbo.Employees AS e
JOIN
    dbo.Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE
    e.Salary > 50000
ORDER BY
    e.LastName ASC;

-- Query 2: Utilize Common Table Expressions (CTEs) for Complex Queries
-- Finds employees with a salary greater than the department's average salary.
-- Comments:
-- - Common Table Expressions (CTEs) enhance query modularity and readability.
-- - Descriptive aliasing improves understanding of subqueries.
-- - Meaningful table and column names make the code self-documenting.

WITH DepartmentAvgSalary AS (
    SELECT
        DepartmentID,
        AVG(Salary) AS AvgSalary
    FROM
        dbo.Employees
    GROUP BY
        DepartmentID
)
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary,
    d.DepartmentName
FROM
    dbo.Employees AS e
JOIN
    dbo.Departments AS d ON e.DepartmentID = d.DepartmentID
JOIN
    DepartmentAvgSalary AS a ON e.DepartmentID = a.DepartmentID
WHERE
    e.Salary > a.AvgSalary
ORDER BY
    e.LastName ASC;

-- Query 3: Use Parameters in Dynamic SQL to Prevent SQL Injection
-- Retrieves employees based on a specified department ID using dynamic SQL.
-- Comments:
-- - Parameters in dynamic SQL help prevent SQL injection.
-- - Meaningful variable names enhance code readability.

DECLARE @DepartmentID INT = 2;
DECLARE @DynamicSQL NVARCHAR(MAX);
SET @DynamicSQL = 'SELECT * FROM dbo.Employees WHERE DepartmentID = ' + CAST(@DepartmentID AS NVARCHAR);
EXEC sp_executesql @DynamicSQL;

-- Query 4: Avoid Using SELECT * in Production Queries
-- Retrieves only necessary columns from the 'Employees' table.
-- Comments:
-- - Explicitly specifying columns improves query performance.
-- - Selecting only required columns reduces data transfer overhead.

SELECT
    EmployeeID,
    FirstName,
    LastName
FROM
    dbo.Employees;

-- Query 5: Include a Comment Header in Stored Procedures
-- Stored Procedure: dbo.GetHighSalaryEmployees
-- Description: Retrieves employees with a salary greater than a specified threshold.
-- Comments:
-- - Meaningful stored procedure names provide clear intent.
-- - Comment headers enhance documentation for future maintainers.

CREATE PROCEDURE dbo.GetHighSalaryEmployees
    @SalaryThreshold DECIMAL(10, 2)
AS
BEGIN
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        Salary
    FROM
        dbo.Employees
    WHERE
        Salary > @SalaryThreshold;
END;

-- Query 6: Use Transactions for Data Modifications
-- Updates the salary of an employee in a transaction.
-- Comments:
-- - Encapsulating updates in a transaction ensures data integrity.
-- - Proper indentation enhances code readability.

BEGIN TRANSACTION;
UPDATE dbo.Employees SET Salary = 70000 WHERE EmployeeID = 1;
COMMIT TRANSACTION;

-- Query 7: Regularly Back Up the Database
-- Initiates a manual backup of the database.
-- Comments:
-- - Regular backups are crucial for data recovery and integrity.
-- - Comments provide guidance on the purpose of the backup operation.

BACKUP DATABASE YourDatabaseName TO DISK = 'C:\YourBackupPath\YourDatabaseName.bak' WITH INIT;

-- Query 8: Utilize JOIN Conditions for Clear Relationships
-- Retrieves customers along with their orders using explicit JOIN conditions.
-- Comments:
-- - Explicit JOIN conditions improve query readability.
-- - Descriptive aliases enhance understanding of table relationships.

SELECT
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate
FROM
    dbo.Customers AS c
JOIN
    dbo.Orders AS o ON c.CustomerID = o.CustomerID;

-- Query 9: Use CASE Statements for Conditional Logic
-- Classifies employees based on their salary level.
-- Comments:
-- - CASE statements provide a concise way to express conditional logic.
-- - Descriptive column aliases improve result set clarity.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    CASE
        WHEN Salary > 80000 THEN 'High Salary'
        WHEN Salary > 50000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS SalaryLevel
FROM
    dbo.Employees;

-- Query 10: Employ Proper Indexing for Faster Retrieval
-- Retrieves employees in a specific department using an indexed column.
-- Comments:
-- - Creating an index on DepartmentID improves query performance.
-- - Indexing helps accelerate data retrieval operations.

CREATE INDEX idx_EmployeeDepartmentID ON dbo.Employees(DepartmentID);
SELECT
    EmployeeID,
    FirstName,
    LastName
FROM
    dbo.Employees
WHERE
    DepartmentID = 3;

-- End of Script
