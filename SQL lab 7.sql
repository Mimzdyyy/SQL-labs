-- Lab | SQL Queries 7


-- 1 In the table actor, which are the actors whose last names are not repeated?
-- For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd.
--  These three actors have the same last name. So we do not want to include this last name in our output.
--  Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
select last_name from sakila.actor
group by last_name
having count(*) = 1;

-- 2 Which last names appear more than once? 
-- We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once.


-- 3 Using the rental table, find out how many rentals were processed by each employee.
select staff_id, count(*) from sakila.rental
group by staff_id;

-- 4 Using the film table, find out how many films were released each year.
select release_year, count(*) as num_films from sakila.film
group by release_year;

-- 5 Using the film table, find out for each rating how many films were there.
select rating, count(*) as num_films from sakila.film
group by rating;

-- 6 What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
select rating, avg(length) as avg_duration from sakila.film
group by rating
order by avg_duration desc;

-- 7 Which kind of movies (rating) have a mean duration of more than two hours?
select rating, round(avg(length),2) as avg_duration from sakila.film
group by rating
having avg_duration > 120
order by avg_duration desc;