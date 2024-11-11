/*********************************************
  SQL File: correlated_subquery.sql
  Description: This file demonstrates correlated subqueries in SQLite.
  A correlated subquery is a type of subquery in which the inner query depends on the outer query. In other words,
  the inner query references a column from the outer query, creating a relationship between the two queries.
  The result of the inner query depends on the current row being processed by the outer query.
**********************************************/


/*************************************
  Table: employees
  Description: Stores information about employees.
*************************************/
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE
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
  Description: Stores information about different departments.
*************************************/
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

/*************************************
  SQL Queries: Correlated Subquery Examples
  Description: Demonstrates various types of correlated subqueries.
*************************************/

-- Example 1: Correlated Subquery
-- Retrieve students with an age greater than the average age within their major.
SELECT student_name, age, major
FROM students s
WHERE age > (SELECT AVG(age) FROM students WHERE major = s.major);

-- Example 2: Correlated Subquery
-- Retrieve employees with a salary greater than the average salary within their department.
SELECT employee_name, salary, department_id
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

-- Example 3: Correlated Subquery with ORDER BY and LIMIT
-- Retrieve the top two highest-paid employees in each department.
SELECT employee_name, salary, department_id
FROM employees e
WHERE salary >= ALL (SELECT salary FROM employees WHERE department_id = e.department_id ORDER BY salary DESC LIMIT 2);

-- Example 4: Correlated Subquery with Comparison Operators
-- Retrieve employees with a hire date later than the average hire date within their department.
SELECT employee_name, hire_date, department_id
FROM employees e
WHERE hire_date > (SELECT AVG(hire_date) FROM employees WHERE department_id = e.department_id);

-- Example 5: Correlated Subquery with EXISTS, checking if any student has a grade of 'A' in any course.
SELECT student_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrolled_courses ec
    WHERE ec.student_id = s.student_id AND ec.grade = 'A'
);

-- Example 6: Retrieve students who are enrolled in at least one course with credit hours greater than 3.
SELECT student_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrolled_courses ec
    JOIN courses c ON ec.course_id = c.course_id
    WHERE ec.student_id = s.student_id AND c.credit_hours > 3
);

-- Example 7: Correlated Subquery with ANY, checking if any student has a grade of 'A' in any course.
SELECT student_name
FROM students s
WHERE 'A' = ANY (
    SELECT ec.grade
    FROM enrolled_courses ec
    WHERE ec.student_id = s.student_id
);

-- Example 8: Correlated Subquery with ALL, checking if all students have a grade of 'A' in at least one course.
SELECT student_name
FROM students s
WHERE 'A' = ALL (
    SELECT ec.grade
    FROM enrolled_courses ec
    WHERE ec.student_id = s.student_id
);

-- Example 9: Correlated Subquery with ANY, checking if the age of the student is greater than at least one student in the same major.
SELECT student_name, age, major
FROM students s
WHERE age > ANY (
    SELECT age
    FROM students
    WHERE major = s.major
);

-- Example 10: Correlated Subquery with ALL, checking if the age of the student is greater than all students in the same major.
SELECT student_name, age, major
FROM students s
WHERE age > ALL (
    SELECT age
    FROM students
    WHERE major = s.major
);