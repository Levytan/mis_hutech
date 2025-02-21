-- Bài 1
CREATE DATABASE bt1
USE bt1

CREATE TABLE MEMBERS (
    CardNo char(5) primary key,
    Surname nvarchar(15) not null,
    [Name] nvarchar(15) not null,
    Birthdate date,
    Gender char(1) CHECK (Gender in ('M', 'F')),
    PhoneNo nvarchar(15)
)
CREATE TABLE EMPLOYEES (
    EmpId int primary key,
    Surname nvarchar(15) not null,
    [Name] nvarchar(15) not null,
    Birthdate date,
    EmpDate date,
    CHECK (DATEDIFF(year, Birthdate, EmpDate) >= 18)
)
CREATE TABLE PUBLISHERS (
    PubId int primary key,
    [Name] nvarchar(50) not null,
    City nvarchar(50) not null,
    PhoneNo nvarchar(15)
)

CREATE TABLE BOOKS (
    BookId char(5) primary key,
    PubId int references PUBLISHERS(PubId),
    [Type] nvarchar(20),
    Price int not null,
    Title nvarchar(40) not null,
    CHECK ([Type] in (N'Tiểu thuyết', N'Lịch sử', N'Trẻ em',
                      N'Khoa học', N'Giả tưởng', N'Khác'))
)
CREATE TABLE BOOKLOANS (
    LoanId int primary key,
    CardNo char(5) references MEMBERS(CardNo),
    BookId char(5) references BOOKS(BookId),
    DateOut date,
    DueDate date,
    Penalty int default 0,
    CHECK (DateOut < DueDate)
)

-- Bài 2
CREATE DATABASE bt2
USE bt2
CREATE TABLE employees (
    emp_no int primary key,
    birth_date date,
    first_name varchar(14),
    last_name varchar(16),
    gender char(1) check (gender in ('M', 'F')),
    hire_date date
)
CREATE TABLE salaries (
    emp_no int references employees(emp_no),
    salary int,
    from_date date,
    to_date date,
)
CREATE TABLE titles (
    emp_no int references employees(emp_no),
    title varchar(50),
    from_date date,
    to_date date,
)
CREATE TABLE departments (
    dept_no char(4) primary key,
    dept_name varchar(40)
)
CREATE TABLE dept_manager (
    dept_no char(4) references departments(dept_no),
    emp_no int references employees(emp_no),
    from_date date,
    to_date date,
)
CREATE TABLE dept_emp (
    dept_no char(4) references departments(dept_no),
    emp_no int references employees(emp_no),
    from_date date,
    to_date date,
)