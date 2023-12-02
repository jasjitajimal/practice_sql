/*********************************************
  SQL Server Script:query_nullvalues.sql
  Description: Example script demonstrating handling of null values in SQL.
  Handling null values in SQL is crucial for managing missing or unknown data.
**********************************************/

-- Create a table with nullable columns
CREATE TABLE IF NOT EXISTS employee (
    employee_id INT PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10, 2)
);

-- Insert data with some null values
INSERT INTO employee VALUES
    (1, 'John', 'Doe', '2022-01-01', 50000.00),
    (2, 'Jane', 'Smith', NULL, 60000.00),
    (3, 'Bob', NULL, '2022-02-15', 55000.00),
    (4, 'Alice', 'Johnson', '2022-03-01', NULL);

-- Comments on Table Structure and Data
-- employee: Table with nullable columns, demonstrating null values.
--   Columns: employee_id (INT), first_name (NVARCHAR(50)), last_name (NVARCHAR(50)),
--            hire_date (DATE), salary (DECIMAL(10, 2)).

-- Show the original data
SELECT * FROM employee;

-- Comments on Select Statement
-- Displaying the original data in the employee table.

-- Example 1: Handling nulls in SELECT statements
SELECT
    employee_id,
    -- COALESCE function to replace null with a default value
    COALESCE(first_name, 'N/A') AS first_name,
    ISNULL(last_name, 'Unknown') AS last_name,
    -- Using NULLIF to replace values with null
    NULLIF(hire_date, '2022-01-01') AS adjusted_hire_date,
    -- Using ISNULL to replace null with a default value
    ISNULL(salary, 0) AS adjusted_salary
FROM employee;

-- Comments on Example 1
-- Handling null values in SELECT statements using COALESCE, ISNULL, and NULLIF functions.

-- Example 2: Filtering and handling nulls in WHERE clause
SELECT
    employee_id,
    first_name,
    last_name,
    hire_date,
    salary
FROM employee
-- Using IS NULL and IS NOT NULL in WHERE clause
WHERE last_name IS NULL OR salary IS NOT NULL;

-- Comments on Example 2
-- Filtering and handling nulls in WHERE clause using IS NULL and IS NOT NULL.

-- Example 3: Handling nulls in aggregate functions
-- Using ISNULL to replace nulls before aggregation
SELECT
    AVG(ISNULL(salary, 0)) AS average_salary,
    COUNT(employee_id) AS total_employees
FROM employee;

-- Comments on Example 3
-- Handling null values in aggregate functions using ISNULL.

-- Example 4: Updating null values
-- Setting default values for null columns
UPDATE employee
SET
    first_name = ISNULL(first_name, 'Unknown'),
    last_name = ISNULL(last_name, 'Unknown'),
    hire_date = ISNULL(hire_date, '2022-01-01'),
    salary = ISNULL(salary, 0);

-- Show the updated data
SELECT * FROM employee;

-- Comments on Example 4
-- Updating null values with default values using ISNULL.

-- End of Script
