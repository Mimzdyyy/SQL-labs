-- Lab | SQL Queries 6



drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

-- 1 Add the new films to the database.
-- #show variables like 'local_infile';
-- #set global local_infile = 1;

        
load data local infile './films_2020.csv' 
into table film
fields terminated BY ',';

-- 2 Update information on rental_duration, rental_rate, and replacement_cost
update film set rental_duration = 3, rental_rate = 2.99, replacement_cost = 8.99;

-- 3 You might have to use the following commands to set bulk import option to ON:
show variables like 'local_infile';
	set global local_infile = 1;
update inventory set store_id = 1;

-- 4 If bulk import gives an unexpected error, you can also use the data_import_wizard to insert data into the new table.
insert into inventory(film_id, store_id)
select film_id, 2 from film
where release_year = 2020;