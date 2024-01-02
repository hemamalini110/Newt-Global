-- control statement

do
$$
	declare
		num int :=10;
	begin
		if num < 0 then
			raise notice 'num is neg';
		elsif num > 0 then
			raise notice 'num is pos';
		else
			raise notice 'num is zero';
		end if;
	end;
	
$$
language plpgsql;

-- unit price range high , low , medium

create or replace function func_pl_unitprice(price real) returns text 
as
$$
	
	begin
		if price > 100 then
			return 'High';
		elsif price > 50 then
			return 'Medium';
		else
			return 'Normal';
		end if;
	end;
	
$$
language plpgsql;

select func_pl_unitprice(p.unit_price) , p.product_id ,p.product_name ,p.unit_price from products p ;

-- case

simple      if choice made from list of values (1,3,5,7)

searched    choose from a range of values (1-20)

-- simple case 
case var
	when check val then
	.
	.
	.
	else
end case;

do
$$
	declare
		num int :=10;
	begin
		case num
			when  0 then
				raise notice 'num is 0';
			when  10 then
				raise notice 'num is 10';
			else
				raise notice 'num is unknown';
		end case;
	end;
	
$$
language plpgsql;

select * from shippers s 
1--speedy
2--united
3-federal


create or replace function func_pl_ship_name(ship_id int) returns text 
as
$$
	
	begin
		case ship_id
			when  1 then
				return 'speedy';
			when  2 then
				return 'unnited';
			when 3 then
				return 'federal';
			else
				raise notice 'unknown';
		end case;
	end;
$$
language plpgsql

select func_pl_ship_name(o.ship_via),o.order_id ,o.ship_via  from orders o ;


-- searched case
case
	when cond then
	.
	.
	.
	else
end case


do
$$
	declare
		num int :=20;
	begin
		case 
			when  num=0 then
				raise notice 'num is 0';
			when  num=10 then
				raise notice 'num is 10';
			else
				raise notice 'num is unknown';
		end case;
	end;
	
$$
language plpgsql;


create or replace function func_pl_calc_total_price() returns text 
as
$$
	declare 
		total real ;
	    order_type text;
	begin
		select sum((unit_price * quantity)-discount) from order_details o
		into total
		where order_id=10248;
		order_type:=case 
			when total > 300  then
				'platinum'
			when  total > 200 then
				'Gold'
			else
				'Silver'
		end case;
		return order_type;
	end;
$$
language plpgsql;

select func_pl_calc_total_price();

-- LOOP

loop
	statement
	exit
end loop

loop
	statement
	exit when cond met
end loop

loop
	statement
	if cond
		exit
	end if
end loop

-- simple counter

do
$$
	declare
		num int :=0;
	begin
		loop
			raise notice 'num value is %',num;
			num=num+1;
			exit when num =10;
		end loop;
	end;
	
$$
language plpgsql;

do
$$
	declare
		num int :=0;
	begin
		loop
			raise notice 'num value is %',num;
			num=num+1;
			if num=5 then
				raise notice 'Reached 5';
			    exit;
			end if;
		end loop;
	end;
	
$$
language plpgsql;


-- FOR LOOP

for var_name  in [reverse] [start..end] [by stepping]
loop 
	
end loop


do
$$
	declare
		num int ;
	    sum int :=0;
	begin
		for num in 1..5 by 1
		loop
			sum=sum+num;
			num=num+1;
		end loop;
	raise notice 'sum %',sum;
	end;
	
$$
language plpgsql;

-- for loop iterate over result list

do
$$
	declare
		rec record;
	    counter int :=1;
	begin
		for rec in select order_id, customer_id from orders limit 20
		loop
			raise notice '%. order id % customer id %',counter,rec.order_id, rec.customer_id;
			counter=counter+1;
		end loop;
	end;
$$
language plpgsql;

-- continue when even counter

do
$$
	declare
		rec record;
	    counter int :=0;
	begin
		for rec in select order_id, customer_id from orders limit 20
		loop
			
			counter=counter+1;
		    continue when mod(counter,2) =0;
		   raise notice '%. order id % customer id %',counter,rec.order_id, rec.customer_id;
		end loop;
	end;
$$
language plpgsql;

-- foreach var in array arr

do
$$
	declare
		arr int[] := array[1,65,68,2,3];
		var int ;
	begin
		foreach var in array arr
		loop
			raise notice '% .. ',var;
		end loop;
	end;
$$
language plpgsql;

-- while loop

do
$$
	declare
		var int :=1;
	    sum int:=0;
	begin
		while var <= 5
		loop
			sum=sum+var;
			var=var+1;
		end loop;
		raise notice 'sum %',sum;
	end;
$$
language plpgsql;


-- return query

create or replace function func_pl_return_query(total_sales int) returns setof  products as
$$
	begin
		return query 
		select * from products 
		where product_id in
		(
			select product_id from 
			(
		       select p.product_id, sum(p.unit_price)
		       from products p
		       group by product_id
		       having  sum(p.unit_price ) > total_sales
		     ) as filter_products
		 );
	end;
	
$$
language plpgsql;


select * from func_pl_return_query(50);


-- return table

create or replace function func_pl_return_table(pattern varchar(10)) 
returns table (product varchar , price real)
as
$$
	begin
		return query 
		select product_name , unit_price from products 
		where product_name like pattern;
	end; 
	
$$
language plpgsql;


select * from func_pl_return_table('A%');

-- return next

create or replace function func_pl_return_next(pattern varchar(10)) 
returns setof  products
as
$$
	declare 
		products record;
	begin
		
		for products in select * from products where product_name like pattern
		loop
			return next products;
		end loop;
		return ;
	end; 
	
$$
language plpgsql;


select * from func_pl_return_next('A%');



























