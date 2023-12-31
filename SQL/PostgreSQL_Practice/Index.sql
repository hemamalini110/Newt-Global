-- index 	
--1. An index is a structured relation.
--2. An index help impodove the access of data in our databases.
--Indexed tuples point to the table page where the tuple is stored.
--4. An index is a data structure that allows faster access to the underlying table so that specific
--tuples can be found quickly. Here, "quickly" means faster than scanning the whole underlying table
--and analyzing every single tuple.
--5. Maintaning an index is a fundamental for having a good performance.

--index of 2 types

--1. index			 - create index only on the values of the column of table
--2. unique index    - create index only on the unique values of the column of table (primary key cols)

--Full syntax for index
--create index idx_name on table_name (using method) 
--(
--	(col) [asc|desc] nulls[first|last]
--)

create index idx_orders_order_date on orders(order_date);

create index idx_orders_order_id_customer_id on orders(order_id,customer_id);

-- list index 

select * from pg_catalog.pg_indexes 
where schemaname ='public'
	--tablename ...

-- size of table index 
-- index size will occupy the disk space

select pg_size_pretty(pg_indexes_size('orders'));

--list all indexes

select * from pg_stat_all_indexes
where schemaname='public'and
	  relname='orders'
	  
	  
-- drop index
	  
drop index [concurrently | cascade | restrict (default) ] index_name [cascade | restrict];

concurrently -- exclusively lock the table and block the access until the removal of index
cascade 	 -- it delete the dependent obj also
restrict     -- refuse to drop if there is any dependent obj 

-- *********************** 4 stages of SQL excecution

1.	parser handles the textual form of the statement (the SQL text) and verifies whether
    it is correct or not

    disassemble info into tables, columns, clauses etc.
    
2.	rewriter applying any syntactic rules to rewrite the original SQL statement

3.	optimizer finding the very fastest path to the data that the statement needs

	*(access the data as quickly as possible with the fastest path and low cost (each operation has some cost)
	thread) perform lots of iteration to find
	
	*Thread is used to do the parallel processing
	
	*nodes optimizer seprate the query into individual operation (nodes)
	each node perform seprately
	cost calculate for each node and finally sum up
	select * from table order by col
	
	-- select all     node 1  
	-- order by col   node 2

4.  executor responsible for effectively going to the storage and retrieving (or inserting) the data
	gets physical access to the data

	
-- ********************* Nodes
	
nodes follow stackable approach (bottom - top )
parent
	child 1
		child 2 
the output of child 2 is input for child 1
default node type is Squential Scan (btree)

select * from pg_catalog.pg_am   -- list all types of nodes

-- ****************** EXPLAIN

1. It will show query execution plan
2. Shows the lowest COST among evaluted plans
3. Will not execute the statement you enter, just show query only
4. Show you the execution nodes that the executor will use to provide you with the dataset.
5. explain can be formatted as text (default) , json, xml,yml

explain (format json) select * from orders;
[
  {
    "Plan": {
      "Node Type": "Seq Scan",
      "Parallel Aware": false,
      "Async Capable": false,
      "Relation Name": "orders",
      "Alias": "orders",
      "Startup Cost": 0.00,
      "Total Cost": 22.30,
      "Plan Rows": 830,
      "Plan Width": 90
    }
  }
]

-- ************* EXPLAIN ANALYZE
1. print the best excecution plan to excecute the query
2. also run the query
3. show the statistical info

explain (analyze) select * from "Northwind".orders order by order_id;

Index Scan using pk_orders on orders  (cost=0.28..49.73 rows=830 width=90) (actual time=0.188..0.604 rows=830 loops=1)
Planning Time: 0.233 ms   -- time to get what data
Execution Time: 0.819 ms  -- time to excecute the data in best way
total exe time = planning + execution

--*******************  COST
The cost is the amount effort required to execute the node. 

One is called the startup cost and the other one is the final cost.

startup cost ?=> It is basically how much work Postgres has to do before it executing this node.
final cost ?  => It is how much effort PostgreSQL has to do to provide the last bit of the data set, 
and that is to complete the execution of the node to complete the statement that you needed over here.
star

--Index Scan using idx_using_hash_order_date on orders  (cost=0.00..8.02 rows=1 width=90)
here start cost is 0.00 so starts immediately and final cost is 8.02 

--**************** TYPES OF NODE

types of nodes
1. Sequential scan
2. index scan , index only scan , bitmap index scan
3. nested loop , hash join, merge join
4. the gather and merge parallel nodes

--************ seq scan
sequential scan node type perform well in fetch all records or minimal filtering. 
it starts scan from the beginning and sequentially one by one.

explain select * from "Northwind".orders ; -- seq scan

--************** index 
1. An index is used to access the dataset
2. Data file and index files are seperated but they are nearby
Index Nodes scan type
Index Scan                  index -> seeking the tuples-> then read again the data
Index Only Scan requested   index columns only -> directly get data from index file
Bitmap Index Scan           builds a memory bitmap of where tuples that satisfy the statement clauses

explain select * from "Northwind".orders where order_id =10248; --index scan because index is created for order_id col
explain select order_id from "Northwind".orders where order_id=10248; -- only order_id is retrived than * 

-- ************* Join
1. used when joining the tables
2. Joins are performed on two tables at a time; if more tables are joined together, the output of one join is
treated as input to a subsequent join.
3. When joining a large number of tables, the genetic query optimizer settings may affect what combinations of
joins are considered. 

show work_mem   -- it is a memory space used for sort operation and hash table processing and operation, can set memory space
sort operation for orderby , distinct
hash table for joins, hash based aggregation , subquery in ...

1. Hash join

- Inner table Build a hash table from the inner table, keyed by the join key.
- Outer table Then scan the outer table, checking if a corresponding value is present.

select * from orders where order_id in ('','');

2. Merge join

Joins two children already sorted by their shared join key. This only needs to scan each relation once,
but both inputs need to be sorted by the join key first (or scanned in a way that produces already-sorted
output, like an index scan matching the required sort order).

3. Nested loop 

For each row in the outer table, iterate through all the rows in the inner table and see if they match the
join condition. If the inner relation can be scanned with an index, that can improve the performance of a
Nested Loop Join. This is generally an inefficient way to process joins but is always available and sometimes
may be the only option.



explain select * from "Northwind".orders
natural join "Northwind".customers

-- ************ parallel parallel index creation

1. it provide the ability to utilize more than one CPU to build an index
2. one of the great feature.
3. Thereby you can speed the process considerably.


--**************  B-Tree Index

create [UNIQUE INDEX | index ]index_name
1. Default Index
2. self-balancing tree
- SELECT, INSERT, DELETE and sequential access in logarithmic time
3. Can be used for most operators and column type
Supports the UNIQUE condition and
5. Normally used to build the primary key indexes
6. Uses when columns involves following operators(>,< <=,>= ,<>, in,between, like )
=====>  One Drawback is it take all the col values for tree structure.

--************ Hash Index

used for equality operation (=)

explain select * from orders where order_date='2001-11-09';  -- index scan

create index idx_using_hash_order_date on orders
using hash (order_date);

explain select * from orders where order_date='2001-11-09';

--************** BRIN index
block range index
1. range of value stored in a data block 
2. every block contain min and max value and the index 
3. it will search data by evaluate all the blocks.
4. Less maintanance , used in large DB
5. Use linear sort order
6. may not be accurate as b-tree


--************** GIN index

1. generalized inverted indexes
2. Point to multiple tuples
3. Used with array type data
Used in full text-search
5. Useful when we have multiple values stored in a single column

-- *********** partial index 
create index on the column which is not repeated frequently
there by can improve the performance

create index idx_p_tablename_colname on tablename 
where col in ('Adam','Joshi');

or 

create index idx_p_tablename_inactive on tablename 
where is_active in ('N');

pg_size_pretty(pg_indexes_size(col));


--***************** invalidate the index
This is for the maintainence of the index
disallow the query optimizer to use that index by make false for indisvalid

-- To list down the index in the particular table

SELECT oid, relname, relpages, reltuples,
i.indisunique, i.indisclustered, i.indisvalid,
pg_catalog.pg_get_indexdef (i.indexrelid, 0, true)
FROM pg_class c JOIN pg_index i on c.oid = i. indrelid
WHERE c.relname = 'orders'; 

-- update that index to false

UPDATE Pg_index
SET indisvalid = false
WHERE indexrelid= (SELECT oid FROM pg_class
WHERE relkind = 'i' 
AND relname = 'pk_orders');

-- Rebuild the index

REINDEX [VERBOSE) ] { INDEX | TABLE | SCHEMA | DATABASE SYSTEM} [CONCURRENTLY] name


reindex (verbose) index 'pk_orders';

drop index 'pk_orders'

select * from customers c 
