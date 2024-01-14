-- show databases;

-- create database db_bc2311;

-- use db_bc2311;

-- CREATE USER 'ilsa'@'localhost' IDENTIFIED BY 'admin1234';

-- ALTER USER 'ilsa'@'localhost' IDENTIFIED BY 'ilsalam1204';

-- GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'ilsa'@'localhost' WITH GRANT OPTION;

-- SHOW VARIABLES LIKE 'validate_password%';
-- SET GLOBAL validate_password.policy = LOW;

 create table customer (
 	id integer not null,
    cust_name varchar(50) not null, 
	cust_email_addr varchar(30), -- nullable
    cust_phone varchar(50) -- nullable
     );

-- delete all data (without where)
delete from customer; 
     
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (1, 'John Lau', 'john@gmail.com', '12345678');

-- Insert some more records ...
-- Try insert some null values
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (2, 'Sunny Wong', 'sunnywong@gmail.com', '12345678');
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (3, 'Christy Lau', 'christyho@gmail.com', '894721223');
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (4, 'Ben Tse', null, null);

-- where
select * from customer where id = 3;
select * from customer where cust_name = 'John Lau' and cust_phone = '12345678';
select * from customer where cust_name = 'Ben Tse' or cust_email_addr = 'sunnywong@gmail.com';
select * from customer where cust_name = ('John Lau' or cust_email_addr = 'sunnywong@gmail.com') and cust_email_addr = 'john@gmail.com';

-- where + order by
-- desc (descending order)降序排列
-- asc (ascending order)升序
select * from customer where cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com' order by id desc; 
select * from customer where cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com' order by cust_name asc;
select * from customer where cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com' order by cust_name; -- asc by default
select * from customer order by id; -- asc by default


insert into customer(id, cust_name, cust_email_addr, cust_phone) values (5, 'Sunny Wong', 'sunnywong@yahoo.com.hk', '87654321');
select * from customer where cust_name = 'John Lau' or cust_name = 'Sunny Wong' order by cust_name desc, cust_phone asc;
select * from customer where cust_name in ('John Lau', 'Sunny Wong') order by cust_name desc, cust_phone asc;

-- delete table (where)
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (6, 'dummy', 'dummy@yahoo.com.hk', 'dummy');
delete from customer where cust_name = 'dummy';

-- where -> like
-- % means any character(s) or no character (% = 前面有一堆字）
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (7, 'Tommy Lau', 'yommy@yahoo.com.hk', '1234');
select * from customer where cust_name like '%Lau'; -- return  John Lau, Christy Lau, Tommy Lau
select * from customer where cust_name like '%Lau%'; -- return John Lau, Christy Lau, Tommy Lau
select * from customer where cust_name like '%Sunny%'; --
select * from customer where cust_email_addr like '%@%' or cust_email_addr is null;

-- print out
select * from customer;

-- alter table add/ modify/ drop
-- add a new column
alter table customer add join_date date;

-- update
update customer set join_date = str_to_date('1990-01-01', '%Y-%m-%d');
update customer set join_date = str_to_date('1990 01 01', '%Y %m %d');

update customer set join_date = str_to_date('2023 01 01', '%Y %m %d') where id = 2;

-- VARCHAR, INTEGER, DATE, DECIMAL, DATETIIME
alter table customer add score decimal(5,2); -- (數字長度,幾個小數位)3 digits for integer, 2 digits for decimal places, max value 999.99

insert into customer (id, cust_name, cust_email_addr, cust_phone, join_date, score)
values (5, 'Sunny Wong', 'sunnywong@yahoo.com.hk', '87654321', str_to_date('1990 02 02', '%Y %m %d') ,120.56);

insert into customer (id, cust_name, cust_email_addr, cust_phone, join_date, score)
values (8, 'Sunny Chan', 'sunnychan@yahoo.com.hk', '87654321', str_to_date('1990 03 03', '%Y %m %d') ,120.56);

insert into customer (id, cust_name, cust_email_addr, cust_phone, join_date, score)
values (9, 'Kaite Kwan', 'kaite@yahoo.com.hk', '1234', str_to_date('1990 04 04', '%Y %m %d') ,999.99);

update customer set score = -1000 where id = 9; -- error, 1000 is out of range for decimal(5,2)

-- add a new column
alter table customer add last_transaction_time datetime;

insert into customer (id, cust_name, cust_email_addr, cust_phone, join_date, score, last_transaction_time)
values (9, 'Kaite Kwan', 'kaite@yahoo.com.hk', '1234', str_to_date('1990 04 04', '%Y %m %d') ,999.99, str_to_date('1990-04-04 20:20:21', '%Y-%m-%d %H:%i:%s'));

-- Some other approaches to insert data
insert into customer
values (10, 'Jason Kwan', 'jason@yahoo.com.hk', '1234', str_to_date('1999-01-01', '%Y-%m-%d'), 200.99, str_to_date('1999-01-04 20:20:21', '%Y-%m-%d %H:%i:%s'));

-- error, by default you should provide all column values when you skip the column description
-- insert into customer
-- values (10, 'Jason Kwan', 'jason@yahoo.com.hk', '1234', str_to_date('1999-01-01', '%Y-%m-%d'), 200.99);

insert into customer (id, cust_name, join_date, score, last_transaction_time)
values (11, 'Jenny So', str_to_date('1990-01-01', '%Y-%m-%d'), '12.99', str_to_date('1999-01-01 20:20:21', '%Y-%m-%d %H:%i:%s'));

-- where: between and (inclusive)
select * from customer where join_date between str_to_date('2023-01-01', '%Y-%m-%d') and str_to_date('2023-12-31', '%Y-%m-%d');
select * from customer where join_date >= str_to_date('2023-01-01', '%Y-%m-%d') and join_date <= str_to_date('2023-12-31', '%Y-%m-%d');

-- where: >, <, >=, <=, <>(!=)
-- ifnull() funtion: Treat null value as another specified values
-- coalesce 可以接受多個參數
-- (如果score為空值，則將其視為100）
select * from customer where ifnull(score, 100) > 0 and ifnull(score,100) < 1000;
select * from customer where coalesce(score, 100) > 0 and coalesce(score,100) < 1000;

-- alter table -> drop column
alter table customer add dummy VARCHAR(10);
alter table customer drop column dummy;

-- alter table -> modify column
-- Extend the length of the column
alter table customer modify column cust_email_addr varchar(50); -- extend length from 30 -> 50
-- Shorten the length of the column
alter table customer modify column cust_email_addr varchar(10); -- shorten length from 50 -> 10, error, because some existing data's length 

-- Find the customer with score > 100, and showing the id , cust_name, join_date of result set.
select id, cust_name, join_date from customer where score > 100;

-- IS NULL, IS NOT NULL
select id, score from customer where score is not null;

-- uppercast/lowercast
select upper(cust_name), lower(cust_name), cust_name from customer;
select upper(cust_name) -- JOHN LAU
, lower(cust_name) -- john lau
, cust_name 
, length(cust_name) -- 8
, substring(cust_name, 1, 3) -- Joh
, concat(cust_name, ', email address: ', cust_email_addr) -- John Lau, email address: john@gmail.com
from customer;

-- String Funtion
-- as = Tiltle
select upper(c.cust_name) as customer_name_upper_case
, lower(c.cust_name) as cutomer_name_lower_case
, length(c.cust_name) as customer_name
, substring(c.cust_name, 1, 3) as customer_name_prefix
, concat(c.cust_name, ', email address: ', c.cust_email_addr) as customer_info
, replace(c.cust_name, 'Lau', 'Chan') as new_customer_name
, left(c.cust_name, 3) -- 左手邊攞3個 from left to right
, right(c.cust_name, 2) -- 右手邊攞2個 form right to left
, trim(c.cust_name) -- remove leading and tail spaces
, replace(c.cust_name, '','') -- remove all spaces
from customer c;

-- MySQL case-insensitive不區分大小寫
select * from customer where cust_name = 'John Lau';
select * from customer where cust_name = 'John Lau'; -- still can return, case-sensitive
select * from customer where cust_name collate utf8mb4_bin = 'John Lau'; -- just rmb 'utf8mb4_bin' 它將區分大小寫字母視為不同

-- %, _
select * from customer where cust_name like '_ohn%'; -- there is only one character before 'o'

-- Math 
update customer set score = 12.14 where id = 1;
update customer set score = 12.15 where id = 2;
update customer set score = 12.16 where id = 3;
select * from customer;

select c.*, 
1 as one, -- value and column name: 1 and one
'dummy value' as dummy_column, -- 值為"dummy value"，列名為"dummy_column"
round(c.score, 1) rounded_score, -- 四捨五入值，保留一位小數
ceil(c.score) as ceiling_value, -- round a floating-point number up to the nearest integer greater than or equal to the original value 向上取整值
floor(c.score) as ceiling_value, -- round a number down to the nearest integer 向下取整值
abs(score) as abs_value, -- negative -> positive 絕對值
power(score, 2) as power2_score, -- 平方
date_add(join_date, interval 3 month) as three_month_after_join_date,
date_add(join_date, interval 3 day) as three_day_after_join_date,
date_add(join_date, interval 3 year) as three_year_after_join_date,
date_sub(join_date, interval 3 day) as three_day_before_join_date, -- join_date -3 days
join_date + interval 1 day, -- correct  +1 day
join_date - 1, -- wrong syntax in MYSQL
join_date - interval 1 day, -- correct - 1 day
datediff('1990-12-31', join_date) number_of_days_between_join_date_2000_01_01, -- 1990-12-31 - join_date
datediff(join_date, join_date),
now() as curr_timestamp
from customer c; 

-- CASE
select cust_name,
	case
		when score < 20 then 'Fail'
        when score < 100 then 'Pass'
        when score < 1000 then 'Excellent'
        else 'N/A'
	end as grade 
from customer;


-- primary key is one of the constraint約束: not null, unique, index
--
create table department(
	id integer primary key, -- 1, 2, 3, 4 得一個id 獨一無二 
    dept_name varchar(50),
    dept_code varchar(10) -- HR, IT
);

create table employee(
	id integer primary key, -- 1, 2, 3, 4 得一個id 獨一無二
    staff_id varchar(50) unique,
    staff_name varchar(50),
    hkid varchar(10) unique,
    dept_id integer, -- reference: department gor'id' 一個department得一個id 獨一無二
    foreign key (dept_id) references department(id) -- everytime before add things inside employee -> first check department 嘅id
    -- ensure input geh yeh match dou foreign key
);

SELECT * FROM employee; 
SELECT * FROM  country;
ALTER TABLE employee RENAME COLUMN fk_country_id TO country_id;
alter table employee add county_id integer;
alter table employee add constraint fk_country_id foreign key (country_id) references country(id);

create table country(
	id integer primary key,
    country_code varchar(2) unique,
    description varchar(50)
);

create table employee_contact_info(
	id integer primary key,
    phone varchar(50),
    foreign key(id) references employee(id)
);

insert into employee_contact_info values (1, '12345');

insert into department values(1, 'Human Resource', 'HR');
insert into department values(2, 'Information Technology', 'IT');

insert into employee values(1, '001', 'John Lau', 'A1234567', 2);
insert into employee values(2, '002', 'Mary Chan', 'A1234568', 1);
-- insert into employee values(3, '003', 'Jenny Wong', 'A1234569', 3); -- error: because dept_id 3 does not exists in table deparment
insert into employee values(3, '003', 'Sunny Lau', 'A1234598', 2);

-- inner join 合拼
select * from employee inner join department;
select * from employee inner join country; 

select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code -- choose what to display by myself
from employee e inner join department d on e.dept_id = d.id;

select * from employee;
insert into country values (1, 'HK', 'Hong Kong');
insert into country values (2, 'US', 'U.S');
select * from country;

update employee set country_id = 1; -- not yet have things inside table 'country', cannot add country_id -> can update after insert values;

select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code, c.country_code, c.description
from employee e
inner join department d on e.dept_id = d.id
inner join country c on e.country_id = c.id
where d.dept_code = 'IT';

-- inner join without key, all records join(Inner join demo in a wrong way)
select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code, c.country_code, c.description
from employee e
inner join department d 
inner join country c;

-- Another approach to perform inner join (use WHERE instead of inner join)
select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code
from employee e, department d
where e.dept_id = d.id
and d.dept_code = 'IT'
order by e.staff_name desc;

-- Left Join
insert into department values(3, 'Marketing', 'HK');

select d.*, e.*
from department d left join employee e on e.dept_id = d.id;

-- group by
select * from employee;
insert into employee values (4, '004', 'Peter Chan', 'A1234563', 3, 2);

-- count() -> aggregation function 總數 中位數...etc
select e.dept_id, count(1) as number_of_employee
from employee e 
group by e.dept_id;

-- add column year_of_exp
alter table employee add column year_of_exp integer;
update employee set year_of_exp = 1 where id = 2;
update employee set year_of_exp = 10 where id = 1;
update employee set year_of_exp = 5 where id = 3;
update employee set year_of_exp = 18 where id = 4;
select * from employee;

-- group by: max(year_of_exp) / min / avg
select e.dept_id, min(year_of_exp), avg(year_of_exp)
from employee e
group by e.dept_id;

-- Find the staff_name who has the max year of exp
-- select max(year_of_exp) , staff_name from employee -- wrong compile
-- Sub query -> CTE
select *
from employee
where year_of_exp = (select max(year_of_exp) from employee);

-- CTE
WITH max_year_of_exp AS (
	SELECT MAX(year_of_exp) AS max_exp
	FROM employee
), min_year_of_exp AS (
	SELECT MIN(year_of_exp) AS min_exp
	FROM employee
)
SELECT *
FROM employee e, max_year_of_exp m, min_year_of_exp m2
WHERE e.year_of_exp in (m.max_exp,m2.min_exp);

-- group by + join
select e.dept_id, count(1) as number_of_employee
from employee e, department d
where e.dept_id = d.id
and d.dept_code in ('IT', 'MK') -- filter record before group by
group by e.dept_id 
having count(1) > 1; -- filter group after group by 


-- leet code 1045 
select customer_id 
from customer
group by customer_id
having count(distinct(product_key)) = (select count(*) from product)
-- 1.count(*) from product
-- 2.DISTINCT count(*) from Customer product_key


-- Find all countries of our















    