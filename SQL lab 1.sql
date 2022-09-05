-- Select all the actors with the first name ‘Scarlett’.
select * from actor where first_name = "Scarlett";

-- Select all the actors with the last name ‘Johansson’.
select * from actor where first_name = "Johansson";

-- How many films (movies) are available for rent?
select count(film_id) as films_available from film;

-- How many films have been rented?
select count(rental_id) as films_rented from rental;

-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select min(length) as min_duration, max(length) as max_duration from film;


-- What's the average movie duration expressed in format (hours, minutes)?
select substring_index(sec_to_time(avg(length)*60), ":", 2) 
as average_duration from film;

-- How many movies longer than 3 hours?
select count(*) from sakila.film
where length > 180;

-- Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
select concat(left(first_name,1), lower(substr(first_name,2)), last_name) as customer_name, lower(email) as email from sakila.customer

-- What's the length of the longest film title?
select max(length(title)) as longest_title from sakila.film
