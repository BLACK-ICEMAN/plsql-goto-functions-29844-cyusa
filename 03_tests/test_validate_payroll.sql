    -- file: 03_tests/test_validate_payroll.sql
    -- Description: Tests fn_validate_payroll on real employees and on
    --              temporary bad rows (removed with rollback at the end).

    set serveroutput on;

    -- =====================================================
    -- PART 1: all real employees (should all be VALID)
    -- =====================================================
    begin
        dbms_output.put_line('--- Payroll validation: real employees ---');

        for emp in (select employee_id, emp_first_name
                    from   employees
                    order  by employee_id)
        loop
            dbms_output.put_line('Employee ' || emp.employee_id
                                || ' ' || emp.emp_first_name
                                || ': ' || fn_validate_payroll(emp.employee_id) || ' (should be VALID)');
        end loop;
    end;
    /

    -- =====================================================
    -- PART 2: temporary bad data (removed by rollback)
    -- =====================================================
    insert into employees (employee_id, emp_first_name, emp_last_name, department_id, salary, commission_percentage)
    values (91, 'Test', 'NoSalary', 1, null, null);

    insert into employees (employee_id, emp_first_name, emp_last_name, department_id, salary, commission_percentage)
    values (92, 'Test', 'NegativeSalary', 1, -500, null);

    insert into employees (employee_id, emp_first_name, emp_last_name, department_id, salary, commission_percentage)
    values (93, 'Test', 'BadCommission', 1, 50000, 1.5);

    insert into employees (employee_id, emp_first_name, emp_last_name, department_id, hire_date, salary, commission_percentage)
    values (94, 'Test', 'FutureHire', 1, sysdate + 30, 50000, null);

    begin
        dbms_output.put_line('');
        dbms_output.put_line('  ### Payroll validation: data with issues so we can see the validation messages to bad data ###');
        dbms_output.put_line('');
        dbms_output.put_line('Employee 11 (no salary):      ' || fn_validate_payroll(91));
        dbms_output.put_line('Employee 12 (negative):       ' || fn_validate_payroll(92));
        dbms_output.put_line('Employee 13 (commission 1.5): ' || fn_validate_payroll(93));
        dbms_output.put_line('Employee 14 (future hire):    ' || fn_validate_payroll(94));
        dbms_output.put_line('Employee 15 (not found):     ' || fn_validate_payroll(999));
        dbms_output.put_line('NULL ID:                      ' || fn_validate_payroll(null));
    end;
    /

    -- remove the temporary rows
    rollback;

    -- check: the table is back to 10 employees
    select count(*) as employee_count from employees;

    commit;