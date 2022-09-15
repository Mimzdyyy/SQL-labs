use bank;

## recap examples: find the average number of transactions per account
##  get those accounts that have more transactions than the average

select * from trans;

-- step 1: total number transactions per each account
select account_id, count(account_id) as number from bank.trans
group by account_id
order by account_id;

-- step 2: getting the avg

select avg(number) from (
       select account_id, count(account_id) as number from bank.trans
       group by account_id
       order by account_id
)sub1;

-- step 3: we can filter the number transactions above avg
 select account_id, count(account_id) as number from bank.trans
group by account_id
having number> (select avg(number) from(
  select account_id, count(trans_id) as number from bank.trans
  group by account_id
  )sub1
  )
  order by number;

##recap2: get a list of accounts from Central Bohemia using a subquery
select * from account;
select * from account
where district_id in (
    select* from(
      select A1 from district where A3='central Bohemia'
      )sub1
      );

#rewrite it using a join query
select * from district;

select account_id from account a
join district d on a.district_id=d.A1
where A3='central Bohemia';

##recap 3: find the most active customer for each district in Central Bohemia
select account_id, count(account_id), district_id
    from account
    where district_id in (
       select A1
       from(
          select A1
          from district
          where A3 = 'central Bohemia')sub1
          )
    group by account_id;
    
    

## CTE COMMON TABLE EXPRESSIONS
# dummy EXAMPLE

with cte_loan as(
    select*from bank.loan
)
select*from cte_loan where status ='B';
## equivalent

select*from bank.loan where status ='B';

#not so dummy example:return all the account info and also the total amount and total balance of each account

select*from account;
select*from trans;

with cte_transactions as(
   select sum(amount), sum(balance), account_id
   from bank.trans
   group by account_id
   )
select * from cte_transactions as ct
join account a
on ct.account_id=a.account_id;

##VIEWS

# EXAMPLE

create or replace view loan_status_B as
select * from bank.loan
where status = "B";

select * from loan_status_B;
#drop the table
drop view if exists loan_status_B;


## EXERCISE: return the customers in status C that have total balance more than the avg balance for that specific status C
select * from loan;

create or replace view running_contract_ok_balances as
with cte_OK  as (
  select *, amount-payments as balance
  from bank.loan
  where status = 'C'
  order by Balance
)
select * from cte_OK
where balance > (
  select avg(Balance)
  from cte_OK
)
order by Balance desc
limit 20;

select * from running_contract_ok_balances;

## CORRELATED SUBQUERIES
-- for each duration, find the status with the highest total amount:

-- if i have a group and a subgroup/secondary group, and i need to pick for each group one row from the secondary group,
-- a window function is likely to solve my problem
select * from loan;

select duration, total, ranking
from (
	select *, row_number() over (partition by duration order by total desc) ranking
	from (
		select duration, status, sum(amount) total from bank.loan
		group by duration, status
		order by duration, status
	) as sub1
) as sub2
where ranking = 1;


-- doing it with ctes:
with cte1 as (
	 select duration, status, sum(amount) total from bank.loan
	 group by duration, status
	 order by duration, status
	),
	 cte2 as (
	 select *, row_number() over (partition by duration order by total desc) ranking
	 from cte1
	)
select duration, status, total 
from cte2
where ranking = 1;


## EXAMPLE: return the loans where the amount is greater than the avg amount per status

## EXAMPLE: for each duration find the status with the highest total amount

##ACTIVITIES (FOR THE SUDENTS)

# 1 USE A CTE to display the first account opened by district
select a.account_id from bank.account
where;

#solution
with cte_accounts as
(
SELECT account_id, district_id, date,
RANK() OVER (partition by district_id ORDER BY date) as ranking
FROM account)
SELECT account_id, district_id FROM cte_accounts
WHERE ranking = 1;



# 2 In order to spot possible fraud we want to create a view last_week_withdrawals with total withdraw per client
select * from disp;
select * from trans;

create or replace view last_week_withdrawals as
select client_id, amount, t.date from trans as t
left join disp as d
on t.account_id = d.account_id
where t.type = 'VYDAJ' and date > (select (max(date)-7) as last_week from trans)
group by client_id
order by t.account_id;


# 3 Select loans greater than the avg in their district
