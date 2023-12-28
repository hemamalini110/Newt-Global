
--COUNT()

select count(*) from movies;

select count(distinct movie_lang) from movies m ;

select movie_lang , count(movie_lang) from movies group by movie_lang ;

select  count(*) from movies where movie_lang ='English';

-- SUM()
-- without distinct
select sum(revenues_international) as "total_revenue_international" from movies_revenues ;

-- with distinct it reduces the row
select sum(distinct revenues_international) as "total_revenue_international" from movies_revenues ;

select sum(revenues_international) as "total_revenue_international" from movies_revenues where revenues_international >100;

--MIN and MAX
--compare the rows in one column numeric values

select max(movie_length) , min(movie_length) from movies m ;

select movie_lang , max(movie_length), min(movie_length) from movies group by movie_lang order by movie_lang asc ;

select movie_lang , max(movie_length), min(movie_length) 
from movies 
where movie_lang ='English' 
group by movie_lang 
order by movie_lang asc ;

--compare the rows in one column character values

select max(movie_name) , min(movie_name) from movies m ;

-- GREATEST() AND LEAST()

select greatest(19,2,46);  -- 46
select least('A','x','G'); -- A
select least('A',10)       -- error


--compare the MULTIPLE column  values

--null is treated as nothing not taken to compare  (22 ,null) max=22 and min=22
select revenues_domestic ,revenues_international ,
greatest(revenues_domestic,revenues_international) as "max_revenue" ,
least(revenues_domestic,revenues_international) as "min_revenue"
from movies_revenues mr ;

-- AVG

select movie_lang ,avg(movie_length) from movies group by movie_lang  ;

select age_certificate ,movie_lang ,avg(movie_length) from movies group by movie_lang,age_certificate  ;

-- Math expressions

select 10/3::numeric(4,2);

--null is treated as nothing not taken to compare  (22 + null) total=null

select (revenues_domestic + revenues_international) as "total_revenue" from movies_revenues mr  ;




