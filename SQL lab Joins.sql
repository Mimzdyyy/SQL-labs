#Lab | SQL Join



-- 1 List the number of films per category.
-- 2 Display the first and the last names, as well as the address, of each staff member.
-- 3 Display the total amount rung up by each staff member in August 2005.
-- 4 List all films and the number of actors who are listed for each film.
-- 5 Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.

-- 1 
select name as category_name, count(*) as num_films
from sakila.category
inner join sakila.film_category
using (category_id)
group by name
order by num_films desc;

-- 2
select staff.first_name, staff.last_name, address.address
from sakila.address
inner join sakila.staff
on staff.address_id = address.address_id;
-- 3
select staff.staff_id, first_name || ' ' || last_name as employee, sum(amount) as `total amount`
from sakila.staff
inner join sakila.payment
on staff.staff_id = payment.staff_id
where month(payment.payment_date) = 8 and year(payment.payment_date) = 2005
group by staff.staff_id;

-- 4
select title as `film title`, count(actor_id) as `number of actors`
from sakila.film
inner join sakila.film_actor
on film.film_id = film_actor.film_id
group by film.film_id;

-- 5
select first_name, last_name, sum(amount) as "total amount paid"
from sakila.customer
inner join sakila.payment
on customer.customer_id = payment.customer_id
group by customer.customer_id
order by last_name;