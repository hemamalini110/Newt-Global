***********
https://www.postgresql.org/docs/current/functions-matching.html

1. regex or regular expression are a type of notional language that describes 'text patterns'
2. regular expression notation basics
3. check for the pattern can match any part of the string

Expression Notes

.		A dot is a wildcard that finds any character expect a new line
[FGz] 	Any character in the square bracket [1, here is F,G, or z
[a-z) 	A range of characters. Here lowercase a to z.
^[a-z] 	The caret negatee the match. here not lowercase a to 7
\w		Any word character or underscrore. Same as [A-Za-z8-9_]
\d	    Any digit
\t 		2 tab character
\s		A space
\n		A newline character
\r		Carriage return character
^		Match at the start of the string
$		Match at the end of the string
?		Get the precedind match zero or one time.
*		Get the precedind match zero or more time.
+		Get the precedind match one or more time.
{n} 	Get the precedind match exactly times
{m,n}	Get the precedind match between in and n times
{a|b}	The pipe | denotes alternation. Find either a or b
()		Create and report a capture group or set precedence
(?:)	as above, but the match is not noted for reporting (a “non-capturing” set of parentheses) (AREs only)


similar to same as like operator it check for match the entire string
_ ==> .   % ==> .*

select 
	'Same' similar to 'S%',
	'same' similar to '_ame',
	'same' similar to '%e',
	'welcome' similar to 'wecome', --false
	'welcome' similar to '%(w|e)%me';

POSIX Regular expression
1.	It is more powerful than like and similar to while coming to pattern matching

~	(Matches regular expression, case sensitive)
~*  (Matches regular expression, case insensitive)
!~	(Does not match regular expression, case sensitive)
!~*	(Does not match regular expression, case insensitive)

select 
	'same' ~ 'same',
	'Same' ~ 'same',
	'same' ~* 'SAME',
	'same' !~ 'hello',
	'same' !~* 'same',  -- false (match)
	'same' !~* 'ghhss'  -- true
	
--'Hello all I reached chennai at 11p.m'
	
select substring('Hello all I reached chennai at 11p.m' from '.'); --_

select substring('Hello all I reached chennai at 11p.m' from '.+'); 

select substring('Hello all I reached chennai at 11p.m' from '.*') ; --%
	
select substring('Hello all I  reached chennai at 11p.m' from '\d.+') ;  --11p.m

select substring('Hello23 all I reached chennai at 11p.m' from '\d.') ; --23

select substring('Hello all I reached chennai at 11p.m' from '\w+') ;   -- Hello

select substring('Hello all I reached chennai at 11p.m' from '\w.+') ;

select substring('Hello all I reached chennai at 11p.m' from '\w*') ;

select substring('Hello all I reached chennai at 11p.m' from 'all.+') ;  -- all ...

select substring('Hello all I reached chennai at 11p.m 2001.' from '\w+.$') ;  -- 2001.

select substring('Hello all I reached chennai at 11 p.m' from '\d{1,2} (?:a.m|p.m)') ;  --11 p.m

select substring('Hello all I reached chennai at 11 p.m 2001 ' from '\d{4}') ;  --2001 \d{2} -> 11

select substring('Hello all I reached chennai at 11 p.m DEC 23, 2001 ' from 'DEC \d{2}, \d{4}') ;  --DEC 23, 2001 


REGEXP_MATCHES(string, pattern, flag)

flags 'g' -> global search
	  'i' -> case insensitivity
results store as array
select regexp_matches('@Hello @All welcome','@.+','g'); 
select regexp_matches('@Hello @All welcome','@[A-Za-z0-9_]+','g'); 

select regexp_matches('WXYZ','^(W)(...)$','g');

select regexp_matches('111 222-A 444-D','[A-Z]','g'); 
select regexp_matches('111 222-A 444-D','-[A-Z]','g'); 
select regexp_matches('111 222-A 444-D','\d{3}','g'); 

REGEXP_REPLACE(string, pattern,replce, flag)

select regexp_replace('123xbdrg 35hdfg uu3434','(.*) (.*) (.*)','\3 \2 \1','g');  --reverse

select regexp_replace('123xbdrg35hdfg','[[:digit:]]','','g');  --omit digit
select regexp_replace('123xbdrg35hdfg','[[:alpha:]]','','g');  --omit alpha

select regexp_replace('2022-10-11','\d{4}','2023','g');  --2023-10-11



SPLIT DELIMITED text into table row in text type

select regexp_split_to_table('1,2,hello,   linda',',');  -- space also considered

select regexp_split_to_array('hello all welcome home ',' '); 

select array_length(regexp_split_to_array('hello all welcome home',' '),1); 


--postgres comes with powerful full text search engine in large amount of text data

2 datatypes

1. tsvector   - text searched and stored in optimized format 
2. tsquery    - represent search query terms and operation

tsvector ->

1.reduces the text to a sorted  list of lexemes
	lexemes->	without the variation created by suffix
	(wash, washed,washes, washable...) => wash
2.remove stop words

select to_tsvector('washing'),  to_tsvector('washed'), to_tsvector('wash');  -- wash

select to_tsvector('Today i going to mysore palace to see the architecture of the palace'); 
'architectur':10 'go':3 'mysor':5 'palac':6,13 'see':8 'today':1
lexemes word with position as pointers
list in alphabetical order

-- tsquery()  accepts the list of tsvector and checked against the normalized vector we created with to_tsvector()

operators

@@ matching  operator
&  and
|  or 
!  not 
<-> search for adjacent words (should be in asc order 'read <3> fix')

select to_tsvector('Today i going to mysore palace to see the architecture of the palace')
	@@ to_tsquery('palace')   -- true
	

select to_tsvector('Today i going to mysore palace to see the architecture of the palace')
	@@ to_tsquery('palace & going') 
	
	
select to_tsvector('Today i going to mysore palace to see the architecture of the palace')
	@@ to_tsquery('palace <2> see')    -- 2 denotes the difference bt the palace and see position
'architectur':10 'go':3 'mysor':5 'palac':6,13 'see':8 'today':1


create table full_text_search
(
id serial primary key,
text_data text,
text_data_search tsvector
);

insert into full_text_search (text_data) values 
('hey i all welcome home'),
('hey i all welcome sweet home'),
('i visit chennai last month'),
('im sit in sitting room');
	
update full_text_search set text_data_search= to_tsvector(text_data);

select * from full_text_search





































	  


	
	
	
	
		''
