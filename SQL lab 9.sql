-- Lab | SQL Queries 9


-- 1 Create a table rentals_may to store the data from rental table with information for the month of May.
USE sakila;
drop table if exists rentals_may;
CREATE TABLE rentals_may (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `rental_date` datetime NOT NULL,
  `inventory_id` mediumint unsigned NOT NULL,
  `customer_id` smallint unsigned NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `staff_id` tinyint unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rental_id`),
  UNIQUE KEY `rental_date` (`rental_date`,`inventory_id`,`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16052 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2 Insert values in the table rentals_may using the table rental, filtering values only for the month of May.
insert into rentals_may
select * from sakila.rental
where date_format(rental_date,'%M')= 'May';

-- 3 Create a table rentals_june to store the data from rental table with information for the month of June.
drop table if exists rentals_june;
CREATE TABLE rentals_june (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `rental_date` datetime NOT NULL,
  `inventory_id` mediumint unsigned NOT NULL,
  `customer_id` smallint unsigned NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `staff_id` tinyint unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rental_id`),
  UNIQUE KEY `rental_date` (`rental_date`,`inventory_id`,`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16052 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 4 Insert values in the table rentals_june using the table rental, filtering values only for the month of June.
insert into rentals_june
select * from sakila.rental;
where date_format(rental_date,'%M')= 'June';

-- 5 Check the number of rentals for each customer for May.
select rentals_may.customer_id, count(rentals_may.rental_id) as count, customer.first_name, customer.last_name
from sakila.rentals_may
join customer on customer.customer_id = rentals_may.customer_id
group by customer_id order by count(rentals_may.rental_id) desc;

-- 6 Check the number of rentals for each customer for June.
select rentals_june.customer_id, count(rentals_june.rental_id) as count, customer.first_name, customer.last_name
from sakila.rentals_june
join customer on customer.customer_id = rentals_june.customer_id
group by customer_id order by count(rentals_june.rental_id) desc;

-- 7 Create a Python connection with SQL database and retrieve the results of the last two queries (also mentioned below) as dataframes:


-- 8 Check the number of rentals for each customer for May


-- 9 Check the number of rentals for each customer for June
-- Hint: You can store the results from the two queries in two separate dataframes.


-- 10 Write a function that checks if customer borrowed more or less films in the month of June as compared to May.
-- Hint: For this part, you can create a join between the two dataframes created before, using the merge function available for pandas dataframes.
-- Here is a link to the documentation for the merge function.

