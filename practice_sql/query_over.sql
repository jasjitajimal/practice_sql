/*********************************************
  Script: query_over.sql.sql
  Description: Queries demonstrating the use of window functions (OVER clause) in SQL.
**********************************************/

-- Table Creation

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

-- Sample Data Insertion
INSERT INTO dbo.Departments (DepartmentID, DepartmentName) VALUES (1, 'Sales');
INSERT INTO dbo.Departments (DepartmentID, DepartmentName) VALUES (2, 'Marketing');

INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID) VALUES (1, 'John', 'Doe', 50000, 1);
INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID) VALUES (2, 'Jane', 'Smith', 60000, 1);
INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID) VALUES (3, 'Bob', 'Johnson', 55000, 2);
INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID) VALUES (4, 'Alice', 'Williams', 62000, 2);

-- End of Table Creation and Data Insertion

-- Query 1: Calculate Average Salary per Department
-- Retrieves employee details along with the average salary per department.
-- Comments:
-- - The AVG() window function is used with the OVER clause to calculate the average salary per department.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    AVG(Salary) OVER (PARTITION BY DepartmentID) AS AvgSalaryPerDepartment
FROM
    dbo.Employees;

-- Query 2: Rank Employees by Salary within Each Department
-- Ranks employees based on salary within each department.
-- Comments:
-- - The RANK() window function is used with the OVER clause to assign ranks within each department.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
FROM
    dbo.Employees;

-- Query 3: Calculate Running Total of Salaries
-- Computes the running total of salaries sorted by employee ID.
-- Comments:
-- - The SUM() window function is used with the OVER clause to calculate the running total of salaries.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    SUM(Salary) OVER (ORDER BY EmployeeID) AS RunningTotalSalary
FROM
    dbo.Employees;

-- Query 4: Identify Employees with Highest Salary in Each Department
-- Retrieves employees with the highest salary within each department.
-- Comments:
-- - The ROW_NUMBER() window function is used with the OVER clause to assign row numbers based on salary within each department.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID
FROM (
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

-- Query 5: Calculate Percentage of Total Salary
-- Computes the percentage of total salary each employee contributes.
-- Comments:
-- - The salary percentage is calculated using the SUM() window function with the OVER clause.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    Salary / SUM(Salary) OVER () * 100 AS SalaryPercentageOfTotal
FROM
    dbo.Employees;

-- Query 6: Determine Employee with the Nth Highest Salary
-- Finds the employee with the Nth highest salary.
-- Comments:
-- - The NTILE() window function is used with the OVER clause to divide the result set into equal parts.

DECLARE @N INT = 2; -- Change N as needed
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID
FROM (
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        Salary,
        DepartmentID,
        NTILE(@N) OVER (ORDER BY Salary DESC) AS SalaryNtile
    FROM
        dbo.Employees
) AS NtileRankedEmployees
WHERE
    SalaryNtile = 1;

-- Query 7: Calculate Difference in Salary from Previous Employee
-- Computes the salary difference from the previous employee within each department.
-- Comments:
-- - The LAG() window function is used with the OVER clause to access the value of the previous row.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    Salary - LAG(Salary) OVER (PARTITION BY DepartmentID ORDER BY EmployeeID) AS SalaryDifferenceFromPrev
FROM
    dbo.Employees;

-- Query 8: Calculate Moving Average of Salary
-- Computes the moving average of salary using a window of three employees.
-- Comments:
-- - The AVG() window function is used with the OVER clause and a window frame to calculate the moving average.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    AVG(Salary) OVER (PARTITION BY DepartmentID ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvgSalary
FROM
    dbo.Employees;

-- Query 9: Calculate Cumulative Count of Employees by Department
-- Computes the cumulative count of employees within each department.
-- Comments:
-- - The COUNT() window function is used with the OVER clause and an unbounded window frame.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID,
    COUNT(EmployeeID) OVER (PARTITION BY DepartmentID ORDER BY EmployeeID ROWS UNBOUNDED PRECEDING) AS CumulativeEmployeeCount
FROM
    dbo.Employees;

-- Query 10: Determine the Employee with the Highest Salary Relative to Department Average
-- Identifies employees with a salary higher than the department average.
-- Comments:
-- - The salary comparison with the department average is achieved using the AVG() window function with the OVER clause.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentID
FROM (
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        Salary,
        DepartmentID,
        AVG(Salary) OVER (PARTITION BY DepartmentID) AS DepartmentAvgSalary
    FROM
        dbo.Employees
) AS EmployeesWithAvg
WHERE
    Salary > DepartmentAvgSalary;

-- End of Script
