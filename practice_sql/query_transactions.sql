/*********************************************
  Script: query_transaction.sql
  Description: Example script for demonstrating transactions in SQLite.
**********************************************/

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Create tables
CREATE TABLE IF NOT EXISTS accounts (
    account_id INTEGER PRIMARY KEY,
    account_name TEXT NOT NULL,
    balance REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INTEGER PRIMARY KEY,
    account_id INTEGER,
    amount REAL,
    transaction_type TEXT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Comments on Table Structure
-- accounts: Represents bank accounts.
--   Columns: account_id (Primary Key), account_name, balance.
--
-- transactions: Records transactions related to accounts.
--   Columns: transaction_id (Primary Key), account_id (Foreign Key), amount, transaction_type.

-- Insert initial data
INSERT INTO accounts (account_name, balance) VALUES ('Savings', 1000.00);
INSERT INTO accounts (account_name, balance) VALUES ('Checking', 500.00);

-- Comments on Initial Insert Statements
-- Created two accounts: Savings with a balance of $1000 and Checking with a balance of $500.

-- Begin a transaction
BEGIN;

-- Update balance in the accounts table
UPDATE accounts SET balance = balance - 100 WHERE account_name = 'Savings';
UPDATE accounts SET balance = balance + 100 WHERE account_name = 'Checking';

-- Comments on Update Statements within the Transaction
-- Deducted $100 from the Savings account.
-- Added $100 to the Checking account.

-- Insert a transaction record
INSERT INTO transactions (account_id, amount, transaction_type) VALUES (1, 100, 'WITHDRAWAL');

-- Comments on Insert Statement within the Transaction
-- Recorded a withdrawal transaction of $100 for the Savings account.

-- Commit the transaction
COMMIT;

-- Comments on Commit
-- The changes made within the transaction are now permanent.

-- Begin another transaction
BEGIN;

-- Attempt an invalid update (e.g., deduct more than the available balance)
UPDATE accounts SET balance = balance - 800 WHERE account_name = 'Checking';

-- Comments on Invalid Update within a New Transaction
-- Attempted to deduct $800 from the Checking account, which is more than the available balance.

-- Rollback the transaction
ROLLBACK;

-- Comments on Rollback
-- The invalid changes made within the transaction are undone.

-- Verify the balances after the transactions
SELECT * FROM accounts;
SELECT * FROM transactions;

-- Comments on Verification Select Statements
-- Displaying the current state of the accounts and the transaction records.

-- End of Script
