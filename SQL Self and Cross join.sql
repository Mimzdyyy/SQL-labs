#Lab | SQL Self and cross join


-- 1 Get all pairs of actors that worked together.
-- 2 Get all pairs of customers that have rented the same film more than 3 times.
-- 3 Get all possible pairs of actors and films.


-- 1
select fa1.film_id, concat(a1.first_name, ' ', a1.last_name), concat(a2.first_name, ' ', a2.last_name)
from sakila.actor a1
inner join film_actor fa1 on a1.actor_id = fa1.actor_id
inner join film_actor fa2 on (fa1.film_id = fa2.film_id) and (fa1.actor_id != fa2.actor_id)
inner join actor a2 on a2.actor_id = fa2.actor_id;


-- 2
SELECT r.rental_id, r.customer_id, i.film_id FROM rental r 
JOIN inventory i 
ON r.inventory_id = i.inventory_id; 

select c1.customer_id, c2.customer_id, count(*) as num_films
from sakila.customer c1
inner join rental r1 on r1.customer_id = c1.customer_id
inner join inventory i1 on r1.inventory_id = i1.inventory_id
inner join film f1 on i1.film_id = f1.film_id
inner join inventory i2 on i2.film_id = f1.film_id
inner join rental r2 on r2.inventory_id = i2.inventory_id
inner join customer c2 on r2.customer_id = c2.customer_id
where c1.customer_id <> c2.customer_id
group by c1.customer_id, c2.customer_id
having count(*) > 3
order by num_films desc;

-- 3
select * from actor as a 
-- join film_actor as b
cross join film as c;

