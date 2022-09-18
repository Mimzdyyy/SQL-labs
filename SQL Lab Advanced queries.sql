-- Lab | SQL Advanced queries



-- 1  List each pair of actors that have worked together.
select 
      concat(aa.first_name, ' ', aa.last_name) As Actor1, 
      concat(ac.first_name, ' ', ac.last_name) as Actor2
from 
      actor as aa
inner join
      film_actor as fa on aa.actor_id = fa.actor_id
inner join
      film_actor as ff on fa.film_id = ff.film_id
inner join
      actor ac on ac.actor_id = ff.actor_id
where
      fa.actor_id <> ff.actor_id;

select 
      a.actor_id as ActorID,
      b.actor_id as PartnerID,
      a.film_id as Film
from
      sakila.film_actor as a
join
      sakila.film_actor as b
on 
      a.actor_id <> b.actor_id
and 
      a.film_id = b.film_id
order by
      ActorID
Limit 10;


-- 2  For each film, list actor that has acted in more films.
select 
      actor_id 
      from  
          film_actor
where
      actor_id in (select actor_id 
      from
          film_actor
group by
      actor_id
having
      count(film_id)>1
order by 
      count(film_id) asc)
order by 
      film_id
limit 10;

