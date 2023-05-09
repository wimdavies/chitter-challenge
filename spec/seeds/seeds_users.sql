-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)
-- CASCADE ensures deletions here also delete dependent records on the 'peeps' table

TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (name, username, email, password) VALUES ('Sam Morgan', 'sjmog', 'sam@aol.com', 'password123');
INSERT INTO users (name, username, email, password) VALUES ('Will Davies', 'wimdavies', 'will@aol.com', 'hunter2');
INSERT INTO users (name, username, email, password) VALUES ('Alice Wood', 'aliceswood', 'alice@aol.com', 'alicepass');