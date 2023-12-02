/*********************************************
  Script: insert_update_delete.sql
  Description: Example script for table creation, INSERT, UPDATE, and DELETE operations.
**********************************************/

-- Table Creation
CREATE TABLE IF NOT EXISTS students (
    student_id INTEGER PRIMARY KEY,
    student_name TEXT NOT NULL,
    major TEXT,
    age INTEGER
);

CREATE TABLE IF NOT EXISTS enrolled_courses (
    enrollment_id INTEGER PRIMARY KEY,
    student_id INTEGER,
    course_id INTEGER,
    grade TEXT,
    credit_hours INTEGER,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE IF NOT EXISTS courses (
    course_id INTEGER PRIMARY KEY,
    course_name TEXT,
    credit_hours INTEGER
);

-- Comments on Table Structure
-- students: Holds information about students.
--   Columns: student_id (Primary Key), student_name, major, age.
--
-- enrolled_courses: Represents courses that students are enrolled in.
--   Columns: enrollment_id (Primary Key), student_id (Foreign Key), course_id (Foreign Key), grade, credit_hours.
--
-- courses: Contains information about available courses.
--   Columns: course_id (Primary Key), course_name, credit_hours.

-- Inserting Data
INSERT INTO students (student_name, major, age) VALUES ('John Doe', 'Computer Science', 22);
INSERT INTO students (student_name, major, age) VALUES ('Jane Smith', 'Mathematics', 21);

INSERT INTO courses (course_name, credit_hours) VALUES ('Database Management', 3);
INSERT INTO courses (course_name, credit_hours) VALUES ('Statistics', 4);

INSERT INTO enrolled_courses (student_id, course_id, grade, credit_hours) VALUES (1, 1, 'A', 3);
INSERT INTO enrolled_courses (student_id, course_id, grade, credit_hours) VALUES (2, 2, 'B', 4);

-- Comments on Insert Statements
-- Inserted data into the students table for two students.
-- Inserted data into the courses table for two courses.
-- Enrolled John Doe in the Database Management course with an 'A' grade and 3 credit hours.
-- Enrolled Jane Smith in the Statistics course with a 'B' grade and 4 credit hours.

-- Updating Data
UPDATE students SET major = 'Computer Engineering' WHERE student_name = 'John Doe';
UPDATE enrolled_courses SET grade = 'B' WHERE student_id = 2 AND course_id = 2;

-- Comments on Update Statements
-- Updated John Doe's major to 'Computer Engineering'.
-- Changed Jane Smith's grade in the Statistics course to 'B'.

-- Deleting Data
DELETE FROM enrolled_courses WHERE student_id = 1 AND course_id = 1;

-- Comments on Delete Statements
-- Removed the enrollment record for John Doe in the Database Management course.

-- End of Script
