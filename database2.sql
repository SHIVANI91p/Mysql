
----------- Database constraints,Primary and Foreign Keys, Sequence object--------------------
/*
Constraints: Restrictions that are applied on columns of a table
tpes of Constriants:
1. Domain Constraints
2. Key Constraints

1. Domain Constraints:
- Unique: can't have duplicate values. s_id can have only unique entries
- Not Null: value should be specified 
- Default:
- Check: allow you to put some conditions. eg. put age of only those people whose age>18

2. Key Constraints
- There should be at least one column in a table which can uniquely identify records.
eg. sid  sname  age  course
      1   Tom   20     DA
      2   Tom   20     DA
 sid is unique column whose values are not getting repeated.
 In employee table we have emp_id
 In patients table we have - p_id
 In books - book_id
 
key constrints are implemented using 'Primary key'
  - primary key is use to enforce the constraint that it will uniquely identify the records in table.
  -By default a primary key is a column which is both Unique and Not Null
  -Whille creating table we can make a column as a primary key.
  
Reefrential Intigrity Contraint
Mysql is call relational database because you can create tables and then you can define connection and relation between tables.

Foriegn Key:
-A foriegn key can only point to a Primary key in some other table. it can not point to any other column.
- Table that contains Foriegn Key is called child table.
- Table to which Foriegn Key is pointing is called parent table.
- Student Table : sid is primary key ,cid is foriegn key,so it is Child Table
- Course Table : cid is primary key, so it is Parent Table
- You can add more than one Foriegn keys in a table.
  
Studen Table(CHILD)                    Course Table(PARENT)
sid  sname  age  cid                   cid  sname  duration  fees
1    Tom    20   C10                    C10  Mysql   2wk     $100
2    Tim    25   C10                    C20   DA     6wk     $200
3    Mary   20   C20                    C30   DS     6mon    $500

Referential Intigrity says you can have only values from the parent table in the foreign key column.
This is called  Referential Intigrity  Constriant.
If someone try to delete say C20 record from parent table,
related 3rd record C20 in child table will become orphan.
So Mysql will not allow to delete record.
-NO Deletion of parent record
-NO Updation in  parent record.
-Child table can give permission for parent to be deleted,
you delete corresponding records from students table also. It uses following keywords:

-ON DLETE CASCADE OR ON UPDATE CASCADE  are the optionam permission which may or may not be given
-Cascade means: propogate i.e whatever changes you are doing in parent table
you propogate it to child table also.
-While creating,Parent table should be created first.
-While dropping, Child table shoulds be dropped first.

*/

--------------- 1.Domain Constraints ------------------

use practicedb5;
show tables;
select *from students;
desc students;
insert into students values(1,'shivani','Mysql',21);
insert into students values(1,'karan','Mysql',22);
select *from students;
drop table students;

-------- Recreating Table------

create table students(sid int UNIQUE ,sname varchar(20) NOT NULL,sage int CHECK(sage>18),course varchar(20));
desc students;
insert into students values(1,'tom',19,'Mysql');
insert into students values(2,'tammy',19,'Mysql');
select *from students;
insert into students values(null,'john',22,'Analytics');
insert into students values(null,'jim',32,'Mysql');
select *from students;
insert into students values(3,'jack',17,'Mysql');
insert into students values(4,null,24,'Analytics');
insert into students(sid,sage,course) values(4,24,'Analytics');
alter table students modify column sname varchar(20) not null default 'smith'; -- changed constraint from not null to default
desc students;
select *from students;
insert into students(sid,sage,course) values(4,24,'Analytics');
select *from students;

------------------- 2. Key Constraints -------------------

select *from authors;
select *from books;
drop table authors;    -- cuase author is parent table author table wont drop  first we've to delet child table i.e book table then author table will delete
drop table books;
drop table authors;
create table  authors(authorid integer PRIMARY KEY, name varchar(70));
CREATE TABLE books(bookid integer PRIMARY KEY, title varchar(50),aid integer, FOREIGN KEY (aid) REFERENCES authors(authorid)
ON DELETE CASCADE ON UPDATE CASCADE);
select *from authors;
select *from books;
delete from  authors where authorid = 1;
select *from authors;
select *from books;
update authors set authorid=88 where authorid=8;
select *from authors;
select *from books;

---------------------- Sequence -----------------------
create table test(id integer PRIMARY KEY AUTO_INCREMENT,name varchar(20),age integer);
desc test;
insert into test(name,age) values('Tom',21);
insert into test(name,age) values('Tim',20),('jim',25);
select *from test;
set sql_safe_updates=0; ----- we write this query beacuse delete query was not working its not part of our topic
delete from test;
select *from test;
insert into test(name,age) values('Tom',21);
select *from test;
truncate test;
select *from test;
insert into test(name,age) values('Tom',21);
select *from test;
alter table test AUTO_INCREMENT = 100;
insert into test(name,age) values('Tim',20),('jim',25);
select *from test;


-------------------------- TCL Command-(Rollback,Commit,Save Point)-------------------------

select *from students;
insert into students values(5,'Harry',44,'Dance');
select *from students;
rollback;  -- it should undo means delete 5th record
select *from students;
set autocommit = 0; -- autocommit get on
insert into students values(6,'Kate',44,'Dance');
select *from students;
rollback;
select *from students;
insert into students values(6,'Kate',44,'Dance');
select *from students;
commit; ---  afiter exicuting commit command rollback will not work and record will go in permanent storage 
rollback;
select *from students;

create table tt(id char);
insert into tt values('a');
insert into tt values('b');
select *from tt;
delete from tt;
select *from tt;
start transaction; -- automatically autocommit get off with this command
insert into tt values('a');
insert into tt values('b');
select *from tt;
rollback;  -- all records get deleted
select *from tt;
start transaction;
insert into tt values('a');
insert into tt values('b');
savepoint sb;
insert into tt values('c');
insert into tt values('d');
savepoint sd;
insert into tt values('e');
insert into tt values('f');
select *from tt;
rollback to sd;
select *from tt;
rollback to sb;
select *from tt;
commit; ---- autocommit get on and a and b will go to permanent storage
rollback;
select *from tt;


--------------- Database object : View-------------------

/* while exicuting complex queries we use view  and we can restrict data also*/
select *from myemp limit 10;
create view myview as select emp_id,first_name,last_name,job_id,salary,salary*0.2 as Bonus from myemp limit 10;
select *from myview;
create view dep_50 as select *from myemp where dep_id=50;
select *from dep_50;
select *From authors;
insert into authors values(15,'Siri');
create view authorview as select *from authors where authorid<10;
select *from authorview;
insert into authorview values(9,'Harry');
insert into authorview values(1,'J K Rowling');
insert into authorview values(20,'Tom'); -- this record will not appear in authoreview becuase we have gave condition while creating view(<10) but will appear in actual table
select *from authorview;
select *From authors; --- view will also reflect in orifinal table 
drop view authorview;
create view authorview as select *from authors where authorid<10 with check option; -- this command will give warning and will not insert data neighther in view nor in actual table
insert into authorview values(25,'john');

------------------ Index----------------
# use to increse the perfomance of select query
# types of index structure wise: B-tree and Hash(#)  AND Data wise : Unique , Fulltext , spatial
desc authors;
show indexes from authors;
create table student(sid int PRIMARY KEY AUTO_INCREMENT ,sname varchar(20),Phone_No int);
show indexes from student;
insert into student (sname,Phone_No)values('john',9950);
select *from student;
create unique index stu on student(sname,Phone_No);
show indexes from student;
insert into student (sname,Phone_No)values('john',9950);

------------ Stored Procedure ------------------
# It will give us a programming capability
# we also call this procedure as PL SQL : Programmimg in SQL
call Sample;
call proc_author(4);
call proc_if(2);
call proc_if(0);
call proc_if(-2);
call simpleloop(4);
call Repeatloop(4);

---------------- Exception Handling or Error handling-------------

 select *from payments;
 desc payments;
 select *from fraud;
 desc fraud;
 insert into payments values(1,null);  -- this will give error cuase amount cant be null
 call payments(1,5000); -- it will got insert in payments table and if we enter amount = null it will get inserted to fraud table
 call payments(3,null); -- this will not throw error even if we entered amount= null this is called Exception Hnadling
call payments(4,null);

----------- Cursors -------------
# it is a kind of a variale and it can hold complete data of a table 
call Cursors();
select *from products;
select *from orders;  -- before this table was empty after applying cursor data shifted from presuct table to order table 
call proc_orders();
select *from orders;