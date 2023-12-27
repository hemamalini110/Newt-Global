CREATE TABLE accounts(
	account_id serial primary key,
	username varchar(50),
	password varchar(8),
	location varchar(20)
);

select * from accounts;

-- insert record

insert into accounts values(1,'hema','12324','chennai');
insert into accounts values(2,'William''s ','45p23','chennai');
insert into accounts values(3,'Adam','87jb3','usa');

-- insert multiple records

insert into accounts values
	(4,'John','12324','chennai'),
	(5,'Dev','85o85','usa'),
	(6,'Sha','7845i','banglore');
	
-- insert and returning all and specific column

insert into accounts values
	(7,'Keni','9h643','banglore') returning *;

insert into accounts values
	(8,'Keni','ng868','usa') returning username,password;

-- alter table by add column

alter table accounts add column is_valid char(1);

-- update a row , all , and returning

update accounts set is_valid='Y' where account_id=7;

update accounts set is_valid='Y' returning account_id,is_valid;

-- upsert with on conflict

CREATE UNIQUE INDEX unique_username on accounts(username);  -- must

insert into accounts (username) values ('Dev')              -- already present then do ntg
on conflict(username)
do nothing;

insert into accounts (username) values('Dev')               -- already present then update
on conflict (username)
do 
	update set 
		username= EXCLUDED.username,
		location='banglore';
		
-- delete 

-- delete from accounts where account_id=1; specific records
-- delete from accounts;  all records


	









	
	

