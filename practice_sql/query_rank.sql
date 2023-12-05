/*********************************************
  Script: query_rank.sql
  Description: Queries demonstrating the use of Window Rank functions in SQL.
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

-- Insert Data

-- Insert into Departments
INSERT INTO dbo.Departments (DepartmentID, DepartmentName)
VALUES
    (1, 'HR'),
    (2, 'IT'),
    (3, 'Finance');

-- Insert into Employees
INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID)
VALUES
    (1, 'John', 'Doe', 60000, 1),
    (2, 'Jane', 'Smith', 75000, 1),
    (3, 'Bob', 'Johnson', 80000, 2),
    (4, 'Alice', 'Williams', 70000, 2),
    (5, 'Charlie', 'Brown', 90000, 3),
    (6, 'David', 'Jones', 95000, 3);

-- End of Data Insertion

-- Query 1: Rank Employees by Salary
-- Ranks employees based on salary in descending order.
-- Comments:
-- - RANK() is used to assign a rank to each row in the result set.
-- - PARTITION BY is used to restart the rank for each department.
-- - ORDER BY determines the ranking order.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
FROM
    dbo.Employees;

-- Query 2: Dense Rank Employees by Salary
-- Densely ranks employees based on salary in descending order.
-- Comments:
-- - DENSE_RANK() is used for dense ranking, where tied values receive the same rank.
-- - PARTITION BY and ORDER BY determine the ranking order.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS DenseSalaryRank
FROM
    dbo.Employees;

-- Query 3: Row Number for Each Employee
-- Assigns a unique row number to each employee.
-- Comments:
-- - ROW_NUMBER() is used for generating a unique row number for each row.
-- - PARTITION BY is optional and used to restart numbering for each department.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RowNumber
FROM
    dbo.Employees;

-- Query 4: Rank Employees within Each Department Alphabetically
-- Ranks employees within each department alphabetically by last name.
-- Comments:
-- - RANK() is used to assign a rank to each row based on alphabetical order.
-- - PARTITION BY is used to restart the rank for each department.
-- - ORDER BY determines the ranking order.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    RANK() OVER (PARTITION BY DepartmentID ORDER BY LastName, FirstName) AS AlphabeticalRank
FROM
    dbo.Employees;

-- Query 5: Dense Rank Employees by Salary with Ties
-- Densely ranks employees based on salary in descending order, handling ties.
-- Comments:
-- - DENSE_RANK() is used for dense ranking, handling tied values.
-- - PARTITION BY and ORDER BY determine the ranking order.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseGlobalSalaryRank
FROM
    dbo.Employees;

-- Query 6: Row Number for Each Employee with Global Order
-- Assigns a unique row number to each employee without partitioning.
-- Comments:
-- - ROW_NUMBER() is used for generating a unique row number without partitioning.
-- - ORDER BY determines the global ranking order.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS GlobalRowNumber
FROM
    dbo.Employees;

-- Query 7: Rank Employees by Salary and Include Ties
-- Ranks employees based on salary, including ties (equal values).
-- Comments:
-- - RANK() is used to assign a rank to each row.
-- - PARTITION BY is optional; ORDER BY determines the ranking order.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS GlobalSalaryRank
FROM
    dbo.Employees;

-- Query 8: Use of NTILE for Quartiles
-- Divides employees into quartiles based on salary.
-- Comments:
-- - NTILE() is used to divide the result set into specified numbers of groups.
-- - In this case, it divides employees into quartiles.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    NTILE(4) OVER (ORDER BY Salary DESC) AS Quartile
FROM
    dbo.Employees;

-- Query 9: Calculate Running Total of Salaries
-- Computes the running total of salaries within each department.
-- Comments:
-- - SUM() as a window function is used to calculate the running total.
-- - PARTITION BY is used to restart the total for each department.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    SUM(Salary) OVER (PARTITION BY DepartmentID ORDER BY EmployeeID) AS RunningTotal
FROM
    dbo.Employees;

-- Query 10: Use of FIRST_VALUE and LAST_VALUE
-- Retrieves the first and last salary within each department.
-- Comments:
-- - FIRST_VALUE() and LAST_VALUE() retrieve the first and last values in the window.
-- - PARTITION BY determines the grouping.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    FIRST_VALUE(Salary) OVER (PARTITION BY DepartmentID ORDER BY EmployeeID) AS FirstSalary,
    LAST_VALUE(Salary) OVER (PARTITION BY DepartmentID ORDER BY EmployeeID) AS LastSalary
FROM
    dbo.Employees;

-- End of Script
