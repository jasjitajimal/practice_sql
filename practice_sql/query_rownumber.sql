/*********************************************
  Script: queries_rownumber.sql
  Description: Queries demonstrating the usage of the ROW_NUMBER() window function in SQL Server.
**********************************************/

-- Create Tables

-- Table: Employees
CREATE TABLE IF NOT EXISTS dbo.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2),
    DepartmentID INT REFERENCES dbo.Departments(DepartmentID)
);

-- Table: Departments
CREATE TABLE IF NOT EXISTS dbo.Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(255)
);

-- End of Table Creation

-- Insert Sample Data

-- Insert into Departments
INSERT INTO dbo.Departments (DepartmentID, DepartmentName) VALUES
    (1, 'HR'),
    (2, 'IT'),
    (3, 'Finance');

-- Insert into Employees
INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID) VALUES
    (1, 'John', 'Doe', 60000.00, 1),
    (2, 'Jane', 'Smith', 75000.00, 1),
    (3, 'Bob', 'Johnson', 80000.00, 2),
    (4, 'Alice', 'Williams', 90000.00, 2),
    (5, 'Charlie', 'Brown', 70000.00, 3),
    (6, 'David', 'Lee', 85000.00, 3);

-- End of Sample Data Insertion

-- Query 1: Basic Usage of ROW_NUMBER()
-- Assigns a unique row number to each employee based on their salary in descending order.
-- Comments:
-- - PARTITION BY is not used in this example.
-- - The ORDER BY clause defines the ranking criteria.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
FROM
    dbo.Employees;

-- Query 2: ROW_NUMBER() with PARTITION BY
-- Assigns a row number to each employee within their department based on salary in descending order.
-- Comments:
-- - PARTITION BY is used to restart the row numbering for each department.
-- - ORDER BY defines the ranking criteria within each partition.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RowNum
FROM
    dbo.Employees;

-- Query 3: Using ROW_NUMBER() with WHERE Clause
-- Retrieves the second highest salary employee in each department.
-- Comments:
-- - The WHERE clause filters the results based on the assigned row number.
-- - PARTITION BY is used for department-specific ranking.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RowNum
FROM
    dbo.Employees
WHERE
    RowNum = 2;

-- Query 4: ROW_NUMBER() in Subquery
-- Retrieves employees with the highest salary in each department.
-- Comments:
-- - The subquery is used to filter rows with the highest row number within each department.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID
FROM
    (
        SELECT
            EmployeeID,
            FirstName,
            LastName,
            Salary,
            DepartmentID,
            ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RowNum
        FROM
            dbo.Employees
    ) AS RankedEmployees
WHERE
    RowNum = 1;

-- Query 5: Using ROW_NUMBER() with JOIN
-- Retrieves employees and their manager, assigning a row number to each employee within their department.
-- Comments:
-- - The ROW_NUMBER() is used in combination with a self-join to get the manager-employee relationship.

SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary,
    e.DepartmentID,
    m.EmployeeID AS ManagerID,
    m.FirstName AS ManagerFirstName,
    m.LastName AS ManagerLastName,
    ROW_NUMBER() OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS RowNum
FROM
    dbo.Employees e
JOIN
    dbo.Employees m ON e.DepartmentID = m.DepartmentID AND e.EmployeeID <> m.EmployeeID
ORDER BY
    e.DepartmentID, RowNum;

-- Query 6: Using ROW_NUMBER() with Filtering
-- Retrieves employees with a salary greater than the average salary within their department.
-- Comments:
-- - The HAVING clause filters the results based on the assigned row number.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RowNum
FROM
    dbo.Employees
HAVING
    AVG(Salary) > 50000; -- Example filter condition

-- Query 7: ROW_NUMBER() with Date-Based Ranking
-- Assigns a unique row number to each order based on the order date.
-- Comments:
-- - ROW_NUMBER() can be used with date-based ordering.

SELECT
    OrderID,
    OrderDate,
    ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNum
FROM
    dbo.Orders;

-- Query 8: ROW_NUMBER() with Ties
-- Assigns row numbers to products with ties in prices.
-- Comments:
-- - ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW is used to handle ties.

SELECT
    ProductID,
    ProductName,
    UnitPrice,
    ROW_NUMBER() OVER (ORDER BY UnitPrice) AS RowNum
FROM
    dbo.Products;

-- Query 9: ROW_NUMBER() with Window Frame
-- Assigns row numbers to employees with salary within a specified range.
-- Comments:
-- - The window frame is used to define a range of rows for each row's ordering.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary RANGE BETWEEN 10000 PRECEDING AND 10000 FOLLOWING) AS RowNum
FROM
    dbo.Employees;

-- Query 10: ROW_NUMBER() with NULLs
-- Assigns row numbers to employees and treats NULL salaries as the lowest.
-- Comments:
-- - COALESCE is used to replace NULLs with a default value for ordering.

SELECT
    EmployeeID,
    FirstName,
    LastName
