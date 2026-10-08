-- file: 01_goto/A2_salary_review.sql
-- description: A simple PL/SQL anonymous block to review employee salaries and classify them as below average, average, or above average using GOTO statement

set serveroutput on;

declare 
    -- declare variables to hold the average salary and employee salary
    avg_salary number(10, 2);
    avg_lower number(10, 2);
    avg_upper number(10, 2);
    salary_category varchar2(20);

begin 

-- average salary of all employees
select avg(salary) into avg_salary from employees;

-- calculate the lower and upper bounds for average salary range
avg_lower := avg_salary * 0.9; 
-- 10% below average
avg_upper := avg_salary * 1.1; 
-- 10% above average

dbms_output.put_line('  ####  Salary Review  #### ');
dbms_output.put_line('   ##   average salary: ' || to_char(avg_salary, '999,999.00'));
dbms_output.put_line('');
dbms_output.put_line('');
 
for emp in (select employee_id, emp_first_name || ' ' || emp_last_name as full_name, salary from employees where salary is not null order by employee_id) 
loop 
    -- classify employee salary 
    if emp.salary < avg_lower then
        goto below_average;
    elsif emp.salary > avg_upper then
        goto above_average;
    else 
        goto average;
        end if;

<<below_average>>
    salary_category := 'Below Average';
    dbms_output.put_line('Employee ID: ' || emp.employee_id || ' | Name: ' || emp.full_name || ' | Salary: $' || to_char(emp.salary, '999,999.00') || ' | Category: ' || salary_category);
    dbms_output.put_line('');

    goto end_loop;

<<above_average>>
    salary_category := 'Above Average';
    dbms_output.put_line('Employee ID:' || emp.employee_id || ' | Name: ' ||emp.full_name || ' | salary: $' || emp.salary || ' | category: ' || salary_category);
    dbms_output.put_line('');

    goto end_loop;

<<average>> 
    salary_category := ' Average';
    dbms_output.put_line('Employee ID: ' || emp.employee_id || ' |Name:  ' || emp.full_name || ' | salary: $' || emp.salary || ' | category: ' || salary_category);
    dbms_output.put_line('');

    goto end_loop;

<<end_loop>>
dbms_output.put_line(' >>> Salary review process completed successfully for: ');
end loop;

end;
/

commit;


