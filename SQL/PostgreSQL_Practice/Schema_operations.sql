
-- create schema
create schema sales;

-- rename schema
alter schema sales rename to sales_schema

-- delete schema
drop schema sales_schema

create  table sample (id int primary key);

-- transfer a table from public schema to sales
alter table sample set schema sales; 




-- whenever the query is starts running postgreSQL search for the path to the table in schema search path 

show search_path; 

select current_schema();  --public

set search_path to sales, public ;    -- order matters

select current_schema();  --sales

-- both schema contains table of same name
-- select * from table_name first it search in the sales if not present then move to public based on the order




-- create user
create user hema

-- change the owner postgresql to hema
alter schema sales owner to hema



-- Duplicate the schema to public
--pg_dump -d tempDB -h localhost -u postgres -n public > dump.sql;

--back tp db
-- psql -h localhost -U postgres -d testDB -f dump.sql


-- system catalog schema 
-- each DB contain  pg_catalog schema in addition to pulic and user-created schema - it consist of meta information about the DB
-- it contains system tables , built-in datatypes , functions
-- it is effective for search path
-- only for look 
-- system tables begin with pg_

select * from information_schema.schemata -- to view all schemas
