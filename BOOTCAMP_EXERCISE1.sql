create DATABASE BOOTCAMP_EXCERCISE1;

use BOOTCAMP_EXCERCISE1;

create table regions(
	region_id integer primary key,
    region_name varchar(25) not null
    );
select * from regions;
    
create table countries(
	country_id char(2) primary key,
    country_name varchar(40),
    region_id integer, -- reference
    foreign key (region_id) references regions(region_id) -- foreign key
    );
select * from countries;

create table locations(
	location_id integer primary key,
    street_address varchar(25),
    potal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2), -- reference
    foreign key (country_id) references countries(country_id) -- foreign key
    );
select * from locations;
    
create table departments(
	department_id integer primary key,
    department_name varchar(20) not null,
    manager_id integer unique,
    location_id integer not null, -- reference
    foreign key (location_id)references locations(location_id) -- foreign key
    );
select * from departments;

create table jobs(
	job_id varchar(10) primary key,
    job_title varchar(35),
    min_salary integer,
    max_salary integer
    );
select * from jobs;

create table employees(
	employee_id integer primary key,
    first_name varchar(20) not null,
    last_name varchar(25) not null,
    email varchar(25)unique,
    phone_number varchar(20)unique,
    hire_date date not null,
    job_id varchar(10)unique,
    salary double,
    commission_pct double,
    manager_id integer unique,
    department_id integer,
    foreign key (job_id)references jobs(job_id),
    foreign key (department_id)references departments(department_id)
    );
select * from employees;

create table job_history(
	employee_id integer, -- reference
	start_date date primary key,
    end_date date,
    job_id varchar(10),
    department_id integer, -- reference
    foreign key (employee_id)references employees(employee_id), -- foreign key
    foreign key (department_id)references departments(department_id) -- foreign key
    );
select * from job_history;
    