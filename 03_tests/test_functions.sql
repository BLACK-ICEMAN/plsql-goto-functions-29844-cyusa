-- file: 03_tests/test_functions.sql
-- Description: Runs the functions from 02_functions (B1 to B4) on every
--              employee in the employees table.
--              Run create_tables.sql and the function files first.

set serveroutput on;

begin
    dbms_output.put_line(' Functions on the employees table ');
    dbms_output.put_line('');

    for emp in (select employee_id, emp_first_name, department_id,
                       hire_date, salary, commission_percentage
                from   employees
                order  by employee_id)
    loop
        dbms_output.put_line(' ### Employee ' || emp.employee_id || ' ' || emp.emp_first_name);
        dbms_output.put_line('   Department : ' || fn_dept_name(emp.department_id));
        dbms_output.put_line('');
        dbms_output.put_line('   Annual pay : '
                             || fn_annual_salary(emp.salary, emp.commission_percentage));
                             dbms_output.put_line('');
        dbms_output.put_line('   Years      : ' || fn_years_of_service(emp.hire_date));
        dbms_output.put_line('');
        dbms_output.put_line('   Tax        : ' || fn_calculate_tax(emp.salary));
        dbms_output.put_line('');
    end loop;
end;
/

commit;