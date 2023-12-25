insert into course (id,name) values(1001,'AI');
insert into course (id,name) values(1002,'Data Science');
insert into course (id,name) values(1003,'Web Dev');
insert into course (id,name) values(1004,'Java');
insert into course (id,name) values(1005,'Python');

insert into passport (id,number) values(3001,'P123');
insert into passport (id,number) values(3002,'P456');
insert into passport (id,number) values(3003,'P789');
insert into passport (id,number) values(3004,'P101');
insert into passport (id,number) values(3005,'P112');


insert into student (id,name,passport_id) values(2001,'Hema',3001);
insert into student (id,name,passport_id) values(2002,'Jay',3002);
insert into student (id,name,passport_id) values(2003,'Dev',3003);
insert into student (id,name,passport_id) values(2004,'Sha',3004);
insert into student (id,name,passport_id) values(2005,'Guru',3005);

insert into student_course (course_id,student_id) values(1001,2001);
insert into student_course (course_id,student_id) values(1001,2002);
insert into student_course (course_id,student_id) values(1002,2001);
insert into student_course (course_id,student_id) values(1004,2003);


insert into Rating (id,rating,description,course_id) values(4001,'5','good',1001);
insert into Rating (id,rating,description,course_id) values(4002,'4','nice',1001);
insert into Rating (id,rating,description,course_id) values(4003,'2','not bad',1002);
insert into Rating (id,rating,description,course_id) values(4004,'5','good',1004);