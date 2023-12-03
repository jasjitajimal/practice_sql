/*********************************************
  Script: query_indexiningstrategyforoptimization.sql
  Description: Queries demonstrating indexing strategies for optimization in SQL.
**********************************************/

-- Create Tables

-- Table: Employees
CREATE TABLE IF NOT EXISTS dbo.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    INDEX idx_DepartmentID (DepartmentID) -- Index on DepartmentID for Query 1
);

-- Table: Departments
CREATE TABLE IF NOT EXISTS dbo.Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(255)
);

-- Table: Orders
CREATE TABLE IF NOT EXISTS dbo.Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    INDEX idx_OrderDate (OrderDate) INCLUDE (CustomerID) -- Covering Index for Query 7
);

-- Table: Customers
CREATE TABLE IF NOT EXISTS dbo.Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(255),
    ContactNumber NVARCHAR(20)
);

-- Table: Products
CREATE TABLE IF NOT EXISTS dbo.Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(255),
    UnitPrice DECIMAL(10, 2),
    CategoryID INT,
    INDEX idx_CategoryID_UnitPrice (CategoryID, UnitPrice) -- Composite Index for Query 6
);

-- Table: Categories
CREATE TABLE IF NOT EXISTS dbo.Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(255)
);

-- End of Table Creation

-- Query 1: Index on WHERE Clause Column
-- Retrieves employees for a specific department using an index.
-- Comments:
-- - Indexing the WHERE clause column improves SELECT performance.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM
    dbo.Employees
WHERE
    DepartmentID = 1;

-- Query 2: Index on JOIN Operation
-- Retrieves orders along with customer details using indexed JOIN.
-- Comments:
-- - Indexing columns used in JOIN operations improves JOIN performance.

SELECT
    o.OrderID,
    o.OrderDate,
    c.CustomerName
FROM
    dbo.Orders AS o
JOIN
    dbo.Customers AS c ON o.CustomerID = c.CustomerID;

-- Query 3: Index on ORDER BY Clause
-- Retrieves employees sorted by salary using an index.
-- Comments:
-- - Indexing columns used in ORDER BY improves sorting performance.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM
    dbo.Employees
ORDER BY
    Salary DESC;

-- Query 4: Index on GROUP BY and Aggregation
-- Retrieves average unit prices for each category using an index.
-- Comments:
-- - Indexing columns used in GROUP BY and aggregate functions improves performance.

SELECT
    CategoryID,
    AVG(UnitPrice) AS AvgUnitPrice
FROM
    dbo.Products
GROUP BY
    CategoryID;

-- Query 5: Index on WHERE and ORDER BY
-- Retrieves products with a specific category and sorted by unit price using an index.
-- Comments:
-- - Indexing columns used in WHERE and ORDER BY improves both filtering and sorting performance.

SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM
    dbo.Products
WHERE
    CategoryID = 1
ORDER BY
    UnitPrice DESC;

-- Query 6: Composite Index
-- Retrieves products for a specific category and unit price range using a composite index.
-- Comments:
-- - Composite indexes cover multiple columns and improve performance for specific queries.

SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM
    dbo.Products
WHERE
    CategoryID = 2
    AND UnitPrice BETWEEN 10 AND 50;

-- Query 7: Covering Index
-- Retrieves orders with specific order dates along with customer IDs using a covering index.
-- Comments:
-- - Covering indexes include all columns needed for the query, eliminating the need to access the base table.

SELECT
    OrderID,
    OrderDate
FROM
    dbo.Orders
WHERE
    OrderDate >= '2023-01-01';

-- Query 8: Index on Multiple Columns
-- Retrieves projects for a specific department and manager using an index on multiple columns.
-- Comments:
-- - Indexing multiple columns together can improve performance for queries with complex conditions.

SELECT
    p.ProjectID,
    p.ProjectName
FROM
    dbo.Projects AS p
JOIN
    dbo.EmployeeProjects AS ep ON p.ProjectID = ep.ProjectID
WHERE
    ep.EmployeeID IN (SELECT EmployeeID FROM dbo.Employees WHERE DepartmentID = 1)
    AND ep.EmployeeID IN (SELECT ManagerID FROM dbo.Managers WHERE ManagerName = 'John Doe');

-- Query 9: Index on DISTINCT
-- Retrieves unique department names using an index on the DISTINCT column.
-- Comments:
-- - Indexing columns used in DISTINCT can improve performance.

SELECT DISTINCT
    DepartmentName
FROM
    dbo.Departments;

-- Query 10: Index on Subquery
-- Retrieves employees based on a subquery filtering by manager ID using an index.
-- Comments:
-- - Indexing columns used in subqueries improves performance for correlated subqueries.

SELECT
    EmployeeID,
    FirstName,
    LastName
FROM
    dbo.Employees
WHERE
    ManagerID IN (SELECT ManagerID FROM dbo.Managers WHERE ManagerName = 'Jane Smith');

-- End of Script
