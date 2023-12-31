-- PARTITIONING

split the large data table into a small peice of data and splitting based on the logical division
like which column is frequently used in filtering.

partition in multiple col and small table like 1000s rows may increase the maintenance .

eg: server logs table contain million records pertion by dates and then partition the date records with operation like delete partition.

With huge data being stored in databases, performance and scaling are two main factors that are affected.
As table size increases with data load, more data scanning, swapping pages to memory, 
and other table operation costs also increase. Partitioning may be a good solution,
as It can help divide a large table into smaller tables and thus reduce table scans and memory swap problems,
which ultimately increases performance.

https://www.enterprisedb.com/postgres-tutorials/how-use-table-partitioning-scale-postgresql

types of partitioning

1. range (range of date jan-dec 2020 in seprate partition 2020 data)
2. list
3. hash (use when cannot divide logically)

---- RANGE

CREATE TABLE employee
(
id int,
name text,
dob date
)partition by range (dob);

create table partition_table partition of master_table
	for values from (value1) to (value2);

value2 always +1; but it does not include that

create table year_2001 partition of employee
	for values from ('2001-01-01') to ('2002-01-01');

create table year_2002 partition of employee
	for values from ('2002-01-01') to ('2003-01-01');

insert into employee  (id,name,dob) values
(1, 'aaa','2001-10-11'),
(2, 'bbb','2002-09-11'),
(3, 'sghd','2001-04-14'),
(4, 'jsd','2002-07-21'),
(5, 'aaa','2002-10-11');


-- total records in master table is zero because it partition based on the range to the respective table
select * from only employee e ;


select * from year_2001 ;

select * from year_2002;

---all insert , delete , iupdate perform only in master table

update employee set dob='2001-07-11' where id=4;

explain select * from year_2001 where dob='2001-10-11';  -- it fetch directly from the partition table


--------- LIST
 
define the list explicitly based on the list value the partition is done

eg : country column in partition by
us and eu (uk ,jp,sp...)
create table tb_name
(col , col ...)
partition by list (col);


create table partition_table partition of master_table
	for values in ('us');

create table partition_table partition of master_table
	for values in ('uk','jp','sp');

insert records into master table
it will partitioned based on the list value.



---- Multi-level partition
create a partition from existing partition.
more carefully 

create table partition_eu partition of master_table
	for values in ('uk','jp','sp');

here the partition_eu contain more data because list has more values. Further level parttion is done.

create table partition_eu partition of master_table
	for values in ('uk','jp','sp')
	partition by hash (id); -- hash partition on the id in partition_eu table

create table partition_eu_1 partition of partition_eu
    for values with (modulus 3,remainder 0);
   .
   .
   .

---- Hash
A hash partition is created by using modulus and remainder for each partition,
where rows are inserted by generating a hash value using these modulus and remainders.

rows partioned appx based on the hash code value generated by modulus and remainder.

create table tb_name
(col , col ...)
partition by hash (col);-- col is id

create table partition_table partition of master_table
	for values with (modulus 3, remainder 0);

create table partition_table partition of master_table
	for values with (modulus 3, remainder 1);

create table partition_table partition of master_table
	for values with (modulus 3, remainder 2);


--------------------------------------------------------------------------
----------default partition

if the data is inserted without matching any partition it will inserted into default partition.

create table partition_table partition of master_table default;

table inheritance

the child table inherits the cols and properties of the mmaster or parent table.

create table child inherts (master);

select *  from only master;
select *  from only child;

insert in child also row added in master table also
change in master table reflect in child also like delete , update...

