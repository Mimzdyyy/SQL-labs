#Lab | SQL Subqueries
use sakila;

-- 1 How many copies of the film Hunchback Impossible exist in the inventory system?
select 
        count(film_id) as counts 
from 
        inventory
where 
        film_id = (
        select film_id 
        from sakila.film
        where title = 'Hunchback Impossible'
);

-- 2 List all films whose length is longer than the average of all the films.
select 
      title, length 
from 
      sakila.film
where 
      length > (
      select avg(length)
      from sakila.film
);


-- 3 Use subqueries to display all actors who appear in the film Alone Trip.
select 
      concat(first_name , ' ' , last_name) as Actor
from 
      sakila.actor
where 
      actor_id in (
      -- Grab the actor_ids for actors in Alone Trip
      select 
            actor_id
      from 
            sakila.film_actor
	  where 
			film_id = (
	        -- Grab the film_id for Alone Trip
            select
                  film_id
            from 
                  sakila.film
            where 
                  title = 'ALONE TRIP'
)
);


-- 4 Sales have been lagging among young families, and you wish to target all family movies for a promotion.
-- Identify all movies categorized as family films.
select 
      title as Title
from 
      sakila.film
where 
     film_id in (
     select 
           film_id
	 from 
           sakila.film_category
     where 
           category_id in (
           select 
                 category_id
           from 
                 sakila.category
           where name = 'Family'
)
);


-- 5 Get name and email from customers from Canada using subqueries. Do the same with joins.
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
select 
      concat(first_name,' ',last_name) as Customer_Name, email
from 
      sakila.customer
where 
      address_id in (
	  select
            address_id
      from 
            sakila.address
      where 
            city_id in (
            select 
                  city_id
            from 
                  sakila.city
            where 
                  country_id in (
                  select 
                        country_id
                  from 
                        sakila.country
                  where 
                        country = 'Canada'
)
)
);


-- 6 Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films.
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select
	  actor_id
from 
      sakila.actor
inner join 
      sakila.film_actor
using 
      (actor_id)
inner join
	  sakila.film
using 
      (film_id)
group by 
      actor_id
order by 
      count(film_id) desc
limit 1;




select 
      concat(first_name, ' ', last_name) as actor_name, film.title, film.release_year
from 
      sakila.actor
inner join
      sakila.film_actor
using
      (actor_id)
inner join
      film
using 
     (film_id)
where actor_id = (
	 select 
           actor_id
     from 
           sakila.actor
	 inner join 
           sakila.film_actor
	 using 
           (actor_id)
     inner join 
           sakila.film
	 using 
           (film_id)
     group by 
           actor_id
     order by
           count(film_id) desc
	 limit 1
)
order by 
       release_year desc;

-- 7 Films rented by most profitable customer.
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
select 
      customer_id
from 
      sakila.customer
inner join
      payment using (customer_id)
group by
      customer_id
order by
      sum(amount) desc
limit 1;

-- films rented by most profitable customer
select
      film_id, title, rental_date, amount
from
      sakila.film
inner join 
      inventory using (film_id)
inner join
      rental using (inventory_id)
inner join
      payment using (rental_id)
where
      rental.customer_id = (
      select
            customer_id
	  from 
            customer
	  inner join
            payment
	  using 
            (customer_id)
      group by 
            customer_id
      order by 
            sum(amount) desc
       limit 1
)
order by 
        rental_date desc;


-- 8 Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
select
     customer_id, sum(amount) as payment
from 
     sakila.customer
inner join
     payment using (customer_id)
group by
       customer_id
having
       sum(amount) > (
       select avg(total_payment)
	   from (
            select 
                  customer_id, sum(amount) total_payment
            from
                  payment
            group by 
                  customer_id
) sum1
)
order by 
        payment desc;

