
-- sequences

create sequence seq_100 
start with 100 
increment 1
minvalue 50
maxvalue 150;

-- numeric sequence

create table courses
(
	id int primary key default  nextval('seq_100'),
	name text
);

insert into courses (name) values ('JS'),('Python');

select * from courses;
select currval('seq_100');         --102
select setval('seq_100',140);      --140
select nextval('seq_100');         --141

-- no cycle reach min value it ahow error


create sequence  if not exists seq_10_nocycle 
start with 10 
increment -1
minvalue 7
maxvalue 12
no cycle;

--drop table courses;

create table courses
(
	id int primary key default  nextval('seq_10_nocycle'),
	name text
);

insert into courses(name) values ('J'),('P'),('O');
--insert into courses(name) values ('Y');           -- error reach mini val if cycle then no error

select * from courses;

-- alphanumeric sequence it use the same seq_10_nocycle

create table products
(
	prod_id text primary key default ('PROD' || (nextval( 'seq_10_nocycle'))),
	prod_name text
);

drop table products ;

alter sequence seq_10_nocycle minvalue 0;

insert into products (prod_name ) values ('pen'),('paper'),('eraser');


select * from products p;





