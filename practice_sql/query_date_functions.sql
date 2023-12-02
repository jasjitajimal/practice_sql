/*
  File: query_query_date_functions.sql
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
*   birthdate - Date of birth
*   birthtime - Time of birth
*/
-- Create the sample_table
CREATE TABLE sample_table (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50),
    birthdate DATE,
    birthtime TIME
);

-- Insert some sample data
INSERT INTO sample_table (id, name, age, city, birthdate, birthtime) VALUES
(1, 'John Doe', 25, 'New York', '1998-05-15', '08:30:00'),
(2, 'Jane Smith', 30, 'Los Angeles', '1993-12-10', '14:45:00'),
(3, 'Bob Johnson', 22, 'Chicago', '2001-08-22', '18:20:00'),
(4, 'Alice Williams', 28, 'San Francisco', '1995-04-03', '09:00:00'),
(5, 'Charlie Brown', 35, 'Seattle', '1988-11-28', '12:10:00'),
(6, 'Eva Davis', 29, 'Boston', '1994-09-17', '17:30:00'),
(7, 'Michael Wilson', 27, 'Austin', '1996-07-08', '20:15:00'),
(8, 'Olivia Lee', 31, 'Denver', '1991-03-12', '10:45:00'),
(9, 'Sam Taylor', 26, 'Miami', '1997-10-05', '11:20:00'),
(10, 'Grace Miller', 33, 'Dallas', '1989-06-20', '16:40:00');

-- Examples of date and time functions
SELECT
    id,
    name,
    age,
    city,
    birthdate,
    birthtime,

    -- Following is the usage of Date function. Select any of the type that is required.
    -- Current date and time functions

    CURRENT_DATE AS current_date, -- Current date in 'YYYY-MM-DD' format
    CURRENT_TIME AS current_time, -- Current time in 'HH:MM:SS' format
    CURRENT_TIMESTAMP AS current_timestamp, -- Current date and time in 'YYYY-MM-DD HH:MM:SS' format
    -- Date and time functions with 'now'
    DATE('now') AS current_date_function, -- Current date
    TIME('now') AS current_time_function, -- Current time
    DATETIME('now') AS current_datetime_function, -- Current date and time
    -- Custom datetime format
    STRFTIME('%Y-%m-%d %H:%M:%S', 'now') AS custom_datetime_format, -- Custom date and time format
    -- Extracting components
    strftime('%Y', birthdate) AS birth_year, -- Extract year from date
    strftime('%m', birthdate) AS birth_month, -- Extract month from date
    strftime('%d', birthdate) AS birth_day, -- Extract day from date
    -- Date arithmetic
    DATE(birthdate, '+2 years') AS birthdate_plus_2_years, -- Add 2 years to the date
    TIME(birthtime, '+1 hour') AS birthtime_plus_1_hour, -- Add 1 hour to the time
    STRFTIME('%Y-%m-%d', birthdate, '+1 day') AS birthdate_plus_1_day, -- Add 1 day to the date
    STRFTIME('%H:%M:%S', birthtime, '-30 minutes') AS birthtime_minus_30_minutes, -- Subtract 30 minutes from the time
    -- Julian day
    JULIANDAY(birthdate) AS julian_day, -- Julian day of the date
    -- Future birthdate next month
    DATETIME(birthdate, '+1 month') AS future_birthdate_next_month, -- Add 1 month to the date
    -- Day of week, day of year, week of year
    strftime('%w', birthdate) AS day_of_week, -- Day of the week (0 for Sunday, 1 for Monday, etc.)
    strftime('%j', birthdate) AS day_of_year, -- Day of the year
    strftime('%W', birthdate) AS week_of_year, -- Week of the year
    -- Format birthtime
    STRFTIME('%H:%M:%S', birthtime) AS birthtime_formatted -- Format time
FROM
    sample_table;

/*
* Change Log:
*   2023-12-02 - Jasjit - Created query_date_functions.sql.
*/