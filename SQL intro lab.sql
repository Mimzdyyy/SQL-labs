-- Lab | SQL Intro
use sakila;

-- Get all the data from tables actor, film and customer.
SELECT * FROM film;
select * from actor;
select * from customer;

-- get film titles
select title from film;

-- Get unique list of film languages under the alias language.
-- Note that we are not asking you to obtain the language per each film,
-- but this is a good time to think about how you might get that information in the future.
select name  as Language from language;

-- Find out how many stores does the company have?
select * from store;

-- Return a list of employee first names only?
select first_name from staff;
