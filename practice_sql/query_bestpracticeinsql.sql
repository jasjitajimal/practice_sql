/*********************************************
  Script: query_bestpracticeinsql.sql
  Description: Demonstrates best practices in SQL.
  a) Use Transactions for Data Modifications: Demonstrates the use of transactions.
  b) Avoid Using SELECT * in Production Queries: Explicitly specifies columns in the SELECT statement.
  c) Use Common Table Expressions (CTEs) for Complex Queries: Shows a CTE example.
  d) Use Table Aliases for Readability: Enhances the SELECT query with table aliases.
  e) Include a Comment Header in Stored Procedures: Adds a comment header for the stored procedure.
  f) Use Parameters in Dynamic SQL to Prevent SQL Injection: Shows a safe way to construct dynamic SQL.
  g) Regularly Back Up the Database: Provides a comment emphasizing the importance of database backups.
**********************************************/

-- Table creation with proper naming conventions
CREATE TABLE dbo.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    Salary DECIMAL(10, 2),
    DepartmentID INT, -- Foreign key references Departments.DepartmentID
    CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentID) REFERENCES dbo.Departments(DepartmentID)
);

-- Indexing for better query performance
CREATE INDEX idx_EmployeeLastName ON dbo.Employees(LastName);

-- Stored Procedure with a meaningful name and parameters
CREATE PROCEDURE dbo.GetEmployeeDetails
    @EmployeeID INT
AS
BEGIN
    SELECT *
    FROM dbo.Employees
    WHERE EmployeeID = @EmployeeID;
END;

-- Sample query with proper indentation and formatting
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary,
    d.DepartmentName
FROM
    dbo.Employees e
JOIN
    dbo.Departments d ON e.DepartmentID = d.DepartmentID
WHERE
    e.Salary > 50000
ORDER BY
    e.LastName ASC;

-- Commented section for data modification operations
/*
-- Inserting a new employee
INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, DateOfBirth, Salary, DepartmentID)
VALUES (1, 'John', 'Doe', '1990-01-01', 60000.00, 1);

-- Updating an employee's salary
UPDATE dbo.Employees
SET Salary = 65000.00
WHERE EmployeeID = 1;

-- Deleting an employee
DELETE FROM dbo.Employees
WHERE EmployeeID = 1;
*/

-- Best Practices Examples:

-- 1. Use Transactions for Data Modifications
BEGIN TRANSACTION;
-- (Perform data modifications here)
COMMIT TRANSACTION;

-- 2. Avoid Using SELECT * in Production Queries
SELECT EmployeeID, FirstName, LastName
FROM dbo.Employees;

-- 3. Use Common Table Expressions (CTEs) for Complex Queries
WITH HighSalaryEmployees AS (
    SELECT EmployeeID, FirstName, LastName
    FROM dbo.Employees
    WHERE Salary > 80000
)
SELECT * FROM HighSalaryEmployees;

-- 4. Use Table Aliases for Readability
SELECT e.EmployeeID, e.FirstName, e.LastName
FROM dbo.Employees e
JOIN dbo.Departments d ON e.DepartmentID = d.DepartmentID;

-- 5. Include a Comment Header in Stored Procedures
/*
   Stored Procedure: dbo.GetEmployeeDetails
   Description: Retrieves details of an employee based on EmployeeID.
   Parameters:
      - @EmployeeID: Employee ID to retrieve details for.
*/

-- 6. Use Parameters in Dynamic SQL to Prevent SQL Injection
DECLARE @DynamicSQL NVARCHAR(MAX);
DECLARE @DepartmentID INT = 2;
SET @DynamicSQL = 'SELECT * FROM dbo.Employees WHERE DepartmentID = ' + CAST(@DepartmentID AS NVARCHAR);
EXEC sp_executesql @DynamicSQL;

-- 7. Regularly Back Up the Database
BACKUP DATABASE YourDatabaseName TO DISK = 'C:\YourBackupPath\YourDatabaseName.bak' WITH INIT;

-- End of Script
