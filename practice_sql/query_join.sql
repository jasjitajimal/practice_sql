/*********************************************
  SQL File: query_join.sql
  Description: This file contains the SQL schema and sample data for a simple company database.
**********************************************/


/*************************************
  Table: employees
  Description: Stores information about employees.
*************************************/
CREATE TABLE employees (
    employee_id INT PRIMARY KEY, -- Unique identifier for each employee
    employee_name VARCHAR(50), -- Name of the employee
    department_id INT, -- Foreign key referencing departments table
    salary DECIMAL(10, 2), -- Salary of the employee
    hire_date DATE -- Date when the employee was hired
);

/*************************************
  Sample Data for employees Table
*************************************/
INSERT INTO employees (employee_id, employee_name, department_id, salary, hire_date) VALUES
(1, 'John Doe', 1, 60000.00, '2020-01-15'),
(2, 'Jane Smith', 2, 75000.00, '2019-05-20'),
(3, 'Bob Johnson', 1, 55000.00, '2021-02-10'),
(4, 'Alice Williams', 3, 80000.00, '2018-08-05'),
(5, 'Charlie Brown', 2, 70000.00, '2022-03-25');

/*************************************
  Table: departments
  Description: Stores information about different departments in the company.
*************************************/
CREATE TABLE departments (
    department_id INT PRIMARY KEY, -- Unique identifier for each department
    department_name VARCHAR(50) -- Name of the department
);

/*************************************
  Sample Data for departments Table
*************************************/
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

/*************************************
  SQL Queries: Joins
  Description: Demonstrates various types of joins between employees and departments tables.
*************************************/
-- INNER JOIN: Retrieves rows where there is a match in both tables
SELECT *
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

-- LEFT JOIN (or LEFT OUTER JOIN): Retrieves all rows from the left table and matched rows from the right table (fills in with NULLs for non-matching rows)
SELECT *
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id;

-- RIGHT JOIN (or RIGHT OUTER JOIN): Retrieves all rows from the right table and matched rows from the left table (fills in with NULLs for non-matching rows)
SELECT *
FROM employees
RIGHT JOIN departments ON employees.department_id = departments.department_id;

-- FULL JOIN (or FULL OUTER JOIN): Retrieves all rows when there is a match in either table (fills in with NULLs for non-matching rows)
SELECT *
FROM employees
FULL JOIN departments ON employees.department_id = departments.department_id;

-- CROSS JOIN: Retrieves the Cartesian product of the two tables (all possible combinations of rows)
SELECT *
FROM employees
CROSS JOIN departments;