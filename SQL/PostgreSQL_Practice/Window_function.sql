window function 
--> it compare the current row with all rows in the group.
--> allow to add col to the result set


select region, imports ,exports , avg(exports) over()  as "avg_exports" from trade_data td ;
-- avg of exports show for all rows, so we can compare each export with avg(exports)

over(partition by col or cond)

--avg by group by country
select region, imports ,exports , avg(exports) over(partition by country)  as "avg_exports" from trade_data td ;


--avg by year>2001
select region, imports ,exports , avg(exports) over(partition by year > 2001)  as "avg_exports" from trade_data td ;

update trade_data set 
imports =round(imports/1000000,2),
exports =round(exports/1000000,2);

-- order by with over()
select country,year, exports ,max(exports) over(partition by country order by year)  as "max_exports" 
from trade_data td 
where year>2001;

---current and unbounded preceding (by default) 
1st row compare with itself
2nd row compare with 1, 2
3rd row compare with 1, 2, 3.....

-- sliding dynamic window

it compare the current , preceding 1 and following 1 rows

--min(exports) over(partition by country order by yaer rows between 1 preceding  and 1 following ) as min
select country,year, exports ,
max(exports) over(partition by country order by year rows between 1 preceding  and 1 following)  as "max_exports" 
from trade_data td 
where year>2001;

also give exclude current row

select country,year, exports ,
max(exports) over(partition by country order by year rows between 1 preceding  and 1 following exclude current row)  as "max_exports" 
from trade_data td 
where year>2001;

-- Window frames
it indicates the range of row taken for the aggregate function.

rows or range are indicators.
between start and end value.

unbounded means everything;

---current and unbounded preceding (by default) 
1st row compare with itself
2nd row compare with 1, 2
3rd row compare with 1, 2, 3.....

rows between 0 preceding unbounded following 
current , everything below

rows between unbounded preceding and 0 following 
current , everything above


-----
The PostgreSQL ARRAY_AGG() function is an aggregate function that accepts a set of values and 
returns an array in which each value in the set is assigned to an element of the array.


select *, array_agg(x) over(order by x) from generate_series(1,3) as x;


select *, array_agg(x) over(order by x rows between 0 preceding and unbounded following) 
from generate_series(1,3) as x;


--- row and range

over(range bound everything based on the range value if it is not unique it will repeat the same values )


0  0,0,1,1
0  0,0,1,1
1  0,0,1,1,2
1  0,0,1,1,2
2  1,1,2,3,3
3  2,3,3
3  2,3,3

select *,x/3 as y,
array_agg(x/3) over ( order by x range between 1 preceding and 1 following),
array_agg(x/3) over ( order by x/3 range between 1 preceding and 1 following)
from generate_series(1,10) as x;


-- Window function

select *, agg() over w , agg() over w2 from table 
window w as (partition by order by rows between or range between.....),
window w2 as (partition by order by rows between or range between.....)


-- rank () and dense rank()

rank return no of current row with in the window starts with 1 and include duplicates.
      r    d_r
      
2000   1   1
2000   1   1
2000	1	1
2000	1	1
2001	5	2
2001	5	2
2003	7	3

dense_rank return no of current row with in the window starts with 1 and exclude duplicates.

select region, year , imports ,exports , dense_rank () over( order by year)  as "avg_exports" from trade_data td ;


---- ntile(buckets)
split the rows into equal groups by total/buckets
if it is not divisible by total rows the  split into 2 groups and one is increased by others or decreased
eg : 11 -> 11/2 -> 5 and 6

select region, year , imports ,exports , ntile(4) over( order by year)  as "avg_exports"
from trade_data td
where country='USA'
and year>2001;

-- lead (expression , offset) , lag(expression , offset) 
move lines within the resultset

lag get the previous row data by offset if not exsist then null 
lead get the next row data by offset if not exsist then null

select region, year , imports ,exports , lead(exports,1) over( order by year)  as "lead_exports"
from trade_data td
where country='USA'
and year>2010;

-- if we use the partition lag () get data within the window frame 

select region, year , imports ,exports , lag(exports,1) over(partition by country order by year)  as "lag_exports"
from trade_data td
where country in ('USA','France')
and year>2010;


--- first_value(col), last_value(col) and nth_value(col, nth value)
select region, year , imports ,exports , last_value (exports) 
over(partition by country order by year rows between unbounded preceding and unbounded following)  as "last_exports"
from trade_data td
where country in ('USA','France')
and year>2010;

select region, year , imports ,exports , first_value (exports) 
over(partition by country order by year rows between unbounded preceding and unbounded following)  as "last_exports"
from trade_data td
where country in ('USA','France')
and year>2010;

select region, year , imports ,exports , nth_value (exports,4) 
over(partition by country order by year )  as "last_exports"
from trade_data td
where country in ('USA','France')
and year>2010;


--- row_number()
it is used to assign a unique integer number to each row in result sets.

get 4th  country in export

select * from (
select country ,year, exports, row_number() over(partition by country order by year) from trade_data td 
) as t 
where row_number = 4;

--- correlations
compare the 2 values and return the correlation between 1 and -1.
method of determining the strength of the relationship between two numbers or two sets of numbers.

+ve -> one up and one up
-ve -> one up and one down

select country , corr(exports,imports)
from trade_data td 
group by country
order by 2 desc nulls last;


