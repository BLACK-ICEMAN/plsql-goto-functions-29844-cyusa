-- file: 02_functions/C1_fn_validate_payroll.sql
-- Description: Function that validates the payroll data of one employee.
--              It returns 'INVALID: ...' with the first problem found, or
--              'VALID | ...' with department, years of service and tax.
--              It uses fn_dept_name (B4), fn_years_of_service (B2)
--              and fn_calculate_tax (B3), so run those files first.

create or replace function fn_validate_payroll (
    p_employee_id in number
) return varchar2 is
    v_salary     number;
    v_commission number;
    v_hire_date  date;
    v_dept_id    number;
    v_dept_name  varchar2(50);
begin
    -- check 1: an ID must be given
    if p_employee_id is null then
        return 'INVALID: Employee ID is missing';
    end if;

    -- check 2: the employee must exist (no_data_found is handled below)
    select salary, commission_percentage, hire_date, department_id
    into   v_salary, v_commission, v_hire_date, v_dept_id
    from   employees
    where  employee_id = p_employee_id;

    -- check 3 and 4: salary rules
    if v_salary is null then
        return 'INVALID: Salary is missing';
    end if;

    if v_salary <= 0 then
        return 'INVALID: Salary must be greater than 0';
    end if;

    -- check 5: commission is a fraction (0.05 = 5%)
    if v_commission is not null and (v_commission < 0 or v_commission > 1) then
        return 'INVALID: Commission must be between 0 and 1';
    end if;

    -- check 6: hire date cannot be in the future
    if v_hire_date > sysdate then
        return 'INVALID: Hire date is in the future';
    end if;

    -- check 7: the department must exist (uses B4)
    v_dept_name := fn_dept_name(v_dept_id);

    if v_dept_name = 'Unknown Department' or v_dept_name = 'Unassigned' then
        return 'INVALID: Department not found';
    end if;

    -- everything passed: build a summary using B4, B2 and B3
    return 'VALID | Dept: ' || v_dept_name
           || ' | Years: ' || fn_years_of_service(v_hire_date)
           || ' | Tax: ' || fn_calculate_tax(v_salary);

exception
    when no_data_found then
        return 'INVALID: Employee not found';
end fn_validate_payroll;
/

commit;