show databases;

create database db_bc2311;

use db_bc2311;

CREATE USER 'ilsa'@'localhost' IDENTIFIED BY 'admin1234';

ALTER USER 'ilsa'@'localhost' IDENTIFIED BY 'ilsalam1204';

GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'ilsa'@'localhost' WITH GRANT OPTION;

SHOW VARIABLES LIKE 'validate_password%';
SET GLOBAL validate_password.policy = LOW;

create table customer (
	id integer not null,
    cust_name varchar(50) not null,
	cust_email_addr varchar(30),
    cust_phone varchar(50)
    );

insert into customer(id, cust_name, cust_email_addr, cust_phone) values (1, 'John Lau', 'john@gmail.com', '12345678');

select * from customer;


    