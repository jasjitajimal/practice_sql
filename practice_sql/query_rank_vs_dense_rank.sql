/*********************************************
Both DENSE_RANK() and RANK() are window functions in SQL that assign a rank to each row within a result set based on
the values of one or more columns. However, there is a key difference in how ties (rows with equal values) are handled:

DENSE_RANK():

DENSE_RANK() assigns a unique rank to each distinct set of values, but it does not leave gaps when there are ties.
Tied values receive the same rank, and the next distinct set of values gets the next rank without any gaps.
Example: If two rows have the same value and are assigned a rank of 1, the next distinct value will be assigned a
rank of 2, even if there are other rows with the same value.

example:
**********************************************/
sql
SELECT
    Value,
    DENSE_RANK() OVER (ORDER BY Value) AS DenseRank
FROM
    YourTable;



/*********************************************
RANK():

RANK() also assigns a unique rank to each distinct set of values, but it leaves gaps when there are ties.
Tied values receive the same rank, and the next distinct set of values gets the next rank, leaving gaps for tied values.
Example: If two rows have the same value and are assigned a rank of 1, the next distinct value will be assigned a rank
of 3 if there were two tied values.
Example:
**********************************************/
SELECT
    Value,
    RANK() OVER (ORDER BY Value) AS Rank
FROM
    YourTable;


Here's a brief example to illustrate the difference:

sql
Copy code
-- Sample Data
CREATE TABLE YourTable (
    Value INT
);

INSERT INTO YourTable (Value) VALUES
(10),
(20),
(30),
(20),
(40);

-- DENSE_RANK() Example
SELECT
    Value,
    DENSE_RANK() OVER (ORDER BY Value) AS DenseRank
FROM
    YourTable;

-- RANK() Example
SELECT
    Value,
    RANK() OVER (ORDER BY Value) AS Rank
FROM
    YourTable;

/*********************************************
In the DENSE_RANK() result, there will be no gaps in the ranks for tied values. In the RANK() result,
there will be gaps for tied values. in Rank, its value will be 1,2,2,4,5 while in
dense_rank its valuue will be, 1,2,2,3,4 **********************************************/