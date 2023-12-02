/*
  File: query_select.sql
  Author: Jasjit Singh
  Date: 2023-12-01
*/

-- Create the sample_table
/*
* Table: sample_table
* Purpose: Stores information about individuals.
*
* Columns:
*   id - Unique identifier
*   name - Name of the individual
*   age - Age of the individual
*   city - City of residence
*/

-- Creating the sample table

CREATE TABLE sample_table (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

-- Insert some sample data
INSERT INTO sample_table (id, name, age, city) VALUES
(1, 'John Doe', 25, 'New York'),
(2, 'Jane Smith', 30, 'Los Angeles'),
(3, 'Bob Johnson', 22, 'Chicago'),
(4, 'Alice Williams', 28, 'San Francisco'),
(5, 'Charlie Brown', 35, 'Seattle'),
(6, 'Eva Davis', 29, 'Boston'),
(7, 'Michael Wilson', 27, 'Austin'),
(8, 'Olivia Lee', 31, 'Denver'),
(9, 'Sam Taylor', 26, 'Miami'),
(10, 'Grace Miller', 33, 'Dallas');

-- Following is the usage of Order BY clause. Select any of the type that is required.
-- Order by name in ascending order
SELECT * FROM sample_table ORDER BY name;

-- Order by age in descending order
SELECT * FROM sample_table ORDER BY age DESC;

-- Order by city in ascending order, and then by age in descending order
SELECT * FROM sample_table ORDER BY city, age DESC;

-- Order by age in ascending order, and then by name in descending order
SELECT * FROM sample_table ORDER BY age, name DESC;
/*
* Change Log:
*   2023-12-01 - Jasjit - Created query_orderby.sql.
*/