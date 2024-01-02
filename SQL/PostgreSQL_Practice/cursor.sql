/*
 
 1.	sql retrival operation work set of rows  as result set
 2.	It return all the rows that match a sql statement.
 3. There is no way to point a paticular row and get the forward and backward rows.
    This is how relational dbms works.
    
    
 4. Sometimes , it we want to do froward and backward operation there comes "//cursor//".
 5. cursor is a pointer it point to specific row in a table.
 6. cursor is database query store in a dbms server and reterive by select statement.
 7. so cursor enable sql to retrive a single row in a table. 
 8. once the cursor is pointed or stored can perform
     * update   * select 	* delete
 
 But sql doesn't perform the sequence of operation by itself. but sql can retrieve the rows , 
 but the operation should be done by procedural language based on contents.
 
  procedural language
  		-- the code is written as sequence of instruction.
  		-- users have to specify "what to do" and "how to do".
  		-- instructions are excecuted in sequential order to solve problem.
 
  non-procedural language
  		-- Not in a sequential order.
  		-- users have to specify only "what to do" not "how to do"
  		-- It involve the development of the function from other function. 


 cursor reterive the result sets/content and feed into the procedural language for further processing.

cursor -> result set -> procedural lang -> operation (update, select , delete)

*/

declare -> open -> fetch -> close

1. cursor must be declare before use it.
2. This does not reterive any data , just define the select statement 

1. once the cursor is declared and it must be opened for use.
2. This process reterive the data by using the defined select statement .

1. cursor populated with data , individual rows can be fetched as per need.

1. it must be closed , when there is no need for it.
2. This operation then deallocate the memory from dbms server

----------------------------------------------------------------------------------------------------

-- CREATE CURSOR
method 1:

declare cursor_name refcursor;

method 2:

declare cursor_name [cursor_scrollability] cursor [ (name datatype.....) ]
for
	query-expression
	
--cursor_scrollability ==> scroll , default not scroll (can not move backward)	
--query-expression     ==> any legal select statement
	

declare cur_all_movies refcursor;

declare cur_all_directors_name cursor 
for
	select first_name ,last_name from directors d ;

declare cur_directors_by_release cursor (year_release int)
for
	select first_name, last_name , gender , nationality , release_date from directors where year(release_date) =year_release;

-- OPEN CURSOR
1. opening unbound cursor
   It does not declare priorly.
   
open cursor_name 
for 
	query-expression;

open cur_all_directors_uk
for
	select * from directors d where d.nationality ='UK';

--- dynamic query ----

open cursor_name [no , scroll]
for execute
	query expresion [using expression(...)]
	
	
myquery := 'Select feilds from directors d where d.nationality='UK'';

open cur_all_directors_uk
for execute
			myquery;
   
   
2. opening bound cursor
   open the already declared cursor which is bound to a query.
   
open cursor_name;

-- open cur_name (name:=value);

open cur_all_movies;

open cur_directors_by_release (year_release:=2000);


--FETCH CURSOR

following operation done when the cursor is open

fetch , move , update or delete statement

fetch direction {from | in } cursor_name
into target_variable

-- direction 

next
first
last
prior
ABSOLUTE n is used to fetch the exact nth row from the cursor table. 
RELATIVE n is used to fetch the data in an incremental way as well as a decremental way. 

-- only in scroll option 
backward and forward can be used.

fetch cur_all_movies
into row_table;

fetch last from row_table 
into first_name , last_name;

-- MOVE CURSOR

It just move the cursor without retriving the row , just check it exists or not 

move cur_all_movies;

move last from cur_all_movies;

move relative -1 from cur_all_movies;


-- update or delete cursor

update directors 
set year(release_date)=year_release
where
	current of cur_directors_by_release;

delete current of cur_name;

-- close cursor
-- free the cursor variable and allow it to be opened again using open statement

close cur_name;




   
   
   
   
   
   
   
   
   
   
   
   


















