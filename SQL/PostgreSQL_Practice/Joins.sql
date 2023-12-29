--inner join with using
-- only the same col present in both tables

-- combine 2 table
select m.director_id ,d.first_name ||' ' || d.last_name as "DirectorName" ,m.movie_name ,m.movie_length ,m.movie_lang  
from movies m  inner join directors d 
using (director_id)
order by movie_lang ;

--- combine 3 table
select m.director_id ,d.first_name ||' ' || d.last_name as "DirectorName" ,m.movie_name ,m.movie_length ,m.movie_lang, mr.revenues_domestic
from movies m inner join directors d
using (director_id)
inner join movies_revenues mr
using(movie_id)
order by director_id ;

-- inner join with filter 
select m.director_id ,d.first_name ||' ' || d.last_name as "DirectorName" ,m.movie_name ,m.movie_length ,m.movie_lang, mr.revenues_domestic
from movies m inner join directors d
using (director_id)
inner join movies_revenues mr
using(movie_id)
where m.movie_lang in ('English','Chinese') and mr.revenues_domestic > 200
order by director_id ;

--top 5 movies
select m.director_id ,d.first_name ||' ' || d.last_name as "DirectorName" ,m.movie_name ,m.movie_length ,m.movie_lang, 
(mr.revenues_domestic + mr.revenues_international) as "Total_revenue"
from movies m inner join directors d
using (director_id)
inner join movies_revenues mr
using(movie_id)
where m.movie_lang in ('English','Chinese') and mr.revenues_domestic > 200
order by 6 desc nulls last
limit 5;

-- join different data type column using cast 
t1-> col -> int
t2-> col -> varchar
select * from t1 inner join t2 on t1.col1=t2.col2::int ;






-- self join join the col in same table with same col name
--select * from self_table t1 inner join self_table t2 on t1.col1=t2.col2 ;

-- list the movie have same movie_length
select m1.movie_name , m2.movie_name , m1.movie_length 
from movies m1 
inner join movies m2 
on m1.movie_length = m2.movie_length 
and m1.movie_name  <> m2.movie_name 
order by m1.movie_length desc ;


-- director_id and their movie
select  m1.movie_name ,m2.director_id
from movies m1
inner join movies m2
on m1.movie_id = m2.director_id 
order by director_id 



-- CROSS JOIN 	(m row in t1 cross join n row in t2) =total rows m*n
-- used with shirts and color table each color shirts

create table table1 (id int primary key , prod_name varchar(10) );

insert into table1 values (1,'pen'),(2,'paper'),(3,'Scale');                  -- 3

create table table2 (id int primary key , prod_name varchar(10) );

insert into table2 values (1,'eraser'),(2,'paper'),(3,'Scale'),(4,'gel pen');  -- 4

--method1
select * from table1 , table2;		--12
--method2
select * from table1 cross join table2;       -- order of the table matters
--method 3
select * from table1 inner join table2 on true;



--NATURAL JOIN  by default inner join
--inner ,right,left, full join
--implicity join based on the same col name

select * from table1 natural full join table2;


--append multiple table cols

select coalesce(t1.id,t2.id) as id,
	   coalesce(t1.prod_name,t2.prod_name)  as prod_name
from   table1 t1 full outer join  table2 t2 on t1.id=t2.id;



-- order and number_of_cols should be same for UNION , EXCEPT and INTERSECT
-- UNION remove duplicate 
-- UNION ALL include duplicate


select id , prod_name from table1
union
select id ,prod_name from table2;


-- filter in union
select id , prod_name from table1
where prod_name='pen'

union all

select id ,prod_name from table2
where id between 2 and 3

order by id;


-- union with diff no_of_cols by make the null value cols

create table table3 (id int primary key);

insert into table3 values (1),(2),(6);

select id , prod_name from table1
union 
select id , null as null from table3;



-- intersect common records bt 2 select

select id , prod_name from table1 
intersect
select id , prod_name from table2;

-- except return the first select record which is not in second select

select id,prod_name from table1
except
select id,prod_name from table2;













