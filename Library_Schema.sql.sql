-- Library Management System Project 2
-- creating branch table

drop table if exists branch;
create table branch
(
	branch_id varchar(10) primary key,	
	manager_id	varchar(20),
	branch_address	varchar(50),
	contact_no varchar(20)


);
drop table if exists employees;
create table employees
	(
		emp_id	varchar(10) primary key,
		emp_name	varchar(30),
		position	varchar(30),
		salary	int,
		 branch_id	varchar(30) --FK


);
drop table if exists books;
create table books
(
			isbn varchar(20) primary key,
			book_title varchar(80),
			category varchar(20),
			rental_price float,
			status	varchar(20),
			author varchar(50),
			publisher varchar(50)

);
drop table if exists members;
create table members
	(
		member_id varchar(10) primary key ,
		member_name varchar(20),
		member_address varchar(15),
		reg_date date


);

drop table if exists issued_status;
create table issued_status
	(
		issued_id varchar(20) primary key,
		issued_member_id varchar(20), --FK
		issued_book_name varchar(70),
		issued_date date,
		issued_book_isbn varchar(30), --FK
		issued_emp_id varchar(20) --FK


	);

drop table if exists return_status;
create table return_status
	(
	return_id varchar(25) primary key,
	issued_id	varchar(25),
	return_book_name	varchar(75),
	return_date	date,
	return_book_isbn varchar(25)


);


--- foriegn key
ALTER TABLE	issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE	issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);


ALTER TABLE	issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

ALTER TABLE	employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);


ALTER TABLE	return_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY (issued_id)
REFERENCES issued_status(issued_id);






