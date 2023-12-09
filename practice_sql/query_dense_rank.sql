/*********************************************
  Script: queries_dense_rank.sql
  Description: Queries demonstrating usage of the Windows DENSE_RANK() function in SQL.
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

-- Insert Sample Data

INSERT INTO dbo.Departments VALUES (1, 'HR');
INSERT INTO dbo.Departments VALUES (2, 'Finance');
INSERT INTO dbo.Departments VALUES (3, 'IT');

INSERT INTO dbo.Employees VALUES (1, 'John', 'Doe', 50000, 1);
INSERT INTO dbo.Employees VALUES (2, 'Jane', 'Smith', 60000, 1);
INSERT INTO dbo.Employees VALUES (3, 'Bob', 'Johnson', 55000, 2);
INSERT INTO dbo.Employees VALUES (4, 'Alice', 'Williams', 70000, 2);
INSERT INTO dbo.Employees VALUES (5, 'Charlie', 'Brown', 60000, 3);
INSERT INTO dbo.Employees VALUES (6, 'Diana', 'Miller', 65000, 3);

-- Queries

-- Query 1: Dense Rank within Each Department based on Salary
-- Retrieves employees with dense rank within each department based on salary.


-- Comments:
-- - PARTITION BY clause divides the result set into partitions.
-- - DENSE_RANK() assigns a unique rank to each distinct salary within each partition.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS DenseRankInDepartment
FROM
    dbo.Employees;

-- Query 2: Dense Rank for All Employees based on Salary
-- Retrieves employees with dense rank based on salary across all departments.
-- Comments:
-- - PARTITION BY is not used, so the dense rank is computed across all employees.
-- - DENSE_RANK() assigns a unique rank to each distinct salary across all employees.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankOverall
FROM
    dbo.Employees;

-- Query 3: Dense Rank within Each Department based on Salary (Ascending Order)
-- Retrieves employees with dense rank within each department based on salary in ascending order.
-- Comments:
-- - DENSE_RANK() is used with ascending order (default is descending).
-- - PARTITION BY clause divides the result set into partitions.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary) AS DenseRankInDepartmentAsc
FROM
    dbo.Employees;

-- Query 4: Dense Rank for All Employees based on Salary (Ascending Order)
-- Retrieves employees with dense rank based on salary across all departments in ascending order.
-- Comments:
-- - DENSE_RANK() is used with ascending order (default is descending).
-- - PARTITION BY is not used, so the dense rank is computed across all employees.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary) AS DenseRankOverallAsc
FROM
    dbo.Employees;

-- Query 5: Dense Rank for Employees with Same Salary
-- Retrieves employees with the same salary and their dense rank.
-- Comments:
-- - DENSE_RANK() handles ties by assigning the same rank to tied values.
-- - PARTITION BY is not used, so the dense rank is computed across all employees.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary) AS DenseRankOverall
FROM
    dbo.Employees
WHERE
    Salary = 60000;

-- Query 6: Dense Rank for Employees with Same Salary within Each Department
-- Retrieves employees with the same salary and their dense rank within each department.
-- Comments:
-- - DENSE_RANK() handles ties by assigning the same rank to tied values.
-- - PARTITION BY divides the result set into partitions based on the department.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary) AS DenseRankInDepartment
FROM
    dbo.Employees
WHERE
    Salary = 60000;

-- Query 7: Dense Rank for Top N Employees
-- Retrieves the top 3 employees based on salary with their dense rank.
-- Comments:
-- - TOP N rows are selected based on salary in descending order.
-- - DENSE_RANK() assigns a unique rank to each distinct salary.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankTop3
FROM
    dbo.Employees
ORDER BY
    Salary DESC
FETCH NEXT 3 ROWS ONLY;

-- Query 8: Dense Rank for Bottom N Employees within Each Department
-- Retrieves the bottom 2 employees based on salary within each department with their dense rank.
-- Comments:
-- - Bottom N rows are selected based on salary in ascending order within each department.
-- - PARTITION BY divides the result set into partitions based on the department.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary ASC) AS DenseRankBottom2InDepartment
FROM
    dbo.Employees
ORDER BY
    Salary ASC
FETCH NEXT 2 ROWS ONLY;

-- Query 9: Dense Rank for Employees with Salary Greater Than Average
-- Retrieves employees with a salary greater than the average salary and their dense rank.
-- Comments:
-- - DENSE_RANK() is used to rank employees based on salary.
-- - A subquery calculates the average salary.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankAboveAverage
FROM
    dbo.Employees
WHERE
    Salary > (SELECT AVG(Salary) FROM dbo.Employees);

-- Query 10: Dense Rank for Employees with Unique Salaries
-- Retrieves employees with unique salaries and their dense rank.
-- Comments:
-- - DENSE_RANK() is used to rank employees based on salary.
-- - PARTITION BY is not used, so the dense rank is computed across all employees.

WITH UniqueSalaries AS (
    SELECT DISTINCT Salary
    FROM dbo.Employees
)
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankUniqueSalaries
FROM
    UniqueSalaries;

-- File Documentation
-- This script demonstrates the usage of the DENSE_RANK() function in various scenarios.
-- Each query showcases different aspects such as partitioning, ordering, and handling ties.
-- The queries are designed to illustrate the flexibility and power of the DENSE_RANK() window function.

-- End of Script
