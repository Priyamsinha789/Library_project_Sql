select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;



---Project Task

--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
select * from books;


--Task 2. Update an existing Member's address
update members
set member_address = '125 Main St'
Where member_id = 'C101';
select * from members


--Task 3. Delete a Record from the issued Status Table 
-- Objective : Delete the record with issued_id = 'ISI140' from the issued_status table.

select * from issued_status;

delete from issued_status
where issued_id = 'IS140';

--Task 4. Retrieve all books issued by a specific Employee
-- Objective : Select all the books issued by the employee with emp_id = 'E101'

select * from issued_status
where issued_emp_id = 'E101';


--Task 5 . List Members who have issued More than one book
-- Objective : Use Group BY to find members who have issued more than one book.

select 
	issued_emp_id,
	count(issued_id) as total_book_issued
from issued_status
group by issued_emp_id
having count(issued_id) > 1

--CTAS
--Task 6. Create Summary Tables: Used CTAS to generate new tables based on query results - each book and totalbook_issued_cnt**
create table book_cnts
as
SELECT 
	b.isbn,
	b.book_title,
	count(ist.issued_id) as no_issued
from books as b
join 
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1,2;

select * from book_cnts;

--- Data Analysis & Finding
--Task 7. Retrieve all books in a specific Category
select * from books
Where category = 'Classic'


--Task 8: Find Total Rental Income by Category
select 
	b.category,
	sum(b.rental_price),
	count(*)
from books as b
join 
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1


-- Task.9 List Members who registered in the last 180 days:

select * from members
where reg_date >= current_date - Interval '180 days'

insert into members(member_id, member_name, member_address,reg_date)
values
('C120','sam','145 Main St','2026-07-08'),
('C121','sam','145 Main St','2026-07-08');


-- Task 10. List Employee with Their Branch Manager's Name and their branch details:

select 
	e1.*,
	b.manager_id,
	e2.emp_name as manager
from employees as e1
join 
branch as b
on b.branch_id = e1.branch_id
join
employees as e2
on b.manager_id = e2.emp_id


--Task 11. Create a Table of books with Rental Price Above a Certain Thresold 10USD:

create table books_price_greater_than_seven
as
select * from Books
where rental_price >7


select * from books_price_greater_than_seven


-- Task.12 Retireve the list of books not yet Returned

select 
	Distinct ist.issued_book_name
from issued_status as ist
left join
return_status as rs
on ist.issued_id = rs.issued_id
where rs.return_id is null


select * from return_status


/*
Task 13: Identify Members with Overdue books
Write a query to identify members who have overdue books ( assume a 30-day return period). Display the member's_id, member' name
book title, issue date , and days overdue.
*/

-- issued_status == members == books == return_status
-- filter books which is return 
-- overdue > 30

select * 
from issued_status as ist
join 
members as m
	on m.member_id = ist.issued_member_id
join 
books as bk
on bk.isbn = ist.issued_book_isbn
left join 
return_status as rs
on rs.issued_id = ist.issued_id













