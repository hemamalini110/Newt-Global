-- Array is a ordered collection of values starts with 1
-- access array data using subscripts [] customer[2]=> to access second index value
-- rangetype ( lower bound , upper bound , open-close)   [=> close range ()=> open range by default [)
-- postgres evaluate the type itself
-- range - int4range , numrange, daterange, tsrange, tszrange

select 
	int4range (4,8),
	tsrange(current_date , current_date+5),
	array[11.12],
	array[12.467567::integer];
	
--********************************comparison 

select 
	array[1,2,3] = array[1,2,3],
	array[1,2,3] <> array[2,3],
	array[1,2,3] > array[0,1,2],
	array[1,2,3] <= array[0,2,3];

-- @> contain operator
-- <@ contaned operator
-- && is overlap

select 
	int4range(1,3) @> int4range(2,9),  --false
	int4range(1,3) @> int4range(2,3),   -- true
	daterange(current_date , current_date+5) @> current_date+3,  -- true
	array['a','b'] <@ array['a','b'] ,   -- true 
	numrange(1.4,6.4) && numrange(0,7)
	
--********************************* concat

select 
	array[1,2,4] || array[5,6,8],
	array[1,2,4] || 6,
	6 || array[1,2,4]

	
select
	array_cat(array[1,2,4] , array[5,6,8]),
	array_prepend(6,array[1,2,4]),
	array_append(array[1,2,4],6),
	
-- *********************************** length

select 
	 array_length(array[1,5,6,9],1)  ,           -- 1-> return type int 
	 array_length(array[1,2,4,37,845,34],1)
	
-- ********************************** upper() and lower() bound of an array

select 
	 array_lower(array[[1],[34],[1]],1)  ,           -- 1-> return type int 
	 array_upper(array[[1],[34],[1]],1)
	 
-- ********************************** cardinality() return the number of dimensional

select 
	cardinality ( array[[1],[2],[56]]) 
	
-- ********************************** position(array,ele) position(array,ele,start_position)
--position(postion of first occcurence) 

select 
	array_position(array[1,2,3,4],4) ,
	array_position(array[1,4,2,3,4],4,3) ,
	
	array_positions(array[1,2,4,3,4],4) ;

-- ******************************** replace(array,ele_from,ele_to)

select 
	array_replace(array[1,4,3,4],4,1111) 
	
-- ******************************** remove(array,ele_from)

select 
	array_remove(array[1,4,2,3,4],4) 

-- ******************************** in , not in, any , some, all return boolean value

select 
	20 in (1,2,3,4),
	2 in  (1,2,3,4),
	100 not in (1,2,3,4),
	3 = any((array[1,2,3,4])),
	500= some((array[1,2,3,4])),
	1 = all((array[1,2,3,4])),
	1 = all((array[1,1,1,1,1]))
	
--******************************** string_to_array(str,delimiter,opt -> ele , '' to replace as null)
                            -- and array_to_string(array,delimiter, opt -> null, ''  to replace as string)

select 
    string_to_array('1,2,2,8',',') ,
	string_to_array('1,2,2,8',',','8') ,
	
	array_to_string(array[1,2,3,5],','),
    array_to_string(array[1,2,2,8],'|') ,
    array_to_string(array['a','b',null,'c','d'],'|','null_value') 
    
-- ******************************* 
    
create table public.array_imp(
	id integer primary key,
	name varchar(20),
	phone text[] -- text array , text[2] can add more than 2 ele bcos postgres ignore dimension
);
	
insert into array_imp values
(1,'linda','{"999999","777777"}'),
(2,'jack','{"834888"}'),
(3,'kash','{"454888","892121"}');


select name, phone[1],phone[2] from array_imp ;


-- expand the array values into seprate col  unnest(phone)
select name , unnest(phone) from array_imp  
order by phone;


select * from array_imp 
where '777777'= any (phone);


update array_imp 
set name='jack willam' 
where phone='{"834888"}';

select * from array_imp ;


-- ********************************** Multi-Dimensional array

create table multi_dim_arr(
id int primary key,
name varchar(20),
grade text[][]);

insert into multi_dim_arr values
(1,'sha','{"9","2001"}'),
(2,'Ayra','{"7","2011"}'),
(3,'riya','{"8","2022"}');


select * from multi_dim_arr ;

select * from multi_dim_arr 
where grade @> '{2001}';

select * from multi_dim_arr 
where grade[1]>'7';

select unnest(grade) from multi_dim_arr 
where grade @> '{2001}';

