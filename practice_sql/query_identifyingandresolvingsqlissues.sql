/*********************************************
  Script: query_identifyingandresolvingsqlissues.sql
  Description: Queries demonstrating identification and resolution of performance issues in SQL.
**********************************************/

-- Create Tables

-- Table: Employees
CREATE TABLE IF NOT EXISTS dbo.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2),
    DepartmentID INT REFERENCES dbo.Departments(DepartmentID),
    ManagerID INT REFERENCES dbo.Managers(ManagerID)
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
    CustomerID INT REFERENCES dbo.Customers(CustomerID)
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
    CategoryID INT REFERENCES dbo.Categories(CategoryID),
    SupplierID INT REFERENCES dbo.Suppliers(SupplierID)
);

-- Table: Categories
CREATE TABLE IF NOT EXISTS dbo.Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(255)
);

-- Table: Suppliers
CREATE TABLE IF NOT EXISTS dbo.Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName NVARCHAR(255),
    ContactNumber NVARCHAR(20)
);

-- Table: Managers
CREATE TABLE IF NOT EXISTS dbo.Managers (
    ManagerID INT PRIMARY KEY,
    ManagerName NVARCHAR(255)
);

-- Table: EmployeeProjects
CREATE TABLE IF NOT EXISTS dbo.EmployeeProjects (
    EmployeeID INT REFERENCES dbo.Employees(EmployeeID),
    ProjectID INT REFERENCES dbo.Projects(ProjectID),
    PRIMARY KEY (EmployeeID, ProjectID)
);

-- Table: Projects
CREATE TABLE IF NOT EXISTS dbo.Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName NVARCHAR(255)
);

-- End of Table Creation

-- Query 1: Use Index Hints
-- Retrieves employee details for a specific department using an index hint.
-- Comments:
-- - Index hints guide the query optimizer to use a specific index.
-- - Helps in cases where the optimizer might choose a less optimal plan.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM
    dbo.Employees WITH(INDEX(idx_DepartmentID))
WHERE
    DepartmentID = 1;

-- Query 2: Optimize JOIN Operations
-- Retrieves orders along with customer details using INNER JOIN.
-- Comments:
-- - INNER JOIN is often faster than LEFT JOIN when all records are needed.
-- - Proper indexing on JOIN columns improves performance.

SELECT
    o.OrderID,
    o.OrderDate,
    c.CustomerName
FROM
    dbo.Orders AS o
JOIN
    dbo.Customers AS c ON o.CustomerID = c.CustomerID;

-- Query 3: Limit Result Set Size
-- Retrieves a limited number of rows for paginated results.
-- Comments:
-- - Use of OFFSET-FETCH limits the number of rows retrieved.
-- - Reduces the amount of data transferred and processed.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM
    dbo.Employees
ORDER BY
    Salary DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

-- Query 4: Avoid Using DISTINCT Unnecessarily
-- Retrieves unique department names without using DISTINCT.
-- Comments:
-- - Using DISTINCT can be resource-intensive; consider alternatives.
-- - GROUP BY can be more efficient for aggregating unique values.

SELECT
    DepartmentName
FROM
    dbo.Departments
GROUP BY
    DepartmentName;

-- Query 5: Utilize Stored Procedures
-- Executes a parameterized query using a stored procedure.
-- Comments:
-- - Stored procedures can be precompiled for improved execution.
-- - Parameterized queries avoid SQL injection and improve plan reuse.

CREATE PROCEDURE dbo.GetEmployeeByDepartment
    @DepartmentID INT
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
        DepartmentID = @DepartmentID;
END;

-- Query 6: Review Execution Plan
-- Evaluates the execution plan for a complex query.
-- Comments:
-- - Understanding and optimizing the execution plan is crucial.
-- - Use tools like SQL Server Management Studio to analyze plans.

SET STATISTICS IO, TIME ON;
SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName
FROM
    dbo.Products AS p
JOIN
    dbo.Categories AS c ON p.CategoryID = c.CategoryID;
SET STATISTICS IO, TIME OFF;

-- Query 7: Consider Covering Indexes
-- Retrieves order details with specific columns covered by an index.
-- Comments:
-- - Covering indexes can satisfy a query without accessing the base table.
-- - Reduces I/O and improves performance.

CREATE INDEX idx_OrderDate_Covering ON dbo.Orders(OrderDate) INCLUDE (CustomerID);
SELECT
    OrderID,
    OrderDate
FROM
    dbo.Orders
WHERE
    OrderDate >= '2023-01-01';

-- Query 8: Use UNION ALL Instead of UNION
-- Combines results of two SELECT statements using UNION ALL.
-- Comments:
-- - UNION ALL is faster than UNION as it does not remove duplicates.
-- - Use UNION only when duplicates need to be eliminated.

SELECT
    EmployeeID,
    FirstName,
    LastName
FROM
    dbo.Employees
WHERE
    DepartmentID = 1
UNION ALL
SELECT
    EmployeeID,
    FirstName,
    LastName
FROM
    dbo.Employees
WHERE
    DepartmentID = 2;

-- Query 9: Optimize Subqueries
-- Retrieves products with prices higher than the average price.
-- Comments:
-- - Correlated subqueries can be inefficient; consider alternatives.
-- - Using JOINs and GROUP BY can offer better performance.

SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM
    dbo.Products p
WHERE
    UnitPrice > (SELECT AVG(UnitPrice) FROM dbo.Products);

-- Query 10: Monitor and Analyze Server Performance
-- Reviews server-level performance metrics and waits.
-- Comments:
-- - Monitoring tools like SQL Server Profiler provide insights.
-- - Identifying and resolving server-level issues is essential.

-- Run server-level performance monitoring tools.

-- End of Script
