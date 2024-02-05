
------------------------  User Defind Function --------------------------

 select first_name, last_name,experience(emp_id) from myemp;  --- by excuting first fumction
 select *from myemp;
 select first_name,last_name,year(now()) - year(hire_date) as experience from myemp; --  doing manual code
 