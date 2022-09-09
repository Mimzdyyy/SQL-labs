-- Lab | SQL Queries 8


-- 1 Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
-- 2 Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
-- 3 How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
-- 4 Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
-- 5 Which is the most active customer (the customer that has rented the most number of films)?
--  Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.


-- 1
select title, length, RANK() over (ORDER BY length) ranks
from sakila.film
where length is not null and length > 0;


-- 2
select title, length, rating, rank() over (partition by rating order by length desc) as ranks
from sakila.film
where length is not null and length > 0;


-- 3
select name as category_name, count(*) as num_films
from sakila.category inner join sakila.film_category using (category_id)
group by name
order by num_films desc;


-- 4
select actor.actor_id, actor.first_name, actor.last_name,
count(actor_id) as film_count
from sakila.actor join sakila.film_actor using (actor_id)
group by actor_id
order by film_count desc
limit 1;

-- 5
select customer.*,
count(rental_id) as rental_count
from sakila.customer join sakila.rental using (customer_id)
group by customer_id
order by rental_count desc
limit 1;

