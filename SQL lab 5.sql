-- Lab | SQL Queries 5

-- Drop column picture from staff.
alter table staff
drop column picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from customer where first_name = 'Tammy'; 
select * from staff; 


-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
-- You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there.
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
INSERT INTO rental VALUES (16050,'2020-10-28 14:46:31',3,130,NULL,1,'2020-10-28 14:46:31');

DROP TABLE IF EXISTS deleted_users;


-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
CREATE TABLE IF NOT EXISTS deleted_users(
deleted_users_id INT UNIQUE NOT NULL AUTO_INCREMENT,
customer_id INT UNIQUE NOT NULL,
email VARCHAR(50),
date_deleted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT PRIMARY KEY (deleted_users_id)
);

SELECT customer_id, email, current_timestamp() from customer WHERE active = 0;

CREATE TABLE deleted_users (
  `customer_id` int(11) UNIQUE NOT NULL,
  `email` text DEFAULT NULL,
  `date_deleted` DATETIME,
  CONSTRAINT PRIMARY KEY (customer_id)
);

SELECT customer_id, email, current_timestamp() from customer WHERE active = 0;

