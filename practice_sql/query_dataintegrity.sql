/*********************************************
  Script: query_data_integrity.sql
  Description: Example script demonstrating various techniques for data integrity.
**********************************************/

-- Table Creation with Constraints
CREATE TABLE IF NOT EXISTS students (
    student_id INTEGER PRIMARY KEY, -- Primary key for uniquely identifying students
    student_name TEXT NOT NULL UNIQUE, -- Student name must be unique and cannot be NULL
    major TEXT, -- Major of the student
    total_credit_hours INTEGER DEFAULT 0 -- Default value for total_credit_hours is 0
);

CREATE TABLE IF NOT EXISTS enrolled_courses (
    enrollment_id INTEGER PRIMARY KEY, -- Primary key for uniquely identifying enrollments
    student_id INTEGER,
    course_id INTEGER,
    grade TEXT,
    credit_hours INTEGER,
    FOREIGN KEY (student_id) REFERENCES students(student_id), -- Foreign key referencing students table
    FOREIGN KEY (course_id) REFERENCES courses(course_id) -- Foreign key referencing courses table
);

CREATE TABLE IF NOT EXISTS courses (
    course_id INTEGER PRIMARY KEY, -- Primary key for uniquely identifying courses
    course_name TEXT, -- Name of the course
    credit_hours INTEGER CHECK (credit_hours >= 0) -- Check constraint ensuring credit_hours is non-negative
);

-- Trigger for Total Credit Hours Update
CREATE TRIGGER update_total_credit_hours
AFTER INSERT ON enrolled_courses
BEGIN
    UPDATE students
    SET total_credit_hours = total_credit_hours + NEW.credit_hours
    WHERE student_id = NEW.student_id; -- Update total_credit_hours when a new course is enrolled
END;

-- Comments on Table Structure
-- students: Holds information about students.
--   Columns: student_id (Primary Key), student_name (Unique, NOT NULL), major, total_credit_hours (Defaulted to 0).
-- enrolled_courses: Represents courses that students are enrolled in.
--   Columns: enrollment_id (Primary Key), student_id (Foreign Key), course_id (Foreign Key), grade, credit_hours.
-- courses: Contains information about available courses.
--   Columns: course_id (Primary Key), course_name, credit_hours (Must be non-negative).

-- Inserting Initial Data
INSERT INTO students (student_name, major) VALUES ('John Doe', 'Computer Science');
INSERT INTO students (student_name, major) VALUES ('Jane Smith', 'Mathematics');

INSERT INTO courses (course_name, credit_hours) VALUES ('Database Management', 3);
INSERT INTO courses (course_name, credit_hours) VALUES ('Statistics', 4);

INSERT INTO enrolled_courses (student_id, course_id, grade, credit_hours) VALUES (1, 1, 'A', 3);
INSERT INTO enrolled_courses (student_id, course_id, grade, credit_hours) VALUES (2, 2, 'B', 4);

-- Attempt to Violate Unique Constraint (Commented Out - Uncommenting this line will cause a constraint violation)
-- INSERT INTO students (student_name, major) VALUES ('John Doe', 'Physics');

-- Display Resulting Data
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrolled_courses;

/*********************************************
  CREATE TRIGGER: This statement is used to create a new trigger.


  update_total_credit_hours: This is the name of the trigger. You can give it any name that makes sense to you.

  AFTER INSERT ON enrolled_courses: This specifies when the trigger should be activated. In this case, it is set to
  execute "AFTER" a new row is "INSERT"ed into the enrolled_courses table.

  BEGIN ... END: This block contains the code that will be executed when the trigger is activated. In this case, it's an
   UPDATE statement.

  UPDATE students SET total_credit_hours = total_credit_hours + NEW.credit_hours WHERE student_id = NEW.student_id;:
  This is the SQL statement that gets executed when a new row is inserted into the enrolled_courses table. It updates
  the total_credit_hours in the students table for the corresponding student by adding the credit hours of the newly
  enrolled course.

  NEW is a reference to the newly inserted row in the enrolled_courses table.
  NEW.credit_hours refers to the value of the credit_hours column in the newly inserted row.
  WHERE student_id = NEW.student_id ensures that the update is applied to the correct student.
  So, in summary, whenever a new course is inserted into the enrolled_courses table, the trigger updates the
  total_credit_hours for the corresponding student in the students table by adding the credit hours of the newly
  enrolled course.

  Triggers are useful for automating actions based on changes in the database. They can be used to maintain data
  consistency and perform additional actions when certain events occur.
**********************************************/

-- End of Script
