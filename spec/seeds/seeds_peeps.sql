-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE peeps RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO peeps (content, time, user_id) VALUES ('test post please ignore', '2023-05-01 08:00:00', '1');
INSERT INTO peeps (content, time, user_id) VALUES ('Wow, can''t believe I''m really peeping', '2023-05-01 08:01:00', '1');
INSERT INTO peeps (content, time, user_id) VALUES ('@sjmog I''m peeping too, it''s great! Everyone should peep.', '2023-05-01 08:02:00', '2');
INSERT INTO peeps (content, time, user_id) VALUES ('@sjmog @wimdavies omg I''m peeping as well, can''t believe this is the future of communication. nothing could possibly go wrong from here onwards', '2023-05-01 08:02:00', '3');