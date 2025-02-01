--------------  SELECT STATEMENT-----------------------

select *from actor

select first_name from actor

select first_name,last_name from actor

select *from customer

select store_id,first_name,last_name from customer

--------------------------------------------------------------------------------------------

------------------------------  ORDERBY STATEMENT ----------------------------

select *from actor

select first_name from actor order by first_name desc

select first_name,last_name from actor order by first_name desc,last_name asc

select first_name,last_name from actor order by 1 desc,2 asc 

---------------------------------------------------------------------------------------------

-------------- DISTINCT KEYWORD-------------------------

select *from film

select distinct rating from film

select distinct rating,rental_duration from film

select distinct rating,rental_duration from film order by rating asc

----------------------------------------------------------------------------------------------

----------------------- LIMIT KEYWORD-------------------------------------

select *from actor

select first_name from actor order by first_name desc

select first_name from actor  order by first_name desc limit 4

----------------------------------------------------------------------------------------------

--------------------------- COUNT FUNCTION --------------------

select count(*) from actor

select count(distinct first_name) from actor

-----------------------------------------------------------------------------------------------

-----  WHERE KEYWORD ------------------

select *from payment where amount=0

select count(*) from payment where amount=0

select first_name,last_name from customer where first_name='ADAM'

select *from payment where amount > 10

select *from payment where amount > 10 order by amount desc

select *from customer where first_name is null

select count(8) from rental where return_date is not null

select *from payment where amount = 10.99 or amount = 9.99

select *from payment where amount = 10.99 or (amount = 9.99 and customer_id=426)

select *from payment where (amount = 10.99 or amount = 9.99) and customer_id=426

select *from payment where (customer_id = 32 or customer_id=346 or customer_id=354)
and (amount<2 or amount>10) order by customer_id desc, amount asc

--------------------------------------------------------------------------------------------------------

------------------------------------- BETWEEN KEYWORD -------------------------------------------
----- Used to filter a range of values---------------

select payment_id,payment_date from payment where amount between 1.99 and 6.99

select *from rental where rental_date between '2025-05-24' and '2025-05-26' 
order by rental_date

---------------------------------------------------------------------------------------------------

--------------------------- IN KEYWORD  --------------------------------------------

select *from customer where customer_id in (123,212,313) 

----------------------------------------------------------------------------------------------------

--------------------------------- LIKE --------------------------

---------- USed to filter by matching aganist a pattern--------------------------

select *from actor where first_name like '_A%'

select *from actor where first_name like '__A%'

select *from actor where first_name like '___A%'

select *from actor where first_name like '%A%'

select *from actor where first_name like '%_A%'

--------------------------------------------------------------------------------------------

----------------- COMMENTS AND ALIAS -----------------------------------

--- SINGLE LINE COMMENTS

/*     
--MULTIPLE LINE COMMENTS
*/

-----------------------------------------------------------------------------------------------

--------------- AGGREGATE FUNCTIONS---------------------------------

-------------- AGGREGATE VALUES sum(),avg(),min(),max(),count() --------------------------

-------- DONT USE COLUMN NAMES ALONG WITH AGGREGATE FUNCTIONS IF WE WANT USE GROUBY ------------

select sum(amount) from payment

select sum(amount),count(*),avg(amount) from payment

select min(replacement_cost),max(replacement_cost), round(avg(replacement_cost),2) as avg,
sum(replacement_cost)
from film

--------------------------------------------------------------------------------------------------


------------------------ GROUPBY STATEMENT ------------------------------------------------

-------- IF WE WANT TO USE COLUMNNAME ALONG WITH GROUPBY WE NEED TO USE GROUPBY MUST AND SHOULD  ------------------

select customer_id,sum(amount) from payment group by customer_id

select customer_id,sum(amount) from payment where customer_id >3 group by customer_id

select customer_id,sum(amount) from payment where customer_id >3 
group by customer_id order by sum(amount) desc


-------------------------------------------------------------------------------------------------

---------------------- USING MULTIPLE GROUPBY COLUMNNAMES -----------------------

 select staff_id,customer_id,sum(amount),count(*) from payment
 group by staff_id,customer_id order by count(*) desc


---------------------------------------------------------------------------------------=-------

 ------------------------------------- HAVING STATEMENT -----------------------------------

 ----- USED TO FILTER GROUPING BY AGGREGATIONS -----------------

 select customer_id,sum(amount) from payment group by customer_id having sum(amount)>200

 select customer_id,Date(payment_date),round(avg(amount),2) as avg_amount,count(*) from payment
 where date(payment_date) in ('2024-04-28','2024-05-28') 
 group by customer_id,date(payment_date) order by 3 desc

 ------------------------------------------------------------------------------------------------
 

 ------------------ STRING FUNCTIONS (LENGTH,LOWER,UPPER) ----------------------------------------

select upper(email) as email_upper,email,length(email),lower(email) as lower_email from customer
 ---here the column in the database is not effected----

------------------------------------------------------------------------------------------------------


 ---------------- INORDER TO EXTRACT SOME PART IN THE STRING WE USE """"LEFT,RIGHT""" statements---------

 select left(first_name,2),first_name from customer

select right(left(first_name,2),1),first_name from customer 


---------------------------------------------------------------------------------------------------


------------- CONCATENATE USED FOR CONCATENATE TWO STRINGS ---------------------

select left(first_name,1) || left(last_name,1),first_name,last_name from customer

select left(first_name,1) || '.' || left(last_name,1)||'.' as intials,
first_name,last_name from customer

-----------------------------------------------------------------------------------------------


--------- "POSITION" TELLS THE POSITION OF THE SPECIFIED STRING OR COLUMN ---------------

select position('@' in email), email from customer

select left(email,position('@' in email)), email from customer


------------------------------------------------------------------------------------------------------


--------- SUBSTRING USED TO EXTRACT SUBSTRING FROM A GIVEN STRING ------------------------------

--SYNTAX-----

---       substring(string from start [for length])-----
--- string ----> columnname or string 
--- start-------> the position of the string we need to start
--- length ------> specifies how much length till we need to get the substring
select substring(email from position('.' in email)+1 for length(last_name)) from customer

select substring(email from position('@'in email)) from customer


--------------------------------------------------------------------------------------------------


-------- Extract USED TO EXTRACT PARTS OF TIMESTAMP/DATE ----------------------

select extract(day from rental_date), count(*) from rental group by extract(day from rental_date)
order by count(*) desc

---------------------------------------------------------------------------------------------

------- TO_CHAR USED TO GET CUSTOM FORMATS SUCH AS TIMESTAMP/DATE/NUMBERS ----------------
---- OUTPUT IS AS PLAIN TEXT --------------------------------

select *,extract(month from payment_date),TO_CHAR(payment_date, 'day') from payment

------------------------------------------------------------------------------------------------


--------- MATHEMATICAL FUNCTIONS -----------------------------------

select
abs(-7),2+3,round(4.33345,2),ceiling(4.4312),floor(3.1234567)

select *from film

select film_id,rental_rate as old_rental_rate,rental_rate+1 as new_rental_rate from film

------------------------------------------------------------------------------------------------------

---------------- CASE STATEMENT ------------------------------------------------------------

select
amount,
case
when amount<2 then 'low amount'
when amount<5 then 'medium amount'
else 'high amount'
end
from payment


select
to_char('book_date','dy')
to_char('book_date','dy')
case
when to_char('book_date','dy')=='mon'
then 'monday is special'
when to_char('book_date','mon')=='jul'
then 'july special'
end
from bookings

-- result of first true condition is taken into consideration in case statement ---------
---- result if no condition met and no else condition then output is null ----------

select rating from film

select rating,sum(case when rating in('PG','G') then 1 else 0 end)
from film group by rating

---------------------------------------------------------------------------------------------------

------------------------- COALESCE ------------------------------------------------------------

--- RETURNS FIRST VALUJE OF A LIST OF VALUES WHICH IS NOT NULL ------

--select coalesce(actual value [if actual value is null],'alternate value in this is printed')--

select coalesce(actual_scheduled,'0:00')
from flights

------------------------------------------------------------------------------------------------

------------- CAST ----------------------------------------------------

---- changes the datatype of a value --------------------------------------

select coalesce(cast(actual_schedule as varchar),'not arrived') from flights

----------------------------------------------------------------------------------------------------

--- REPLACE IS USED TO REPLACES TEXT FROM A STRING IN A COLUMN WITH ANOTHER TEXT ----------------------

select replace(passenger_id, '',11)from tickets

-------------------------------------------------------------------------------------------------

------- JOINS COMBINING MULTIPLE TABLES _------------------------

--------------- INNER JOIN -------------------------------------------------------------------

----------- WE NEED COMMON COLUMN/ REFERENCE COLUMN IN INNER JOIN ------------------------

---------- IN INNER JOIN  ONLY COMMON ROWS TAKEN UNCOMMON ROWS LEFT --------------------

------  ORDER OF TABLES IS NOT THAT IMPORTANT -------------------

-------------- IF THE COLUMN NAME IS PRESENT IN BOTH THE TABLES WE NEED TO REFERENCE ALIAS TO CALL THE PARTICULAR COLUMNS-------------

select *from payment inner join customer on payment.customer_id=customer.customer_id

select payment_id,pa.customer_id,amount,first_name,last_name from payment pa inner join customer cu on pa.customer_id=cu.customer_id

select payment.*,first_name,last_name from payment inner join customer on payment.customer_id = customer.customer_id
--- HERE first_name,last_name is present in only one  table of customer so need to give reference of that table----------

select payment.*,first_name,last_name,email from payment inner join staff on staff.staff_id=payment.staff_id
where staff.staff_id=1
------- HERE staff_id present in 2 tables so we give reference in where condition ----------------------

--------------------------------------------------------------------------------------------------------------------------------------

---------------------- FULL OUTER JOIN ---------------------------------------------------

----------------- IN THIS ALL THE ROWS FROM BOTH TABLES COME IN PLACE OF UNAMTCHED OR UNIDENTIFIED BECOMES NULL VALUES ----------

select *from boarding_passes b full outer join tickets t on b.ticket_no = t.ticket_no
where b.ticket_no is null

------------------------------------------------------------------------------------------------------------------------------------

------ LEFT JOIN / LEFT OUTER JOIN -------------------------------------------------------------------------------------

---- THE ROWS IN COMMON AND LEFT TABLE ALL ROWS ARE TAKEN ONLY UNMATCHED / DISSIMILAR ROWS IN THE RIGHT NOT TAKEN ----------------

select s.seat_no,count(*) from seats s left join boarding_passes b
on s.seat_no=b.seat_no group by s.seat_no order by count(*) desc

select right(s.seat_no,1),count(*) from seat s inner join boarding_passes b on 
s.seat_no=b.seat_no group by right(s.seat_no,1) order by count(*) desc

-----------------------------------------------------------------------------------------------------------------------------------------

--------------- RIGHT JOIN / RIGHT OUTER JOIN ----------------------------------------------------------------------------------

---- SAME ROWS AND ALL RIGHT ROWS ARE INCLUDED ONLY DISSIMILAR LEFT ARE NOT INCLUDED -------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------

----------------- MULTIPLE JOIN CONDITIONS ----------------------------------

-- IF WE WANT TO USE TWO COLUMNS AS REFERENCE TO  JOIN TABLES --------------------------------

select seat_no,fround(avg(amount),2) from boarding_passes left join ticket_flights t 
on b.ticket_no= t.ticket_no and b.flight_id=t.flight_id
group by seat_no order by 2 desc

---------------------------------------------------------------------------------------------------------------------------------------

------- JOINING MULTIPLE TABLES ---------------------------------------------------

select employee,co.country from sales s 
inner join city ci on s.city_id=ci.city_id
inner join country co on ci.country_id=co.country_id

----------------------------------------------------------------------------------------------------------------------------------------

------ UNION --------------------------------------------------

---- IN UNION DUPLICATES ARE DECOUPLED MEANS DUPLICATES ARE REMOVED --------------------

---- UNION ALL USED TO ALLOW DUPLICATES ALSO ---------------------

---------****NOTE***** THE ORDER OF COLUMN MATTERS IN UNION ----------------------------

select first_name from actor 
union
select first_name from customer
order by first_name

select first_name , 'actor' from actor
union all
select first_name,'customer' from customer
order by first_name

-----------------------------------------------------------------------------------------------------------------------------------

----- SUBQUERY -----------------------------------------

----------- IT MUST ALWAYS BE ENCLOSED IN BETWEEN PARANTHESIS----------------------

------- FIRST THE SUBQUERY IS EXECUTED AD THEN ONLY OTHER IS EXECUTED ----------------------------

select *from payment
where amount>
(select avg(amount) from payment)

select *from payment where customer_id in 
(select customer_id from customer where first_name like 'A%')

select round(avg(total_amount),2) as avg_lifetime_spent
from
(select customer_id,sum(amount) as total_amount from payment group by customer_id) as subquery

select *,'hello' from payment ---- here new column hello is added along with all columns ------

select *,(select round(avg(amount),2) from payment) from payment

select *,(select amount from payment limit 1) from payment   
-- IF WE HAVE MULTIPLE ROWS IN SUBQUERY THE STATEMENT GIVES EEROR SO WE USE LIMIT TO 1 --------------

--------------------------------------------------------------------------------------------------------------------------------------

----- CO-RELATED SUBQUERIES -------------------------------------------------------------------------

--













