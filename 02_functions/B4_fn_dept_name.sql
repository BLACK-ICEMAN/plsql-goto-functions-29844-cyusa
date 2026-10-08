-- file: 02_functions/B4_fn_dept_name.sql
-- Description: Function that returns the department name for a given
--              department ID, using the departments table.
--              NULL ID returns 'Unassigned'.
--              An ID that does not exist returns 'Unknown Department'.

set serveroutput on;
set verify off;

create or replace function fn_dept_name (
    p_dept_id in number
) return varchar2 is
    v_dept_name varchar2(50);
begin
    -- if there is no ID, the employee has no department
    if p_dept_id is null then
        return 'Unassigned';
    end if;

    -- look up the name in the departments table
    select department_name
    into   v_dept_name
    from   departments
    where  department_id = p_dept_id;

    return v_dept_name;

exception
    -- runs when the select finds no row with that ID
    when no_data_found then
        return 'Unknown Department';
end fn_dept_name;
/

-- this block shows the department name for a given department ID, using the fn_dept_name function
accept input_dept_id number prompt 'Enter the department ID: '

declare
    v_dept_id number := &input_dept_id;
    v_name    varchar2(50);
begin
    v_name := fn_dept_name(v_dept_id);

    dbms_output.put_line('--- Department Lookup ---');
    dbms_output.put_line('Department ID: ' || v_dept_id);
    dbms_output.put_line('Department Name: ' || v_name);
end;
/

commit;