 -- file: 01_goto/A1_number_classifier.sql
 -- Description: A simple Anonymous PL/SQL block that classifies a user-entered number as positive, negative, or zero using GOTO statement

 set serveroutput on;
 -- verify off; hides the old/new substitution lines so that output shows only the lines actually printed by dbms_output.put_line. 
 -- it is optional, the program works exactly the same without it. 
 set verify off;
 
 accept input_number number prompt 'Enter a number to classify (positive, negative, or zero): ';
 declare 

 -- Prompt user for input number
 input_number number := &input_number; 

 begin 

 dbms_output.put_line(' Input number: ' || input_number);

 -- Classify the number entered by the user using goto statement 
 if input_number > 0 then 
 goto positive_number;
 elsif input_number < 0 then 
 goto negative_number;
 else 
 goto number_is_zero;
 end if;

 <<positive_number>>
 dbms_output.put_line('Classification: The number ' || input_number || ' is positive.');
 goto end_program;

 <<negative_number>>
 dbms_output.put_line('Classification: The number ' || input_number || ' is negative');
 goto end_program;

<<number_is_zero>>
dbms_output.put_line('Classification: The number ' || input_number || ' is zero');
goto end_program;

<<end_program>>
dbms_output.put_line('Classification completed successfully!');

end;
/

commit;