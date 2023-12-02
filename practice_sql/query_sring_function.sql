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

-- Following is the usage of some string functions. Select any of the type which is required.
SELECT
    -- String functions
    LENGTH(name) AS name_length,                   -- Returns the length of the 'name' column
    UPPER(name) AS name_uppercase,                 -- Converts 'name' to uppercase
    LOWER(city) AS city_lowercase,                 -- Converts 'city' to lowercase
    SUBSTR(name, 1, 3) AS name_substr,             -- Extracts the first 3 characters from 'name'
    REPLACE(name, ' ', '_') AS name_replace,       -- Replaces spaces with underscores in 'name'
    TRIM(city) AS city_trimmed,                    -- Removes leading and trailing spaces from 'city'
    CONCAT(name, ' - ', city) AS name_city_concat, -- Concatenates 'name', a hyphen, and 'city'
    INSTR(city, 'o') AS position_of_o,            -- Returns the position of the first 'o' in 'city'
    LEFT(name, 3) AS name_left,                    -- Returns the leftmost 3 characters of 'name'
    RIGHT(city, 4) AS city_right,                  -- Returns the rightmost 4 characters of 'city'
    COALESCE(name, 'No Name') AS coalesce_name,   -- Returns 'name' or 'No Name' if 'name' is NULL

    -- Numeric functions
    ABS(age) AS abs_age,                           -- Returns the absolute value of 'age'
    CEIL(age) AS ceil_age,                         -- Returns the smallest integer greater than or equal to 'age'
    CEILING(age) AS ceiling_age,                   -- Same as CEIL, returns the smallest integer greater than or equal to 'age'
    FLOOR(age) AS floor_age,                       -- Returns the largest integer less than or equal to 'age'
    GREATEST(age, 30) AS greatest_age,             -- Returns the greatest value between 'age' and 30
    LEAST(age, 30) AS least_age,                   -- Returns the smallest value between 'age' and 30

    -- Numeric and rounding functions
    ROUND(age / 10.0, 2) AS rounded_age,           -- Rounds 'age' divided by 10 to 2 decimal places
    TRUNCATE(age / 10.0, 2) AS truncated_age,     -- Truncates 'age' divided by 10 to 2 decimal places
    RANDOM() AS random_value                       -- Returns a random value between 0 and 1
FROM
    sample_table;
/*
* Change Log:
*   2023-12-01 - Jasjit - Created query_string_function.sql.
*/