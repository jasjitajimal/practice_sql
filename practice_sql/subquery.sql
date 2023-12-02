/*********************************************
  SQL File: subquery.sql
  Description: This file demonstrates the use of subqueries and operators in SQLite.
**********************************************/

/*************************************
  Table: students
  Description: Stores information about students.
*************************************/
CREATE TABLE students (
    student_id INT PRIMARY KEY, -- Unique identifier for each student
    student_name VARCHAR(50), -- Name of the student
    age INT, -- Age of the student
    major VARCHAR(50) -- Major of the student
);

/*************************************
  Sample Data for students Table
*************************************/
INSERT INTO students (student_id, student_name, age, major) VALUES
(1, 'John Doe', 20, 'Computer Science'),
(2, 'Jane Smith', 22, 'Mathematics'),
(3, 'Bob Johnson', 21, 'Physics'),
(4, 'Alice Williams', 23, 'Chemistry'),
(5, 'Charlie Brown', 20, 'Biology');

/*************************************
  Table: courses
  Description: Stores information about courses.
*************************************/
CREATE TABLE courses (
    course_id INT PRIMARY KEY, -- Unique identifier for each course
    course_name VARCHAR(50), -- Name of the course
    credit_hours INT -- Number of credit hours for the course
);

/*************************************
  Table: enrolled_courses
  Description: Stores information about enrolled courses for students.
*************************************/
CREATE TABLE enrolled_courses (
    enrollment_id INT PRIMARY KEY, -- Unique identifier for each enrollment
    student_id INT, -- Foreign key referencing students table
    course_id INT, -- Foreign key referencing courses table
    grade VARCHAR(2) -- Grade for the course
);

/*************************************
  Sample Data for enrolled_courses Table
*************************************/
INSERT INTO enrolled_courses (enrollment_id, student_id, course_id, grade) VALUES
(1, 1, 1, 'A'),
(2, 2, 2, 'B'),
(3, 3, 3, 'A'),
(4, 4, 4, 'B'),
(5, 5, 5, 'A');

/*************************************
  SQL Queries: Subquery Examples
  Description: Demonstrates the use of subqueries and operators.
*************************************/
-- Example 1: Using the ANY operator to find students older than any student majoring in Physics
SELECT student_name, age
FROM students s
WHERE age > ANY (SELECT age FROM students WHERE major = 'Physics');

-- Example 2: Using the ALL operator to find students older than all students majoring in Chemistry
SELECT student_name, age
FROM students s
WHERE age > ALL (SELECT age FROM students WHERE major = 'Chemistry');


-- Example 3: Using a subquery with IN clause to find students taking any course with credit hours greater than 3
SELECT student_name
FROM students
WHERE student_id IN (SELECT student_id FROM enrolled_courses WHERE course_id IN (SELECT course_id FROM courses WHERE credit_hours > 3));

-- Example 4: Using a subquery with a correlated subquery to find students older than the average age
SELECT student_name, age
FROM students s
WHERE age > (SELECT AVG(age) FROM students);
