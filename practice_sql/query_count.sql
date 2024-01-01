/*
  File: query_count.sql
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

-- Following is the usage of COUNT function. Select any of the type that is required.
-- Count the number of rows in the sample_table
SELECT COUNT(*) AS row_count FROM sample_table;

-- Count of people in each city
SELECT city, COUNT(*) AS count_per_city FROM sample_table GROUP BY city;

-- Cities with more than 2 people
SELECT city, COUNT(*) AS count_per_city FROM sample_table GROUP BY city HAVING COUNT(*) > 2;

/*
* Change Log:
*   2023-12-01 - Jasjit - Created query_orderby.sql.
*/