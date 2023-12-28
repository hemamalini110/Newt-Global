create table constraints_tables
(
	id int ,
	name varchar(20),
	location varchar(20) CHECK (location IN ('chennai','banglore')),
	phone_no numeric(10,0) not NULL ,
	mail_id varchar(25),
	passedout numeric(4,0) DEFAULT '2023',
	course_id int,
 	PRIMARY KEY (id),
	UNIQUE (mail_id)
);

create table course
(
	course_id int primary key,
	course_name varchar(20)
);

insert into course values(1,'Java');
insert into course values(2,'SQL');
insert into course values(3,'DBMS');

alter table constraints_tables 
add constraint course_id_foreign_key foreign key (course_id) references course (course_id);


insert into constraints_tables (id,name,location,phone_no,mail_id,course_id)  -- passedout add by default
values (101,'Hema','chennai','8889090909','hema@gmail.com',3);

insert into constraints_tables (id,name,location,phone_no,mail_id,course_id)  -- it violate unique email
values (102,'HemaSri','chennai','8889090909','hema@gmail.com',2);

insert into constraints_tables (id,name,location,phone_no,mail_id,course_id)  -- it violate data integrity by add course_id 7
values (103,'Hemasri','chennai','8889090909','hemasri@gmail.com',7);

insert into constraints_tables (id,name,location,phone_no,mail_id,course_id)  -- it violate primary key by adding 101
values (101,'Dev','chennai','8889090909','dev@gmail.com',3);

insert into constraints_tables (id,name,location,phone_no,mail_id,course_id)  -- it violates check by adding 'hydrebad'
values (104,'Sha','hydrebad','8889090909','sha@gmail.com',3);

insert into constraints_tables (id,name,location,phone_no,mail_id,course_id)
values (104,'Dev','banglore','6689090909','dev@gmail.com',3);

insert into constraints_tables (id,name,location,phone_no,mail_id,passedout,course_id)
values (109,'sha','banglore','9367700909','sha@gmail.com',2020,2);

select * from constraints_tables ;

select * from course;

select id , name, c.course_id ,c.course_name 
from constraints_tables ct 
join course c 
on ct.course_id =c.course_id 
where id=101;




DROP TABLE constraints_tables

-- drop constraint constraint_name;

-- alter table t_name drop constraint constraint_name;

-- alter table t_name rename constraint old_constraint_name  to new ; 
