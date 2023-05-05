--Display the first name and last name of all employees
SELECT first_name,last_name from employee;
 --Display all the values of the “First_Name” column using the alias “Employee Name”
SELECT first_name as employee_name from employee;
--Get all “Last_Name” in lowercase.
SELECT lower(last_name) from employee;
 --Get all “Last_Name” in uppercase.
SELECT upper(last_name) from employee;
--Get unique “DEPARTMENT”.
SELECT DISTINCT(department) FROM `employee`;
--Get the first 4 characters of “FIRST_NAME” column
SELECT left(first_name,4) FROM `employee`;
--Get all values from the “FIRST_NAME” column after removing white space on the right
SELECT rtrim(first_name) FROM `employee`;
 --Get all values from the “FIRST_NAME” column after removing white space on the left.
SELECT ltrim(first_name) FROM `employee`;
--Write the syntax to create the “employee” table.
CREATE TABLE employee(employee_id int(5) PRIMARY KEY AUTO_INCREMENT,
--first_name varchar(10),last_name varchar(10), salary int(10),joining_date date,department varchar(10));
--Get the length of the text in the “First_name” column
SELECT length(first_name) FROM employee;
--Get the employee’s first name after replacing ‘o’ with ‘#’
SELECT REPLACE(first_name,'o','#') FROM `employee`;
--Get the employee’s last name and first name in a single column separated by a ‘_’
SELECT concat(first_name,'_',last_name) as employee_name from employee;
--Get the year, month, and day from the “Joining_date” column.
SELECT month(joining_date) as Month,day(joining_date) as Day,year(joining_date)as Year from employee;
--Get all employees in ascending order by first name.
SELECT first_name FROM `employee` ORDER by first_name ASC;
--Get all employees in descending order by first name.
SELECT first_name FROM `employee` ORDER by first_name desc;
--Get employees whose first name is “Bob”
SELECT * FROM `employee` WHERE first_name='BOb';
--Get employees whose first name is “Bob” or “Alex”
SELECT * FROM `employee` WHERE first_name='Bob' or first_name='Alex';
--Get employees whose first name is neither “Bob” nor “Alex”
SELECT * FROM `employee` WHERE first_name <>'Bob' or first_name='Alex';
--Get all the details about employees whose first name begins with ‘B’.
SELECT * FROM `employee` WHERE first_name like 'B%';
--Get all the details about employees whose first name contains ‘o’.
SELECT * FROM `employee` WHERE first_name like '%o%';
--Get all the details of the employees whose first name ends with ‘n’.
SELECT * FROM `employee` WHERE first_name like '%n';
--Get all the details about employees whose first name ends with ‘n’ and contains 4 letters
SELECT * FROM `employee` WHERE first_name like '%n' and length(first_name)=4;
--Get all the details about employees whose first name begins with ‘J’ and contains 4 letters
SELECT * FROM `employee` WHERE first_name like 'J%' and length(first_name)=4;
--Get all the details of employees whose salary is over 3,000,000.
SELECT * FROM `employee` WHERE salary >=3000000;
--Get all the details about employees whose salary is less than 3,000,000.
SELECT * FROM `employee` WHERE salary <=3000000;
--Get all the details about employees with a salary between 2,000,000 and 5,000,000
SELECT * FROM `employee` WHERE salary between 2000000 and 5000000;
--Get all the details about employees whose joining year is “2019”.
SELECT * FROM `employee` WHERE year(joining_date) ='2019';
