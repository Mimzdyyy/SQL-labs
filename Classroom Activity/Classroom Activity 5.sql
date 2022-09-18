# step1: first we create a view with the time data we need
  create or replace view user_activity as
    select account_id, convert(date, date) as 
#step2: create a view to get the total number of active users per month and year
  create or replace view monthly_active_users as
  select activity_month, activity_year, count(distinct account_id) as active_users
  from bank.user_activity
  group by activity_year, activity_month
  order by activity_year, activity_month;
  
  select * from monthly_active_users;
-- step3: use th lag function to calculate the differences of the amount of monthly active users between each month 
  
  select activity_year, activity_month,
         active_users,
         lag(active_users) over (partition by activity_year order by activity_month) as last_month_user
  from monthly_active_users;

-- step4: get the difference
  create or replace view difference_monthly_active_users as
  with cte_view as (
	select activity_year, activity_month,
           active_users,
           lag(active_users) over (partition by activity_year order by activity_month) as last_month_users
	from monthly_active_users
     )
     select 
        activity_year,
        activity_month,
        active_users,
        (active_users - last_month_users) as monthly_difference
	from cte_view;
    
    select * from difference_monthly_active_users;
    
    
## Exercises for the students (solutions on the file class_rolling_calculations)

#1. How many accounts we have?
#2. How many accounts are defaulted?
#3. What is the percentage of defaulted people on the database?
#4. Find the account_id, amount_id, amount and the date of the first transaction of the defaulted people it its amount is at least twice the average
#of the people that do not default;
#5. Get the percentage of variation in the number of users cin comparison with the previous month.

-- step1:
-- step2: users that made a transfer this month and also last month
  
  create or replace view bank.recurrent_users as
  select d1.active_id, d1.activity_year, d1.activity_month 
  from distinct_users d1
  join distinct_users d2
  on d1.activity_year = d2.activity_year
  and d1.activity_month = d2.activity_month +1 -- to get 
-- step3. count the recurrent customers per month
  
  create or replace view bank.total_recurrent_users as
  select activity_year, activity_month, count(active_id) as recurrent_users
  from bank.recurrent_users
  group by activity_year, activity_month;
  
  select * from bank.total_recurrent_users;

-- step4. use a lag function to have the columns this month and previous month side by side
  create or replace view bank.recurrent_users_monthly as
  select *,
  lag(recurrent_users) over() as previous_month_users
  from bank.total_recurrent_users;
  
  select * from bank.recurrent_users_monthly;

