/*********************************************
  Script: query_rank.sql
  Description: Queries demonstrating the use of Windows RANK() function in SQL.
**********************************************/

-- Create Sample Table
CREATE TABLE IF NOT EXISTS SampleTable (
    ID INT PRIMARY KEY,
    Category NVARCHAR(50),
    Value INT
);

-- Insert Sample Data
INSERT INTO SampleTable (ID, Category, Value)
VALUES (1, 'A', 10),
       (2, 'A', 20),
       (3, 'A', 30),
       (4, 'B', 15),
       (5, 'B', 25),
       (6, 'C', 12),
       (7, 'C', 18),
       (8, 'C', 22);

-- Query 1: Rank within each category based on value in descending order
-- Comments:
-- - Uses RANK() function to assign ranks within each category.
-- - ORDER BY determines the order of ranking within each partition.
-- - Ranks are reset for each category.

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (PARTITION BY Category ORDER BY Value DESC) AS RankWithinCategory
FROM
    SampleTable;

-- Query 2: Rank based on value across all categories in ascending order
-- Comments:
-- - RANK() without PARTITION BY ranks across all categories.
-- - ORDER BY determines the order of ranking.
-- - Ranks are not reset for each category.

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (ORDER BY Value) AS RankAcrossCategories
FROM
    SampleTable;

-- Query 3: Rank within each category based on value in ascending order
-- Comments:
-- - Similar to Query 1 but with ascending order.
-- - RANK() function assigns ranks within each category.
-- - ORDER BY determines the order of ranking within each partition.

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (PARTITION BY Category ORDER BY Value) AS RankWithinCategoryAsc
FROM
    SampleTable;


-- Query 4: Rank based on value across all categories in descending order
-- Comments:
-- - Similar to Query 2 but with descending order.
-- - RANK() without PARTITION BY ranks across all categories.
-- - ORDER BY determines the order of ranking.

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (ORDER BY Value DESC) AS RankAcrossCategoriesDesc
FROM
    SampleTable;

-- Query 5: Rank with ties allowed (same rank for tied values)
-- Comments:
-- - RANK() function allows ties, assigning the same rank to tied values.
-- - No PARTITION BY clause, so ties are determined across all rows.
-- - ORDER BY determines the order of ranking.

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (ORDER BY Value) AS RankWithTies
FROM
    SampleTable;

-- Query 6: Rank with ties allowed within each category
-- Comments:
-- - RANK() function allows ties within each category.
-- - PARTITION BY clause is used to reset ranks for each category.
-- - ORDER BY determines the order of ranking within each partition.

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (PARTITION BY Category ORDER BY Value) AS RankWithTiesWithinCategory
FROM
    SampleTable;

-- Query 7: Rank using a different ordering column
-- Comments:
-- - RANK() function can use a different column for ordering.
-- - In this case, ordering is based on the length of the Category column.
-- - Ranks are assigned based on the ordering column.

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (ORDER BY LEN(Category)) AS RankByCategoryLength
FROM
    SampleTable;

-- Query 8: Rank with NULL values
-- Comments:
-- - RANK() function handles NULL values.
-- - NULL values are treated as the lowest possible value.
-- - Ranks are assigned accordingly.

INSERT INTO SampleTable (ID, Category, Value)
VALUES (9, 'A', NULL),
       (10, 'B', NULL);

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (ORDER BY Value) AS RankWithNullValues
FROM
    SampleTable;

-- Query 9: Rank using a complex ordering condition
-- Comments:
-- - RANK() function can use a complex ordering condition.
-- - In this case, ordering is based on the value and the length of the Category column.
-- - Ranks are assigned based on the ordering condition.

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (ORDER BY Value, LEN(Category) DESC) AS ComplexRanking
FROM
    SampleTable;

-- Query 10: Rank using a subset of rows (TOP N)
-- Comments:
-- - RANK() can be applied to a subset of rows using TOP N.
-- - In this case, RANK is applied to the top 3 values within each category.
-- - PARTITION BY determines ranks within each category.

SELECT
    ID,
    Category,
    Value,
    RANK() OVER (PARTITION BY Category ORDER BY Value DESC) AS RankTop3WithinCategory
FROM
    (
        SELECT TOP 3
            ID,
            Category,
            Value
        FROM
            SampleTable
        ORDER BY
            Value DESC
    ) AS Top3Rows;

-- End of Script
