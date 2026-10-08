-- file: 02_functions/B3_fn_calculate_tax.sql
-- Description: Function that calculates the monthly PAYE income tax in Rwanda (RWF). The salary is read from the employees table. Brackets: -> 0 - 30,000 = 0% -> 30,001 - 100,000 = 20%  -> above 100,000 = 30%

create or replace function fn_calculate_tax (
    p_salary in number
) return number is
    v_tax number;
begin
    -- if there is no salary, there is no tax to calculate
    if p_salary is null or p_salary < 0 then
        return null;
    end if;

    if p_salary <= 30000 then
        -- first band: no tax
        v_tax := 0;
    elsif p_salary <= 100000 then
        -- 20% only on the part above 30,000
        v_tax := (p_salary - 30000) * 0.20;
    else
        -- 20% on the whole middle band (70,000 x 0.20 = 14,000)
        -- plus 30% on the part above 100,000
        v_tax := 14000 + (p_salary - 100000) * 0.30;
    end if;

    return v_tax;
end fn_calculate_tax;
/

-- this query shows the monthly PAYE tax and the salary after tax for all employees, using the fn_calculate_tax function
select employee_id,
       emp_first_name,
       salary,
       fn_calculate_tax(salary)          as paye_tax,
       salary - fn_calculate_tax(salary) as salary_after_tax
from   employees
order  by employee_id;

commit;