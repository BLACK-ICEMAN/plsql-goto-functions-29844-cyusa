-- file: 03_tests/B5_functions_in_select.sql
-- Description: Uses the stored functions (B1 to B4) inside SQL statements.
--              All data comes from the employees table.
--              Run the function files in 02_functions first.

-- =====================================================
-- QUERY 1: functions in the SELECT list
-- =====================================================
select employee_id,
       emp_first_name,
       fn_dept_name(department_id)                     as department,
       salary                                          as monthly_salary,
       fn_annual_salary(salary, commission_percentage) as annual_salary,
       fn_years_of_service(hire_date)                  as years_of_service,
       fn_calculate_tax(salary)                        as tax
from   employees
order  by employee_id;

-- =====================================================
-- QUERY 2: a function in the WHERE clause
-- (employees with 6 or more years of service)
-- =====================================================
select employee_id,
       emp_first_name,
       hire_date,
       fn_years_of_service(hire_date) as years_of_service
from   employees
where  fn_years_of_service(hire_date) >= 6
order  by employee_id;

-- =====================================================
-- QUERY 3: functions with GROUP BY
-- (number of employees and total tax for each department)
-- =====================================================
select fn_dept_name(department_id)    as department,
       count(*)                       as employees,
       sum(fn_calculate_tax(salary))  as total_tax
from   employees
group  by fn_dept_name(department_id)
order  by department;

commit;