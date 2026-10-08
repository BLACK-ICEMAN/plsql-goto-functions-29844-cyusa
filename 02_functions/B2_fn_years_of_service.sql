-- file: 02_functions/B2_fn_years_of_service.sql
-- Description: Function that calculates the complete years of service of an employee from their hire date up to today.

create or replace function fn_years_of_service (
    p_hire_date in date
) return number is
    v_years number;
begin
    -- if there is no hire date, there is no answer
    if p_hire_date is null then
        return null;
    end if;

    -- months between today and the hire date, divided by 12 = years
    -- floor removes the decimals (6.7 years becomes 6 complete years)
    v_years := floor(months_between(sysdate, p_hire_date) / 12);

    return v_years;
end fn_years_of_service;
/

-- this query shows the years of service for all employees, using the fn_years_of_service function
select employee_id,
       emp_first_name,
       hire_date,
       fn_years_of_service(hire_date) as years_of_service
from   employees
order  by employee_id;


commit;
