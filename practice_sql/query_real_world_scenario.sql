/*********************************************
  SQL Server Script: queries_real_world_scenario.sql
  Description: Queries applying SQL to real-world scenarios.
**********************************************/

-- Create Tables for Real-World Scenario

-- Table: Employees
CREATE TABLE IF NOT EXISTS dbo.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE,
    DepartmentID INT REFERENCES dbo.Departments(DepartmentID),
    Salary DECIMAL(10, 2)
);

-- Table: Departments
CREATE TABLE IF NOT EXISTS dbo.Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(255)
);

-- End of Table Creation

-- Scenario 1: Retrieve Employee Details with Department Name

-- Comments:
-- - Joining Employees and Departments tables to get employee details with department names.
-- - Provides a comprehensive view of employee information.

SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.BirthDate,
    e.Salary,
    d.DepartmentName
FROM
    dbo.Employees e
JOIN
    dbo.Departments d ON e.DepartmentID = d.DepartmentID;

-- Scenario 2: Calculate Average Salary per Department

-- Comments:
-- - Utilizing GROUP BY and AVG to calculate the average salary for each department.
-- - Gives insights into department-wise salary distribution.

SELECT
    d.DepartmentName,
    AVG(e.Salary) AS AverageSalary
FROM
    dbo.Employees e
JOIN
    dbo.Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY
    d.DepartmentName;

-- Scenario 3: Identify High Earners in Each Department

-- Comments:
-- - Using ROW_NUMBER() OVER(PARTITION BY) to rank employees based on salary within each department.
-- - Allows identifying high earners within each department.

WITH RankedEmployees AS (
    SELECT
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.Salary,
        d.DepartmentName,
        ROW_NUMBER() OVER(PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS RankWithinDepartment
    FROM
        dbo.Employees e
    JOIN
        dbo.Departments d ON e.DepartmentID = d.DepartmentID
)
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentName
FROM
    RankedEmployees
WHERE
    RankWithinDepartment = 1;

-- Scenario 4: Calculate Age of Employees

-- Comments:
-- - Using DATEDIFF to calculate the age of employees based on their birthdate.
-- - Provides information about the age distribution of the workforce.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    BirthDate,
    DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
FROM
    dbo.Employees;

-- Scenario 5: Find Departments with No Employees

-- Comments:
-- - Utilizing LEFT JOIN and IS NULL to identify departments with no employees.
-- - Helpful in managing department resources.

SELECT
    d.DepartmentID,
    d.DepartmentName
FROM
    dbo.Departments d
LEFT JOIN
    dbo.Employees e ON d.DepartmentID = e.DepartmentID
WHERE
    e.EmployeeID IS NULL;

-- Scenario 6: Update Salary Based on Performance

-- Comments:
-- - Applying an UPDATE statement to adjust salaries based on employee performance.
-- - Mimics a scenario where salary adjustments are made.

UPDATE
    dbo.Employees
SET
    Salary = Salary * 1.1 -- 10% salary increase
WHERE
    EmployeeID IN (1, 2, 3); -- Employee IDs selected for performance-based increase.

-- Scenario 7: Add New Employee to a Department

-- Comments:
-- - INSERT INTO statement to add a new employee to a specific department.
-- - Demonstrates the process of onboarding new employees.

INSERT INTO
    dbo.Employees (EmployeeID, FirstName, LastName, BirthDate, DepartmentID, Salary)
VALUES
    (1001, 'John', 'Doe', '1990-05-15', 1, 60000.00);

-- Scenario 8: Remove Employee from the Database

-- Comments:
-- - DELETE statement to remove an employee from the database.
-- - Simulates the process of employee termination.

DELETE FROM
    dbo.Employees
WHERE
    EmployeeID = 1001;

-- Scenario 9: Identify Employees with Long Tenure

-- Comments:
-- - Using DATEDIFF to calculate the tenure of employees based on their hire date.
-- - Helps in recognizing employees with long service.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService
FROM
    dbo.Employees;

-- Scenario 10: Find Employees with Similar Salaries

-- Comments:
-- - Applying CROSS APPLY to identify employees with similar salaries.
-- - Useful for finding peers or potential salary benchmarks.

SELECT
    e1.EmployeeID AS EmployeeID1,
    e1.FirstName AS FirstName1,
    e1.LastName AS LastName1,
    e1.Salary AS Salary1,
    e2.EmployeeID AS EmployeeID2,
    e2.FirstName AS FirstName2,
    e2.LastName AS LastName2,
    e2.Salary AS Salary2
FROM
    dbo.Employees e1
CROSS APPLY
    dbo.Employees e2
WHERE
    e1.EmployeeID < e2.EmployeeID
    AND ABS(e1.Salary - e2.Salary) < 5000; -- Similarity threshold of 5000

-- End of Script
