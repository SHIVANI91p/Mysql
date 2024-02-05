show  databases;
create database practicedb5;
use practicedb5;
create table students(sid integer,sname char(30), age integer, course char(30));
show tables;
desc students;
select *from students;
insert into students values(1,'shivani',21,'Mysql');
select *from students;
insert into students values(2,'deep',22,'Mysql');
insert into students values(3,'kareena',23,'Mysql');
select *from students;

-- one line comment
/*
multiline comment   comments are non executable  statements
*/

-- Null datatype

select 5 + 5 as result;
select 5=5 as result;
select 5=10 as result;
select 5!=5 as result;
select 5=null as result;
select 5+null  as result;

-- DDL commands
-- ----------Create table--------------

use practicedb5;
create table patients(pid integer,pname varchar(30), dob date,toa datetime);
show tables;
insert into patients values(1,'Harry','2000-01-26','2023-04-23 08:30:00');
select *from patients;

-- ---------------------------if not exist command -------------------

create table if not exists patients(id integer,name char(10));

-- -----------------Drop Table--------------

create table test(id integer);
show tables;
drop table test;
show tables;

-- Alter table (can change table name can change column name can change data type of column can change no.of columns can add no.of columns)

use practicedb5;
select *from students;
alter table students add column marks integer default 0;    -- adding  new coulmn
select *from students;
alter table students drop column age;
select *from students;
alter table students change column sid std_id integer;   -- chnaging column name
select *from students;
desc students;
alter table students modify column sname varchar(30);    -- changing column datatype
desc students;

-------------------- Rename table--------------

alter table students rename to myclass;  -- to rename table
show tables;
rename table myclass to students;  -- alternate way of rename the table name

-- -------------- DDL: Truncate command---------------------
Truncate students;              -- truncate command comes from ddl category and delete command comes from dml category
select *from students;    -- truncate command delete entire table and then recreate the table using previous command that we have executed
show databases;
show create table students;
show tables;

-- -------------------------------    DML commands  : insert update and delete-------------------

insert into students values(5,'saru',null,50);  -- explicitely written null instead of mysql  type 1 insert
select *from students;
insert into students(std_id,sname,marks)values(6,'janny',55);  -- implicitely writen null   type 2 insert
select *from students;
insert into students  values(7,'jas','mysql',45),
                             (8,'jan','mysql',34),
							(9,'lili','mysql',67);       -- type  3 insert
select *from students;

-- update command

update students            -- to update specific recod
set sname='natasha' 
where std_id = 1;
 set sql_safe_updates=0;
 select *from students;
update students                     -- to update specific recod
set marks=null
where marks = 0;
select *from students;
update students                    -- to update specific recod
set sname='shivani',
course='DS',
     marks=85
 where std_id=6;
 select *from students;              
 update students set course='Mysql';     -- to update all records
 select*from students;   
 
 -------------- Delete command----------------
 
 delete from students where std_id=6;
 select*from students;
 delete from students where marks=null;         -- null is not comparable
 select *from students;
 delete from students where marks is null;
 select *from students;
 delete from students;
 select *from students;
 
-- ------------------inserting records agian-------------------

insert into students values(1,'Ritesh','Mysql',50);
insert into students values(2,'shivani','Mysql',45);
insert into students values(3,'karan','Mysql',34);
select *from students;


-- ------- --------------    DQL:Select command  -----------------------

use practicedb5;
show tables;
select *from myemp;
select *from myemp limit 10;
select *from myemp limit 3 offset 4; -- shows 3 records except first 4 records
select *from myemp limit 10 offset 96;
select emp_id,first_name,last_name,salary from myemp; -- shows fistr 4 columns
select emp_id,first_name,last_name,salary,salary*0.2 as bonus from myemp; -- adds derived column
select emp_id,first_name,last_name,salary,salary*0.2 as bonus,salary+salary*0.2 as Total_Salary from myemp;
select distinct dep_id from myemp;
select distinct job_id from myemp;
select *from person;
select distinct fname from person;
select distinct lname from person;
select distinct fname ,lname from person;
select *from myemp order by dep_id;  -- orderd in ascending order
select *from myemp order by dep_id desc;
select *from myemp order by mgr_id limit 10;
select *from myemp order by dep_id,hire_date ;-- to see senior and junior person 
select first_name,dep_id,hire_date from myemp order by dep_id,hire_date desc ; -- sorted in descending order
select distinct dep_id from myemp order by dep_id; -- to show deparment in ascending order
select *from myemp where salary>=10000;
select *from myemp where hire_date < '2000-01-01';
select *from myemp where salary between 10000 and 15000;
select *from myemp where hire_date between '1987-01-01' and '1987-12-31'; -- to find people whoi joind in 1987
select *from myemp where dep_id!= 80;  --  to find emp who dont belog to dep 80    for not equal to we can use(<>)


-------------------- Logic Gates----------------

select *from myemp where dep_id = 80 and salary> 10000; -- to find emp who's from dep 80 whose salary>10k  usind AND operator
select *from myemp where dep_id = 80 or salary> 10000;   -- Using OR Operator
select *from myemp where dep_id=80 and mgr_id=100; -- emp with manager_id 100 and dep_id 80
select *From myemp where  dep_id= 60 or dep_id=70 or dep_id=40;
select *From myemp where dep_id IN(60,70,40);-- another way syntax

--------------- LIKE Operator---------------------------

select *From myemp where first_name LIKE 'A%'; -- shows people whos name start with A
select *From myemp where first_name LIKE '%A';  -- shows people whos name end with A
select *From myemp where first_name LIKE '%A%'; -- A should be  present anywhere  in the name
select *from myemp where job_id LIKE '%SA%';  -- To see sales job id
select *from myemp where job_id LIKE '%CLERK%'; -- to see clerk jon id
select *From myemp where first_name LIKE 'j____';  -- each underscore define each character
select *From myemp where first_name LIKE '% %';
select *From myemp where first_name NOT  LIKE 'A%';


-- --------------------------------Group Function or Aggregate Function-----------------------------------------

 select *from patients;
select adddate(dob,interval 5 day)as result from patients;
create database newdb;
use newdb;
select *from cats;
select avg(weight) from cats;
select round(weight) from cats;
select sum(weight) from cats;
select min(weight)from cats;
select count(distinct breed) from cats;
select std(weight)from cats;
select count(weight)from cats; 
select count(*)from cats; -- gives total number of records
select count(distinct breed) from cats;
select distinct breed  from cats;
select breed,avg(weight) from cats group by breed;
select breed,round(avg(weight),1) as avg_weight from cats group by breed;

use practicedb5;
select *from myemp;
select dep_id,avg(salary) from myemp group by dep_id;
select dep_id,mgr_id,avg(salary)from myemp group by dep_id,mgr_id;

-------------------------------- joins ( to extract tha data from multiple tables at a time we use joins)-----------------------------
----------------- Inner Join : returns similars records(raws)------------------ and to jaoin 2 tables---------
use newdb;
select *from movies;
select *from members;
select *from movies INNER JOIN  members ON movieid=id;

------------------ Left Join --------------------
select *from movies  LEFT JOIN  members ON movieid=id;
select *from movies;
select *from members;
select mv.title,mm.first_name,mm.last_name from movies as mv LEFT JOIN members as mm ON mv.id= mm.movieid;
select mv.title,ifnull(mm.first_name,'--')as fname,ifnull(mm.last_name,'--')as lname from movies as mv LEFT JOIN members as mm ON mv.id= mm.movieid;


--------------------- Right Join-------------------------
select *from movies RIGHT JOIN  members ON movieid=id;

select *from authors;
select *from books;
select title,name from authors INNER JOIN books ON  books.authorid = authors.authorid; -- both table have same column name so we used like table_name & .

--------------------    Cross Join  (it makes combinations of all records of both table) -------------------------
select *from meals;
select *from drinks;
select *from meals CROSS JOIN drinks;
select *from drinks CROSS JOIN meals; 
select mealname,meals.rate,drinkname,drinks.rate,meals.rate + drinks.rate as total_rate from meals cross join drinks;-- prifixing table name drinks.rate
select m.mealname,m.rate,d.drinkname,d.rate,m.rate + d.rate as total_rate from meals as m  cross join drinks as d;-- another way of prifixing if table_name is big
  
  -------------------- Self Join-------------------------
  select emp.emp_id,emp.first_name,emp.last_name,mgr.first_name as mgr_fname,mgr.last_name as mgr_lname from myemp as emp join myemp as mgr
  ON emp.mgr_id= mgr.emp_id;
  
  select distinct emp_id from myemp order by emp_id;
  select distinct mgr_id from myemp order by mgr_id;
