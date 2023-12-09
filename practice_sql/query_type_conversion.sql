/*********************************************
  Script: query_type_conversion.sql
  Description: Example script demonstrating type conversion in SQL Server.
**********************************************/

-- Create a table with different data types
CREATE TABLE IF NOT EXISTS sample_data (
    integer_column INT,
    real_column FLOAT,
    text_column NVARCHAR(MAX),
    date_column DATE
);

-- Insert data into the table
INSERT INTO sample_data VALUES (42, 3.14, N'Hello', '2023-12-01');

-- Comments on Table Structure
-- sample_data: Table with columns of different data types.
--   Columns: integer_column (INT), real_column (FLOAT), text_column (NVARCHAR(MAX)), date_column (DATE).

-- Show the original data
SELECT * FROM sample_data;

-- Comments on Select Statement
-- Displaying the original data in the sample_data table.

-- Perform type conversion using explicit functions
SELECT
    integer_column,
    -- CAST function for explicit conversion to NVARCHAR(MAX)
    CAST(integer_column AS NVARCHAR(MAX)) AS integer_as_text,
    real_column,
    -- CONVERT function for explicit conversion to NVARCHAR(MAX)
    CONVERT(NVARCHAR(MAX), real_column) AS real_as_text,
    text_column,
    -- TRY_CAST function for safe conversion to INT
    TRY_CAST(text_column AS INT) AS text_as_integer,
    -- String concatenation using '+'
    text_column + ' World' AS concatenated_text,
    -- Numeric addition with TRY_CAST for safe conversion
    5 + TRY_CAST('3.14' AS FLOAT) AS numeric_addition,
    '2023-12-01' AS date_literal,
    -- FORMAT function for date formatting
    FORMAT(date_column, 'yyyy-MM-dd') AS formatted_date,
    -- PARSE function for parsing date
    PARSE('12/01/2023' AS DATE) AS parsed_date,
    -- TRY_CONVERT function for safe conversion to FLOAT
    TRY_CONVERT(FLOAT, '3.14') AS try_convert_float
FROM sample_data;

-- Comments on Select Statement with Type Conversion
-- Displaying the original data along with type-converted columns.
-- Demonstrating various type conversion functions in SQL Server.


-- End of Script
