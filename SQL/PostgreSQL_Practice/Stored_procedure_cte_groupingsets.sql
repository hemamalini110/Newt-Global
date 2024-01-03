---- Function vs Stored Procedures

user-defined func does not support transaction.
stored procedure support transaction.

function return a value
stored procedure does not return a value , inout use return to stop immediatelty

call store_prcedure;

may or may not have paramter

with parameter called dynamic , without parameter called static.

declare part is optional

-- create stored procedure

create or replace procedure proc_name(para..)
as 
$$
	declare 
	
	begin
		
		
	end;
	
$$
language plpgsql;



-- TRANSFER AMOUNT FROM ONE TO OTHER ACCOUNT

create table public.accounts
(
	id serial primary key,
	name text,
	balance dec
);

insert into accounts (name,balance) values ('aaa',2000),('bbb',3000);

select * from accounts;

create or replace procedure proc_money_transfer(sender int , receiver int, amount dec)
as 
$$
	begin
			
		update accounts set balance = balance-amount where id=sender;
	
		update accounts set balance = balance+amount where id=receiver;
		commit;
	end;
	
$$
language plpgsql;

call proc_money_transfer(1,2,100);


---Returning from SP
create or replace procedure proc_return_total_orders(inout total_count integer default 0)
as 
$$
	begin 
		select count(*) from into total_count "Northwind".orders;
	end;
	
$$
language plpgsql;

call proc_return_total_orders();

--- USE OF SP

	simplify the complex operation by encapsulating into a single unit.
	fully utilize the transaction
	performance - compiled only when created then called
	modularity - multiple times repeating code can be written inside sp , reduce type and potential and can be maintan in future.
	security
	
	
-- drop procedure
	
drop procedure {if exist} procedure_name (arg..)
{restrict (default) | cascade };


--pl/sql
create procedure new_line as query
begin
  dbms_output.put_line('------------------------------------------');
end;

create procedure new_line is
begin
  dbms_output.put_line('------------------------------------------');
end;
	

------common table expressions 

The CTE is used as a temporary result set that the user can reference within another SQL statement like SELECT, INSERT, UPDATE or DELETE.
CTEs are temporary in the sense that they only exist during the execution of the query.
CTEs are typically used to simplify complex joins and subqueries in PostgreSQL.
alternative for sub query.

Syntax:
WITH cte_name (column_list) AS (
    CTE_query_definition 
)
statement;

with cte_account as
(
	select * from accounts where id=1
)
select name,balance from cte_account order by balance;

------------------

with cte_store_delete_data_in other_table as
(
	--delete
)
insert into other table and select to display.


----summarization

aggregate the data generally remove the detail data lies below the summarized total. This where subtoatl comes in.
to summarize the data , need grouping set 
grouping sets is a set of column by which we group
roll up is a subclause of the group by clause , for defining 'multiple grouping sets'.

-- roll up similar to group by and also give the sub total for each group and grand total

select name , balance ,sum(balance) as "total"
from accounts a 
group by  
	rollup (balance,name); 
	
	
select name , balance ,sum(balance) as "total"
from accounts a 
group by  name ,
	rollup (balance); -- partial roll up


-- Grouping is function it return either 0 or 1
0-- it does not return subtotal	
1-- it return subtotal	
	
select name , balance ,sum(balance) as "total",
	grouping(name) as "g_name",
	grouping(balance) as "g_balance"
from accounts a 
group by  
	rollup (balance,name); 













