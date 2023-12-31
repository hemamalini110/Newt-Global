
One of the advantages of using a programming language is that it allows us to automate repetitive, boring tasks.
For example, if you have to run the same query every day or month to update the same table, sooner or later
you'll search for a shortcut to accomplish the task. The good news is that shortcuts exist in PostgreSQL! and it is
called a 'View'.

You can save your query into a view. so instead of writing long queries, you can just refer to a view.

* A view is a database object that is of a 'stored query'.

A view is a virtual table you create dyn cally usin a saved query acting as a 'virtual table¹.

Views help to encapsulate queries and logic into reusable PostgreSQL database objects that will
speed up your workflow.

Views are like do not  Repeat Yourself!

Similar to a regular table, you can;

query a view,
join a view to regular tables (or other views), and
use the view to update or insert data into the table it's based on, albeit with some caveats.

==  Please note that a regular views do not store any data except the materialized views".  ==

How views are useful ?

	1. avoid duplicate efforts
	2. reduce the complexity
	3. also perform abstraction by limiting the columns to the different audience and authorize user
	4. grant permission for view like tables
'
syntax to create view

create or replace view view_name 
as 
query ( select with subquery , joins ,anyquery that should display some result col);

-- create view for view_movie_director

create or replace view view_movie_director 
as
select m.movie_id ,m.movie_name ,d.first_name ,d.last_name 
from movies m join directors d using (director_id); 

--use view

select * from view_movie_director

-- rename view

alter view view_movie_director rename to view_movie_director_details;

select * from view_movie_director_details 

-- delete view

drop view view_name;

create view view_for_drop as select movie_id from movies m ;

drop view view_for_drop ;

-- filter with view ( this can be perform with union and filter )

create or replace view view_movie_releasedate_greaterthan_1997 
as
select movie_id, movie_name , release_date from movies m 
where release_date > '1997-12-30'
order by 3 asc

select * from view_movie_releasedate_greaterthan_1997 

-- filter the movie_name starts with H

select * from view_movie_director_details vmdd  
where movie_name like 'H%';

-- connecting multiple cols with views

create or replace view view_movies_directors_revenues
as
select * from movies m 
inner join directors d using (director_id)
inner join movies_revenues mr  using (movie_id);

select * from view_movies_directors_revenues 
where revenues_domestic > 400;

-- delete and re arrange the col in view

by rename the existing view to view_old
then create a new view 

or 

rename the existing view to view_old
then duplicate and delete the old one

-- add col to existing view

create or rename view view_nmae as query

Here rename is used to add changes to view if already exists else create view
-- important -- the order should be same as previous append only at the end


-- regular views are dynamic

1. It doesnot store data physically
2. whenever the changes made in base table it will also updated in view table also
3. any changes (update , insert , delete....)


-- updateable view

insert , delete , update and  where clause on view it also reflect in table

u v should have only one from entry from the table or updatable  view

it should not contain agg , order by limit , returning , distinct ....

user have previlege to perform update on view no need to have previlege for table.

--create updatable view
create view view_update_movie_details
as select movie_id, movie_name  
from movies m ;

-- insert via view

insert into view_update_movie_details (movie_id,movie_name) values (212,'War'),(343,'Leo');

-- display via view

select * from view_update_movie_details ;
select * from movies m 

-- update via view

update view_update_movie_details set movie_name ='Kaithi' where movie_id=212;

-- delete via view

delete from view_update_movie_details where movie_id = 343

-- with-check option
it ensure that the values added via view satify the view-defining condition
it throw exception it condition is violated by insertion or updation

create or replace view view_update_withcheckpt_movie_lang
as
select * from movies m 
where movie_lang='English'
with check option ;

select * from view_update_withcheckpt_movie_lang 

-- violate the view condition by insert and update
insert into view_update_withcheckpt_movie_lang (movie_id,movie_lang) values (73,'Spanish');

update view_update_withcheckpt_movie_lang set movie_lang='Korea' where movie_id=1;



-- nested view and use local and cascade check option

create view nested_view_directors_details
as
select 
	movie_id , movie_name from view_update_movie_details vmdd 
where movie_name like 'K%'
with local check option;

it only check the condition satisfy the current view(outer view) 
if satify add in view and table also
else not satify then add into table only

-- ------------------------------

create view nested_view_directors_details
as
select 
	movie_id , movie_name from view_update_movie_details vmdd 
where movie_name like 'K%'
with cascade check option;

it check the condition satisfy the both inner and outer view 
if satify add in view and table also
else not satify then add into table only


/*

CREATE RULE insert_in_nested AS ON INSERT TO movies
             DO INSTEAD
             INSERT INTO nested_view_directors_details (movie_id,movie_name) VALUES (new.movie_id,NEW.movie_name);
 
insert into insert_in_nested values(90,'Keo');
 
*/

-- Materialized view

1. store the result of the query physically
2. update periodically

normal view give the fresh data from table and performance time is high
material view give the data from cache so the performance time is low

3. need to refresh each time whenever update made in base table that should reflect in materialized view
4. can not perform crud operation in materialized view
5. the base table is locked when the refresh is running

create materialized view mv_movie
as 
select movie_id,movie_name from movies m 
with no data;

select * from mv_movie   -- error wll throw if we display the unpopulaed mv

--materialized view "mv_movie" has not been populated
--Hint: Use the REFRESH MATERIALIZED VIEW command.

REFRESH MATERIALIZED VIEW mv_movie 

select * from mv_movie 

-- drop materialized view

drop materialized view view_name;

-- cannot perform update in mv

insert into mv_movie (movie_id,movie_name) values (78,'lhsj');
--cannot change materialized view "mv_movie"

update by change the data in base table then refresh the mv

-- check the mv is populated or not

select relispopulated from pg_class where relname='mv_movie';

-- Refresh the mv

refresh materialized view view_name;

-- Refresh mv with concurrently

concurrently allow to query when refresh is running
with concurrently , postgresql create a temp updated version of mv compare 2 version and perform updation and insertion only instead of creating new mv
one thing have to made to perform concurrently , mv must have unique index

refresh materialized view concurrently mv_movie 
-- Hint: Create a unique index with no WHERE clause on one or more columns of the materialized view.

create unique index idx_u_mv_movie_movie_id on mv_movie(movie_id)

refresh materialized view concurrently mv_movie --work perfectly

-- Downside of mv

It is dependent on base table so need to manage the mv whenever the changes made in table.

-- List all mv 

select oid::regclass::text 
from pg_class
where relkind='m';

/*

Quick queries for materialized views
1. Query whether a materialized view exists:


SELECT count(*) > 0 FROM pg_catalog.pg_class c

JOIN pg_namespace n ON n.oid = c.relnamespace

WHERE

c.relkind = 'm'

AND n.nspname = 'some_schema'

AND c.relname = 'some_mat_view';



2. Query whether a materialized view exists:


SELECT view_definition

FROM information_schema.views

WHERE

table_schema = 'information_schema'

AND table_name = 'views';



3. To list all materialized views:


select * from pg_matviews;

select * from pg_matviews where matviewname = 'view_name';


*/




















