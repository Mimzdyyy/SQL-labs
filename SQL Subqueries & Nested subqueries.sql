use bank;


##subqueries
#exercise 1 return the eows of the table order for all the banks in whcih the average amount that was transfered is higher than 5500

select * from bank.order;

select * from trans;
## select * from(....)
-- step1
select bank, avg(amount) as average_amount from bank.trans
group by bank
having average_amount > 5500; -- ST, UV, GH
-- hard coded solution
select * from bank.order
where bank_to in ("ST", "UV", "GH");


-- step 2 filter the results of order rable with the subquery of step1

select * from bank.order
where bank_to in(
select bank from(
select bank from trans
where bank <> " "
group by bank
having avg(amount)>5500
)sub1
)
and k_symbol <> " " and k_symbol<> " ";

## exercise 2 return the eows in the transactions table with the k_symbol whose average amount is bigger than 3300

#step 1 return the k_symbol with the average amount bigger than 3300
select k_symbol from bank.order
where k_symbol<> ""
group by k_symbol
having avg(amount)> 3300; -- result: SIPO,UVER

-- simple answer:
select * from bank.trans where k_symbol in ("SIPO", "UVER");
-- apply the subquery straight forward

select * from bank.trans
where k_symbol in (
select k_symbol from bank.order
where k_symbol <>""
group by k_symbol
having avg(amount) > 3300
); -- it takes forever and it might close your mysql connection

-- (step 3) alternative solution for sake of performance

select* from bank.trans
where k_symbol in(
 select k_symbol as symbol from(
  select k_symbol from bank.order
   where k_symbol <> "" and k_symbol <> ""
    group by k_symbol
     having avg(amount) > 3300
     )sub1
     );
     
     ##COMMENT: FROM VS #a subquery in the IN STATEMENT will operate for very row
     # if we followe the step 2 we will be doing the whole operation for every row
     # if we keep the subquerry of step it will be comparing with only "SIPO" and "UVER" because the inner query in the FROM STATEMENT will only run once:
     
   #ssubquery in FROM STATEMENT
   # EXAMPLE: return the rows where the total order amount per account_id is higher than 1000.
   
   select * from bank.order;
   
-- step 1 start the query
select account_id, sum(amount) as total
from bank.order
group by account_id
having sum(amount) >10000;

-- step 2 putting the query together

select * from bank.order
	where account_id in(
    select account_id 
    from(
    -- enter the complete subquery which gives two columns
    select account_id, sum(amount) as total
    from bank.order
    group by account_id
    having sum(amount) > 10000
) sub1
);

## excercise: for each duration of a loan, find the status with the highest total amount

#one way
select * from bank.loan;
select distinct duration from loan; -- # duration '12''36''60''24''48'


-- step 1: start the query
select duration, status, sum(amount) total from bank.loan
group by duration, status
order by duration, status;

-- you notice that you'll have to use the previous query as a table in a new query

-- step 2: start the main query / use the previous query as the table (subquery)
select *, row_number() over (partition by duration order by total desc) 
from (
	select duration, status, sum(amount) total from bank.loan
	group by duration, status
	order by duration, status
    ) as sub;

#second way
select *, row_number() over (partition by duration order by total desc) as ranking
from (
    select duration, status, sum(amount) total from bank.loan
	group by duration, status
	order by duration, status
    ) as sub1;

-- step 3: final query
select duration, status, total from(
select *, row_number() over (partition by duration order by total desc) as ranking
      from (
        select duration, status, sum(amount) total from bank.loan
		group by duration, status
	    order by duration, status
        )sub1
)sub2
where ranking=1;

# Correlated Subqueries
-- return the loans whose amounts are greater than the average, within the same status group:
-- (we want to find those averages by each status group and simultaneously compare the loan amount with its status group's average)

-- step 0:
select status, avg(amount) from bank.loan
group by status;

-- step 1: customers whose loan amount was greater than the average
#select * from bank.loan where amount > ();

-- step 2: get the average
select * from bank.loan
 where amount > (
select avg(amount)
from bank.loan)
order by amount;

-- step 3: put them together
select * from bank.loan
where amount > (
	select avg(amount)
	from bank.loan
);

select avg(amount) from bank.loan #checkpoint for mental health of the next query
-- but we are comparing with the total avg, instead of avg per status

-- step 4: add the correlated condition

select * from bank.loan as l1
where amount > (
  select avg(amount) from bank.loan
  where status = l1.status
);

#comment: in the inner query runs an A it picks the average of status A and compares it with the main quert with the put where
#         if the inner picks B it picks the average of class status B and compares in the same way as with A
