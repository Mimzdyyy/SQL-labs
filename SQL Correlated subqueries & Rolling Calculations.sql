use bank;


##RECAP

#1. JOINS
#example: get info for defaulted clients

#tables: loans, ddistricts,account
#default is status B in the table loans

select * from account; # account_id, frequency
select * from loan; #loan_id, loan_amount, loan_payments, l.status. keys=account_id
select * from district; #region,district leys = district_id matches with A1


select a.account_id, a.district_id, a.frequency, d.A2 as district_name,
		d.A3 as region, l.loan_id, l.amount, l.payments, l.status
from bank.account a 
join bank.district d
on a.district_id = d.A1
join bank.loan l
on a.account_id = l.account_id
where l.status = "B"
order by a.account_id;

#subqueries

#example: get the amount of the loan and the payment made for the customers who defaulted and which value
# of the default is bigger than the average;

select * from ( 
select a.account_id, a.district_id, a.frequency, l.loan_id, l.amount, l.payments, l.status, d.A2 as district, d.A3 as region
from account a
join district d
on a.district_id = d.A1
join loan l
on a.account_id = l.account_id
where l.status = "B") sub1
where sub1.amount > (
select avg(amount) as average_amount from loan
)
;


#Ctes: from the last query get the last transaction
with ct1 as (
  select * from ( 
select a.account_id, a.district_id, a.frequency, l.loan_id, l.amount, l.payments, l.status, d.A2 as district, d.A3 as region
from account a
join district d
on a.district_id = d.A1
join loan l
on a.account_id = l.account_id
where l.status = "B") sub1
  where sub1.amount > (
select avg(amount) as average_amount from loan
) 
)
select ct1.account_id, max(date(t.date)) as last_transaction 
from ct1
join bank.trans as t
on ct1.account_id = t.account_id
group by account_id;

-- Find the account_id and date of the first transaction
-- of the defaulted people if its amount is at least twice 
-- the average of non-default people transactions.


-- get total transation amount for each month from all customer in 1st quarter of 1993
select account_id, date_format(date, "%M") as Month, sum(amount)
from trans
where date_format(date, "%Y") = 1993
and date_format(date, "%m") <= 3
group by 1,2;



-- account_id, jan, feb, mar

create function print_function(param1 char(20))
returns char(50) deterministic
return concat('Hello ', param1, '!');

drop function print_function;

select print_function('python');

drop procedure num_of_rows;

DELIMITER //
create procedure num_of_rows(out param1 int)
begin
select COUNT(*) into param1 from bank.account;
end //
DELIMITER ;

call num_of_rows(@rita);
select @rita;




-- How many accounts do we have?
select count(distinct account_id)
from bank.account;

-- How many of the accounts are defaulted?
select count(distinct a.account_id)
from bank.account a
join bank.loan l
on a.account_id = l.account_id
where l.status = 'B';

-- What is the percentage of defaulted people in the dataset?
Select (Select count(a.account_id)
from bank.account a join bank.district d
on a.district_id = d.A1
join bank.loan l
on a.account_id = l.account_id
where l.status = 'B')/(Select count(account_id)
from bank.account) * 100;
