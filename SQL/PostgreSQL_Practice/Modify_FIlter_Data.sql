-- select

select * from actors;

select first_name , last_name from actors;

select first_name ||' '|| last_name "Actor_Name" from actors;  -- as is optional

select 5*1;

-- orderby

select movie_name,movie_lang from movies
order by 2;                      -- row number

select movie_name,movie_lang as language from movies
order by language desc;          -- alias

select movie_name,movie_length from movies
order by movie_length;  -- using expression

select movie_name,age_certificate from movies
order by age_certificate nulls  first ;  -- nulls last

-- distinct

select distinct movie_lang from  movies;

select distinct  * from  movies;

-- and or

select movie_name , movie_lang from movies
where movie_lang ='English' and movie_lang = 'Spanish';

-- and or

select movie_name , movie_lang,movie_length from movies
where movie_lang ='English' OR movie_length='168'; -- AND

select movie_name , movie_lang,movie_length from movies
where (movie_lang ='English' OR movie_lang='Japenese') AND movie_length='168'; -- AND OR 

-- IN NOT IN , between  not between

select movie_name, movie_lang from movies
where movie_lang in ('English','Swedish');  -- replace logical operator and , or 

select movie_name , movie_length from movies
where movie_length between 100 and 120;    -- replace comparison operator >=100 and <=120

--limit offset

select * from movies
limit 10;               --show first 10 row starts from index 1

select * from movies 
limit 10 offset 5;      -- show first 10 row starts from index 6 because index of offset is 0 by default

-- fetch similar to limit
-- fetch (first or next) row_count (row or rows) only
-- offset used before or after fetch

select * from movies
order by movie_length desc
-- offset 5 this also applicable
fetch first 10 row only;
offset 5;

--like ilike 

select movie_name from movies
where movie_name like 'E%';      -- starts with E

select movie_name from movies
where movie_name ilike 'e%';      -- starts with e without case-sensitivity (ilike)

-- null not null used in where clause

select * from movies 
where release_date (null);

-- concat using || , concat() , concat_ws(seprator,cols)

select first_name || ' '|| last_name "Actor Name" from actors;

select concat(first_name , ' ', last_name) "Actor Name" from actors;

select concat_ws(' ,' , first_name , last_name, gender) "Actor Name" from actors;









