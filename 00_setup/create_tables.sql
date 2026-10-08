-- File: 00_setup/create_tables.sql
-- Description: Creates sample departments and employees tables with seed data for PL/SQL functions

set serveroutput on;

-- Just to make sure everything runs smoothly, drop old tables (if they exist) so that the script can be run multiple times without errors. 
drop table employees cascade constraints;
drop table departments cascade constraints;

-- Create first table Departments
create table departments (
    department_id number(5) primary key, department_name varchar2(50) not null, location_id number(5) not null
                         );

-- create second table Employees with foreign key to departments table
create table employees (
    employee_id number(5) primary key, emp_first_name varchar2(50) not null, emp_last_name varchar2(50) not null, department_id number(5) not null,  
    hire_date date default sysdate not null, salary number(10, 2), commission_percentage number(5, 2), constraint fk_emp_dept foreign key (department_id) references
    departments (department_id) on delete cascade
                      );


-- Insert sample data into departments table
insert into departments (department_id, department_name, location_id) values (1, 'Administration', 1700);
insert into departments (department_id, department_name, location_id) values (2, 'Sales', 1800);
insert into departments (department_id, department_name, location_id) values (3, 'IT', 1900);
insert into departments (department_id, department_name, location_id) values (4, 'Marketing', 2000);
insert into departments (department_id, department_name, location_id) values (5, 'Finance', 2100);
insert into departments (department_id, department_name, location_id) values (6, 'Human Resources', 2200);
insert into departments (department_id, department_name, location_id) values (7, 'Research and Development', 2300);
insert into departments (department_id, department_name, location_id) values (8, 'Customer Service', 2400);

-- Insert sample data into employees table
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (1, 'John', 'Doe', 1, to_date('2020-01-15', 'YYYY-MM-DD'), 60000, null);
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (2, 'Jane', 'Smith', 2, to_date('2019-03-10', 'YYYY-MM-DD'), 75000, 0.05);
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (3, 'Michael', 'Johnson', 3, to_date('2021-07-20', 'YYYY-MM-DD'), 80000, null);
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (4, 'Emily', 'Davis', 4, to_date('2018-11-05', 'YYYY-MM-DD'), 70000, null);
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (5, 'William', 'Brown', 5, to_date('2022-02-28', 'YYYY-MM-DD'), 65000, null);
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (6, 'Olivia', 'Wilson', 6, to_date('2020-09-15', 'YYYY-MM-DD'), 72000, null);
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (7, 'James', 'Taylor', 7, to_date('2019-05-22', 'YYYY-MM-DD'), 68000, null);
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (8, 'Sophia', 'Anderson', 8, to_date('2021-12-01', 'YYYY-MM-DD'), 71000, null);
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (9, 'Daniel', 'Thomas', 2, to_date('2020-06-18', 'YYYY-MM-DD'), 78000, 0.07);
insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage) values (10, 'Ava', 'Jackson', 3, to_date('2019-08-30', 'YYYY-MM-DD'), 82000, null);   

commit;

-- to display tables after creation and insertion of the sample data.
select * from departments;  
select * from employees; 

begin
dbms_output.put_line('Tables created and sample data inserted successfully!');
end;
/


commit;
