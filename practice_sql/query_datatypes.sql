/*********************************************
  Script: query_datatypes.sql
  Description: Example script demonstrating different data types in SQLite.
**********************************************/

-- Create a table for string data types
CREATE TABLE IF NOT EXISTS string_types_info (
    data_type TEXT,
    example TEXT,
    description TEXT
);

-- Comments on Table Structure
-- string_types_info: Table to store information about string data types.
--   Columns: data_type, example, description.

-- Insert data for string data types
INSERT INTO string_types_info VALUES ('TEXT', "'Hello'", 'Variable-length character strings.');
INSERT INTO string_types_info VALUES ('CHAR', "'A'", 'Fixed-length character strings.');
INSERT INTO string_types_info VALUES ('BINARY', "X'53514C697465'", 'Binary data stored as a string of hexadecimal characters.');
INSERT INTO string_types_info VALUES ('ENUM(val1, val2, val3, ...)', "'val1'", 'Enumerated data type with a set of predefined values.');
INSERT INTO string_types_info VALUES ('SET(val1, val2, val3, ...)', "'val1,val2'", 'A set of zero or more values chosen from a predefined list.');
INSERT INTO string_types_info VALUES ('TINYTEXT', "'Tiny Text'", 'Short variable-length character string.');
INSERT INTO string_types_info VALUES ('MEDIUMTEXT', "'Medium Text'", 'Medium-length variable-length character string.');
INSERT INTO string_types_info VALUES ('LONGTEXT', "'Long Text'", 'Long variable-length character string.');

-- Comments on Insert Statements
-- Inserted examples and descriptions for BINARY, ENUM, SET, TINYTEXT, MEDIUMTEXT, and LONGTEXT data types.

-- Create a table for numeric data types
CREATE TABLE IF NOT EXISTS numeric_types_info (
    data_type TEXT,
    example TEXT,
    description TEXT
);

-- Comments on Table Structure
-- numeric_types_info: Table to store information about numeric data types.
--   Columns: data_type, example, description.

-- Insert data for numeric data types
INSERT INTO numeric_types_info VALUES ('INTEGER', '123', 'Whole numbers without fractional parts.');
INSERT INTO numeric_types_info VALUES ('REAL', '3.14', 'Floating-point numbers with decimal parts.');
INSERT INTO numeric_types_info VALUES ('TINYINT', '127', 'Very small integer.');
INSERT INTO numeric_types_info VALUES ('SMALLINT', '32767', 'Small integer.');
INSERT INTO numeric_types_info VALUES ('MEDIUMINT', '8388607', 'Medium-sized integer.');
INSERT INTO numeric_types_info VALUES ('FLOAT(size, d)', '3.14', 'Floating-point number with specified precision.');
INSERT INTO numeric_types_info VALUES ('FLOAT(p)', '3.14', 'Floating-point number with specified precision.');
INSERT INTO numeric_types_info VALUES ('DOUBLE(size, d)', '3.14', 'Double-precision floating-point number with specified precision.');
INSERT INTO numeric_types_info VALUES ('DECIMAL(size, d)', '3.14', 'Fixed-point number with specified precision.');

-- Comments on Insert Statements
-- Inserted examples and descriptions for BIT, TINYINT, SMALLINT, MEDIUMINT, FLOAT, DOUBLE, and DECIMAL data types.

-- Create a table for date data types
CREATE TABLE IF NOT EXISTS date_types_info (
    data_type TEXT,
    example TEXT,
    description TEXT
);

-- Comments on Table Structure
-- date_types_info: Table to store information about date data types.
--   Columns: data_type, example, description.

-- Insert data for date data types
INSERT INTO date_types_info VALUES ('DATE', "'2023-12-01'", 'Stores date in the format YYYY-MM-DD.');
INSERT INTO date_types_info VALUES ('YEAR', "'2023'", 'Stores a year in a four-digit format.');
INSERT INTO date_types_info VALUES ('TIME(fsp)', "'12:34:56.789'", 'Stores time in the format HH:MM:SS with fractional seconds.');
INSERT INTO date_types_info VALUES ('DATETIME(fsp)', "'2023-12-01 12:34:56.789'", 'Stores both date and time with fractional seconds.');
INSERT INTO date_types_info VALUES ('TIMESTAMP(fsp)', "'2023-12-01 12:34:56.789'", 'Same as DATETIME with fractional seconds.');

-- Comments on Insert Statements
-- Inserted examples and descriptions for YEAR, TIME, DATETIME, and TIMESTAMP data types.

-- End of Script
