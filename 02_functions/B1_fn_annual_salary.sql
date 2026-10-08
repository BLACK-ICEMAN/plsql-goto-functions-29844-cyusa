-- file: 02_functions/B1_fn_annual_salary.sql
-- Description: Creates a stored function fn_annual_salary that calculates the total gross annual salary from a MONTHLY salary and an optional commission percentage, NULL commission is treated as 0.

create or replace function fn_annual_salary (
    p_salary         in number,
    p_commission_percentage in number default 0
) return number is
    v_base_annual    number;
    v_commission_amt number;
    v_total_annual   number;
begin
    -- return NULL if salary is missing or invalid
    if p_salary is null or p_salary < 0 then
        return null;
    end if;

    -- 12-month base salary
    v_base_annual := p_salary * 12;

    -- annual commission (nvl turns a NULL commission into 0)
    v_commission_amt := v_base_annual * nvl(p_commission_percentage, 0);

    -- total gross annual salary
    v_total_annual := v_base_annual + v_commission_amt;

    return round(v_total_annual, 2);
end fn_annual_salary;
/

-- this query shows the annual salary for all employees, using the fn_annual_salary function
select employee_id,
       salary,
       commission_percentage,
       fn_annual_salary(salary, commission_percentage) as annual_salary
from   employees
order  by employee_id; 

commit;