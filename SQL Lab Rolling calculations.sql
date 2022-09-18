-- Lab | SQL Rolling calculations



-- 1  Get number of monthly active customers.
select * from 
     sakila.customer
join
	 sakila.payment
using 
     (customer_id);

create or replace view
      user_activity as
select
      customer_id,
      convert(payment_date, date) as Activity_date,
date_format(convert(payment_date,date), '%m') as Activity_Month,
date_format(convert(payment_date,date), '%Y') as Activity_year
from 
      sakila.payment;


select * from 
     user_activity;


create or replace view
     Monthly_active_users as
select 
     Activity_year,
     Activity_Month,
     count(distinct customer_id) as Active_users 
from 
     user_activity
group by 
     Activity_year,
     Activity_Month
order by 
     Activity_year,
     Activity_Month;

select * from 
     sakila.Monthly_active_users;

with cte_activity as (
  select Activity_year, Activity_Month, Active_users, lag(Active_users,1) over (partition by Activity_year) as previous_month 
  from Monthly_active_users
)
select * from cte_activity
where previous_month is not null;


-- 2  Active users in the previous month.
with distinct_users as (
    select distinct 
		customer_id ,
		Activity_Month,
        Activity_year
    from 
        user_activity
)
  select 
        d1.Activity_year,
        d1.Activity_Month,
        count(distinct d1.customer_id) as Retained_customers
  from 
        distinct_users d1
  join 
        distinct_users d2
  on 
        d1.customer_id = d2.customer_id and d1.activity_Month = d2.activity_Month + 1
  group by
        d1.Activity_Month,
        d1.Activity_year
  order by
        d1.Activity_year,
        d1.Activity_Month;




  create or replace view 
       retained_customers_view as
with 
       distinct_users as (
  select distinct customer_id , Activity_Month, Activity_year
  from user_activity
)
select 
      d1.Activity_year,
      d1.Activity_Month,
      count(distinct d1.customer_id) as Retained_customers
from 
	distinct_users d1
join 
    distinct_users d2 on d1.customer_id = d2.customer_id
and 
    d1.activity_Month = d2.activity_Month + 1
group by
    d1.Activity_Month, d1.Activity_year
order by
    d1.Activity_year, d1.Activity_Month;

select * from
      sakila.retained_customers_view;


-- 3  Percentage change in the number of active customers.
select
	Activity_year,
	Activity_month, 
	Retained_customers, 
    lag(Retained_customers, 1) over(partition by Activity_year) as Last_month_retained_customers
from sakila.retained_customers_view;


select
    Activity_year,
    Activity_month,
	(Retained_customers-lag(Retained_customers, 1) over(partition by Activity_year)) as Diff
from sakila.retained_customers_view;


-- 4  Retained customers every month.
select * from 
       retained_customers_view;

