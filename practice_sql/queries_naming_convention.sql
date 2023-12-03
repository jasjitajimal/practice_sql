/*********************************************
  SQL Server Script: queries_naming_convention.sql
  Description: Demonstrates appropriate naming conventions in SQL.
**********************************************/
-- Create Tables

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



-- Query 1: Use Meaningful Table Names
-- Retrieves product details along with their categories.
-- Comments:
-- - The table name 'Products' clearly represents the entity it holds.
-- - Descriptive column names enhance understanding.

SELECT
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    c.CategoryName
FROM
    dbo.Products AS p
JOIN
    dbo.Categories AS c ON p.CategoryID = c.CategoryID;

-- Query 2: Use CamelCase for Table Columns
-- Retrieves employee details along with their departments.
-- Comments:
-- - CamelCase for column names improves visual separation and consistency.
-- - Meaningful aliases enhance query readability.

SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary,
    d.DepartmentName
FROM
    dbo.Employees AS e
JOIN
    dbo.Departments AS d ON e.DepartmentID = d.DepartmentID;

-- Query 3: Prefix Primary Key Columns
-- Retrieves order details along with customer information.
-- Comments:
-- - The 'OrderID' column is prefixed to clearly identify it as the primary key.
-- - Prefixing helps avoid ambiguity in column names.

SELECT
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    c.ContactNumber
FROM
    dbo.Orders AS o
JOIN
    dbo.Customers AS c ON o.CustomerID = c.CustomerID;

-- Query 4: Use Singular Nouns for Table Names
-- Retrieves details of a single employee based on EmployeeID.
-- Comments:
-- - Table name 'Employee' is a singular noun representing a single entity.
-- - Singular nouns provide clarity in naming.

SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary
FROM
    dbo.Employee AS e
WHERE
    e.EmployeeID = 1;

-- Query 5: Avoid Abbreviations in Table Names
-- Retrieves details of customers along with their orders.
-- Comments:
-- - Avoiding abbreviations enhances readability for future maintainers.
-- - Clear and complete words contribute to better understanding.

SELECT
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate
FROM
    dbo.Customers AS c
JOIN
    dbo.Orders AS o ON c.CustomerID = o.CustomerID;

-- Query 6: Use Plural Nouns for Table Names
-- Retrieves details of products along with their suppliers.
-- Comments:
-- - Table name 'Products' uses a plural noun for better representation.
-- - Plural nouns indicate a collection of entities.

SELECT
    p.ProductID,
    p.ProductName,
    s.SupplierName,
    s.ContactNumber
FROM
    dbo.Products AS p
JOIN
    dbo.Suppliers AS s ON p.SupplierID = s.SupplierID;

-- Query 7: Prefix Foreign Key Columns
-- Retrieves details of employees along with their managers.
-- Comments:
-- - The 'ManagerID' column is prefixed to indicate it is a foreign key.
-- - Prefixing improves clarity in relationships.

SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    m.ManagerID,
    m.ManagerName
FROM
    dbo.Employees AS e
LEFT JOIN
    dbo.Managers AS m ON e.ManagerID = m.ManagerID;

-- Query 8: Use Verb-Noun for Stored Procedures
-- Stored Procedure: GetHighSalaryEmployees
-- Description: Retrieves employees with a salary greater than a specified threshold.
-- Comments:
-- - Naming follows the Verb-Noun convention for stored procedures.
-- - Descriptive names improve the purpose clarity.

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

-- Query 9: Use Consistent Casing
-- Retrieves customer details along with their orders.
-- Comments:
-- - Consistent casing (lowercase) for table and column names improves uniformity.
-- - Uniformity aids in code maintenance.

SELECT
    c.customerid,
    c.customername,
    o.orderid,
    o.orderdate
FROM
    dbo.customers AS c
JOIN
    dbo.orders AS o ON c.customerid = o.customerid;

-- Query 10: Avoid Underscores in Table and Column Names
-- Retrieves employee details along with their assigned projects.
-- Comments:
-- - Avoiding underscores contributes to a clean and consistent naming style.
-- - Consistency enhances overall code aesthetics.

SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    p.ProjectName
FROM
    dbo.Employees AS e
JOIN
    dbo.EmployeeProjects AS ep ON e.EmployeeID = ep.EmployeeID
JOIN
    dbo.Projects AS p ON ep.ProjectID = p.ProjectID;

-- End of Script
