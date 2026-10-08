-- file: 01_goto/A3_illegal_goto.sql
-- description:  an illegal GOTO in Oracle PL/SQL (jumping into an IF block) and the corrected versions

set serveroutput on;

-- =====================================================
-- PART 1: ILLEGAL GOTO (this block fails to compile)
-- =====================================================
declare
    v_salary number(10, 2);
begin
    select salary into v_salary from employees where employee_id = 1;

    goto review_message;          
    -- ILLEGAL: label is inside the IF block below

    if v_salary < 65000 then
        <<review_message>>
        dbms_output.put_line('Salary ' || v_salary || ' needs a review.');
    end if;
end;
/

-- =====================================================
-- PART 2: FIX 1 - move the label to the same level as the GOTO
-- =====================================================
declare
    v_salary number(10, 2);
begin
    select salary into v_salary from employees where employee_id = 1;

    goto review_message;          
    -- LEGAL: label is in the same block

    dbms_output.put_line('This line is skipped.');

    <<review_message>>
    if v_salary < 65000 then
        dbms_output.put_line('Fix 1: Salary ' || v_salary || ' needs a review.');
    else
        dbms_output.put_line('Fix 1: Salary ' || v_salary || ' is fine.');
    end if;
end;
/

-- =====================================================
-- PART 3: FIX 2 - jump OUT of the IF instead of into it
-- =====================================================
declare
    v_salary number(10, 2);
begin
    select salary into v_salary from employees where employee_id = 1;

    if v_salary < 65000 then
        dbms_output.put_line('Fix 2: Salary ' || v_salary || ' needs a review.');
        goto end_review;          
        -- LEGAL: jumping OUT of an IF block
    end if;

    dbms_output.put_line('Fix 2: Salary is fine, no review needed.');

    <<end_review>>
    dbms_output.put_line('Review check completed.');
end;
/

commit;