
-- sub query 

select * from movies

-- mov name greater than avg mov length
select movie_name, movie_length  from movies m 
where movie_length >
(
	select avg(movie_length) from movies 
);


-- mov name greater than avg mov length of english and order by length desc 
select movie_name, movie_length  from movies m 
where movie_length >
(
	select avg(movie_length) from movies 
	where movie_lang ='English'
)
order by movie_length desc;


-- actors name younger than Douglas Silva
select first_name ,last_name , date_of_birth 
from actors 
where date_of_birth <
(
	select date_of_birth  from actors a where first_name ='Douglas' and last_name ='Silva'
)
order by date_of_birth ;


-- subquery using in
--all movies domestic revenue > 200

select movie_name from movies 
where 
movie_id in
(
	select movie_id 
	from movies_revenues 
	where revenues_domestic > 500
);


--all movies domestic revenue_domes > inter

select movie_name from movies 
where movie_id IN
(
	select movie_id
	from movies_revenues 
	where revenues_domestic > revenues_international
);

--list all directors where their movies made more than the average total revenue of all emglish movie

select director_id , (revenues_domestic+revenues_international) as "total_revenue", movie_lang
from directors  
inner join movies m using (director_id)
inner join movies_revenues  using (movie_id)
where (revenues_domestic + revenues_international) >
(
	select avg(revenues_domestic+revenues_international) as "avg_total_revenue"
	from movies_revenues 
	inner join movies m2 
	using (movie_id)
	where movie_lang='English'
)
order by 2 desc , 1 asc;


-- union without order by
select *
from
(
select first_name , 0 my_order from actors 
union
select first_name , 1  from directors 
)
order by my_order

-- select without from

select 
(
     select max(movie_length) from movies m
)

-- *********************** corelated subquery 
-- corelated subquery is a sub query that contains a reference to a table 
-- postgres evaluate from inside to out side


--- list all movie of above minimum length for each age certification
-- here movies m1 is parent table 

select age_certificate , movie_length  
from movies m1
where movie_length >
(
	select min(movie_length)  from movies m2
	where m1.age_certificate =m2.age_certificate
)
order by age_certificate ;

-- list fname , lname , dob for the oldest actor for each gender

select first_name , last_name , date_of_birth  , gender
from actors a1
where a1.date_of_birth >
(
	select min(date_of_birth)
	from actors a2
	where a1.gender =a2.gender
)
order by 3

--

-- ************* in any all exists

select * from table 1
where col in (select col from table 2);

select * from table 1
where col not in (select col from table 2);

-- comparison operator < ,> = , <>, <=  , >=

select * from table 1
where col = any (select col from table 2);

select * from table 1
where col > all (select col from table 2);

select * from table 1
where exists any (select * from table 2 
                  where condition and table 1.col1 = table 2.col1);
             













