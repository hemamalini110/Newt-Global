-- functions

-- sql
create or replace function func1 (int , int ) returns int as 
'
	select $1+$2;
'
language sql;

select func1(2,3);
select func1(88,12)

-- plpgsql

create or replace function func1 (int , int ) returns int as 
$$
declare

	begin
		return $1+$2;
	end;
$$
language plpgsql

select func1(8,2)

-- declare variables via alias
-- newname alias for oldnmae

create or replace function func1_pl_sum (int , int ) returns int as 
$$
declare
    x alias for $1;
    y alias for $2;
   add int;
	begin
		add := x+y;
	   return add;
	end;
$$
language plpgsql;

select func1_pl_sum(3,2);

-- void function which does not return nothing

create or replace function func_null_country() returns void  as 
$$
	update employees set region=NULL where region='N/A';
$$
language sql;

select func_null_country()

select * from employees

-- function return single value 

-- from table min or max

create or replace function func_max_price_product() returns real  as 
$$
	select max(unit_price) from products
$$
language sql;

select func_max_price_product();


create or replace function func_pl_max_price_product() returns real  as 
$$
		begin
			return  max(unit_price) from products;
		end;
$$
language plpgsql;

select func_pl_max_price_product();

-- from table total products

create or replace function func_total_product() returns int  as 
$$
	select count(*) from products
$$
language sql;

select func_total_product();

-- from table total customer with empty fax number

select * from customers c 

create or replace function func_customer_empty_fax() returns int  as 
$$
	select count(*) from customers where fax is null;
$$
language sql;

select func_customer_empty_fax();

-- function with paramter

create or replace function func_substring ( string varchar, startpoint int ) returns varchar as 
$$
	select substring(string,startpoint);
$$
language sql;

select func_substring('PostgreSQL Course',8);

-- pass city paramter to get total customers
create or replace function func_total_cust_by_city (p_city varchar ) returns int as 
$$
	select count(*) from customers where city=p_city;
$$
language sql;

select func_total_cust_by_city('London');

-- get total order by customer

create or replace function func_total_order_by_cust (p_customer_id varchar ) returns int as 
$$
select count(*) from customers inner join orders using(customer_id)  where customer_id =p_customer_id;
$$
language sql;

select func_total_order_by_cust('WARTH');


-- function returning composite
-- return a single row in the form of array

create or replace function func_composite_orders() returns orders as 
$$
select * from orders order by order_date desc ;
$$
language sql;

-- result in array (func()).* 
-- return particular feild (func()).feild_name
select (func_composite_orders()).order_date;

-- func_orders_placed_in_date_return_as_table
-- order matters

create or replace function func_orders_placed_in_date_return_as_table() returns table ( order_id int,customer_id bpchar,order_date date) as 
$$
	select orders.order_id ,
		orders.customer_id ,
		orders.order_date  from orders where order_date='1998-05-06' ;
$$
language sql;

select (func_orders_placed_in_date_return_as_table()).*;

select (func_orders_placed_in_date()).customer_id;

-- function returning multiple rows
-- orders placed in date -> 1998-05-06
create or replace function func_orders_placed_in_date() returns setof orders as 
$$
select * from orders where order_date='1998-05-06' ;
$$
language sql;

select func_orders_placed_in_date();

select (func_orders_placed_in_date()).customer_id;

-- -- - - -----------------------

-- table as source function

select * from func_orders_placed_in_date() where ship_country='USA';


-- (VAR_NAME TYPE DEFAULT VALUE) IN PARAMETER

create or replace function func_products_stock_range(stock_range int , p_limit int default 2) 
returns table 
(
	product_id int,
	product_name varchar,
	units_in_stock int
) as
$$

	select products.product_id ,
		   products.product_name ,
		   products.units_in_stock from products where (units_in_stock >= stock_range) limit p_limit;

$$
language sql;

select * from func_products_stock_range(12,20);


PL/pgSQL

1. pl/pgsql is a powerful scripting language developed by oracle
2. full-fledged sql dev language
3. originally designed for  simple scalar function 
	controls
	loops
	variable declaration
	cursors
	expression 
4. ability to create 
	complex query
	Store procedure
	new data type
5. used for performance optimization in intensive data

sql vs pl/pgsql

1. wrap multiple query into single function block is called as objects
2. instead of sending multiple statements to server run as single object 
3. call the object is enough to execute the multiple statement 
4. provide transactional integerity
5. reduced round trips to server

do
$$
	declare
	    my_num int :=12,
	    my_name bpchar :='Hema';
	begin
		raise notice 'Number %',my_num;
	end;	
$$
language plpgsql;

do
$$
	declare
	    my_num int :=12;
	    my_name varchar(22):='Hema';
	    my_dob date :='2001=10-11';
	begin
		raise notice ' My name % My my_num % My Dob %',my_name,my_num,my_dob;
	end;	
$$
language plpgsql;

drop function func_pl();

-- copy col datatype to variable
var_name tablename.colname%type;

prod_name products.product_name%type;


-- Assigning var from query


select * from products into product_row limit 1;
select product_row.product_name into prod_name;


do
$$
declare
	prod_name products.product_name%type;
begin
	select product_name  from products where product_id =1 into prod_name;
    raise notice 'Product name % ',prod_name;
end;
$$
language plpgsql;

-- variable with in and out

create or replace function func_pl_add_prod (in x int ,in y int,out add_ int, out prod_ int ) as 
$$
declare

	begin
		add_ :=x+y;
		prod_ :=x*y;
	end;
$$
language plpgsql;

select func_pl_add_prod(8,2);
select (func_pl_add_prod(8,2)).*;

























