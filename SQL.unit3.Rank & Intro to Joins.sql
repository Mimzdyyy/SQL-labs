use bank;

-- a little recap

select * from loan;

-- ramk the customers based on the amount of the loan that they borrowed

select *, rank() over (order by amount desc) as "rank" from bank.loan;

-- using row number 
select *, row_number() over (order by amount desc) as "row number" from bank.loan;

select * from bank.order;

-- rank the customers based on the amount of the loan they took in each of the k_symbol categories

select *, rank() over (partition by k_symbol order by amount desc) as "ranks" from bank.order;


-- difference between rank and dense rank and row_number

select * from bank.order;

select order_id, amount, rank() over(order by amount asc) as "rank",
dense_rank() over (order by amount) as "dense rank",
row_number() over (order by amount) as "row number"
from bank.order
where k_symbol<> " ";

-- difference between dense rank and rank

-- comment: the important thing is that if we have repeated values(ties) when transitioning
-- to the next group?window the function rank() skips the ranks according to the rows jumped andstarts back from tha row number
-- dense_rank() does not skip the ranks starting back from the rank it left off from

-- comment: if we do not want the ranking repetition for ties you can use row_number instead

-- end of the recap

-- joins

select * from bank.loan;
select * from bank.account;
select * from district;

select * from bank.account a
join bank.loan l on a.account_id= l.account_id -- inner join using the account_id key
where l.duration=12
order by payments;

-- another example of inner join for 3 tables
-- bank account a
-- bank loan l
-- bank district d

select a.account_id, a.frequency, d.A1, d.A2, l.loan_id, l.amount, l.duration
from bank.account a
join bank.loan l on a.account_id = l.account_id
join bank.district d on a.district_id = d.A1
limit 39;

--


select a.account_id, a.frequency, l.loan_id, l.amount, l.duration, l.payments, l.status
from bank.account a
left join
bank.loan l on l.account_id = a.account_id
order by account_id;

-- right join

select a.account_id, a.frequency, l.loan_id, l.amount, l.duration, l.payments, l.status
from bank.account a
right join bank.loan l on l.account_id=a.account_id
order by a.account_id;

-- full join

select * from district;
select * from account;

select * from account a
left join district d on d.district_id=d.A1
union
select * from account a
right join district d on a.district_id=d.A1;