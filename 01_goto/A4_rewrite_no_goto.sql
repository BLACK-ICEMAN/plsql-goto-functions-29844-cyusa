-- file: 01_goto/A4_rewrite_no_goto.sql
-- Description: Rewrites A1 (Number Classifier) and A2 (Salary Review)
--              without GOTO, using IF/ELSIF and CASE

set serveroutput on;
set verify off;

-- =====================================================
-- PART 1: A1 Number Classifier without GOTO (IF / ELSIF)
-- =====================================================
accept input_number number prompt 'Enter the number to classify: '

declare
    input_number number := &input_number;
begin
    
    dbms_output.put_line(' ####  NUMBER CLASSIFIER (WITHOUT GOTO) #### ');
    dbms_output.put_line('');
    dbms_output.put_line('Input Number: ' || input_number);

    if input_number > 0 then
        dbms_output.put_line('Classification: The number ' || input_number || ' is positive.');
    elsif input_number < 0 then
        dbms_output.put_line('Classification: The number ' || input_number || ' is negative.');
    else
        dbms_output.put_line('Classification: The number ' || input_number || ' is zero.');
    end if;

    dbms_output.put_line('Classification completed successfully!');
    dbms_output.put_line('');
end;
/

-- =====================================================
-- PART 2: A2 Salary Review without GOTO (CASE)
-- =====================================================
declare
    avg_salary      number(10, 2);
    avg_lower       number(10, 2);
    avg_upper       number(10, 2);
    salary_category varchar2(30);
begin
    -- average salary of all employees
    select avg(salary) into avg_salary from employees;

    -- "average" band: within 10% of the average salary
    avg_lower := avg_salary * 0.9;
    avg_upper := avg_salary * 1.1;

    dbms_output.put_line(' ####  SALARY REVIEW (WITHOUT GOTO) ####');
    dbms_output.put_line('');
    dbms_output.put_line('Average salary: ' || to_char(avg_salary, '999,999.00'));
    dbms_output.put_line('Average band:   ' || to_char(avg_lower, '999,999.00') || ' to ' || to_char(avg_upper, '999,999.00'));
    dbms_output.put_line('');

    for emp in (select employee_id, emp_first_name || ' ' || emp_last_name as full_name, salary from   employees
                where  salary is not null order  by employee_id)
    loop
        -- CASE sets the category directly, no jumping needed
        salary_category := case
                               when emp.salary < avg_lower then 'Below Average'
                               when emp.salary > avg_upper then 'Above Average'
                               else 'Average'
                           end;

        dbms_output.put_line('Employee ID: ' || emp.employee_id || ' | Name: ' || emp.full_name || ' | Salary: $' || to_char(emp.salary, '999,999.00') || ' | Category: ' || salary_category);
    end loop;

    dbms_output.put_line('');
    dbms_output.put_line('Salary review completed successfully.');
end;
/

commit;