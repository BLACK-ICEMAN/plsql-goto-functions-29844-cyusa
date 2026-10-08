# PL/SQL GOTO Statements and Functions

**Course:** Database Development with PL/SQL  

**Assignment:** Individual Assignment III - PL/SQL GOTO Statements and Functions  

**Student:** CYUSA Bruno  
**Student ID:** 29844  


---

## Overview

This repository contains my individual work on PL/SQL `GOTO` statements, stored functions, exception handling, and functions used inside SQL queries. All programs read from two sample tables, `departments` and `employees`, created by the setup script.

| Part | Topic | Files |
|---|---|---|
| Setup | Sample tables and seed data | `00_setup/create_tables.sql` |
| A | GOTO statements | `01_goto/A1` to `A4` |
| B | Stored functions | `02_functions/B1` to `B4`, `03_tests/B5` |
| C | Combined task | `02_functions/C1`, `docs/REFLECTION.md` |

---

## Prerequisites

- Oracle Database (23c Free / AI Edition or similar) with a user that can create tables and functions
- An SQL client: Oracle SQL Developer or VS Code with the Oracle SQL Developer extension
- Scripts must be run with **Run Script** (F5 in SQL Developer), not as a single statement, because they use `set serveroutput on`, `accept`, and `set verify off`

---

## Repository Structure

```
plsql-goto-functions-<studentID>-<firstname>/
├── README.md
├── .gitignore
├── 00_setup/
│   └── create_tables.sql
├── 01_goto/
│   ├── A1_number_classifier.sql
│   ├── A2_salary_review.sql
│   ├── A3_illegal_goto.sql
│   └── A4_rewrite_no_goto.sql
├── 02_functions/
│   ├── B1_fn_annual_salary.sql
│   ├── B2_fn_years_of_service.sql
│   ├── B3_fn_calculate_tax.sql
│   ├── B4_fn_dept_name.sql
│   └── C1_fn_validate_payroll.sql
├── 03_tests/
│   ├── B5_functions_in_select.sql
│   ├── test_functions.sql
│   └── test_validate_payroll.sql
├── screenshots/
│   ├── A1_output.png
│   ├── A2_output.png
│   ├── A3_error_and_fix.png
│   ├── A4_output.png
│   ├── B5_select_output.png
│   └── C1_output.png
└── docs/
    └── REFLECTION.md
```

---

## How to Run

Run the files in this order:

1. `00_setup/create_tables.sql` - creates and fills `departments` (8 rows) and `employees` (10 rows). The script drops the tables first, so it can be rerun safely.  
### You will get an output like this one for each table created.  
<img width="552" height="277" alt="Table department" src="https://github.com/user-attachments/assets/f6548ce7-7791-4a49-970b-0d1ae9b10a41" />
<img width="1012" height="315" alt="Table employees" src="https://github.com/user-attachments/assets/c0218bd3-b03f-4a75-947f-e9762861fcea" />


2.The programs in `01_goto/` (A1 to A4). A1 and A4 ask for a number through `accept`.    
### Here you will see screenshots of goto statements output per program order from A1 to A4
<img width="1455" height="980" alt="A1_output" src="https://github.com/user-attachments/assets/dc28505d-824f-42e6-833d-a1673e9fa868" />
<img width="1387" height="787" alt="A2_output" src="https://github.com/user-attachments/assets/ea143a42-c5f1-4c04-adca-9848bfa5b87c" />
<img width="916" height="478" alt="A3_error_and_fix" src="https://github.com/user-attachments/assets/20c8c48d-e006-4719-af48-4516932bad1e" />
<img width="1312" height="650" alt="A4_output" src="https://github.com/user-attachments/assets/0196ad18-1dab-48d0-a02a-49d30f4d285a" />


3.  The functions in `02_functions/`, in this order: B1, B2, B3, B4, then C1 (C1 uses B2, B3 and B4).  
### You will see something like this for each commit
<img width="390" height="184" alt="b1 annual salary" src="https://github.com/user-attachments/assets/36098bbe-84dd-410b-b2de-ed27b7c8ca69" />
<img width="392" height="179" alt="b2 years of experience" src="https://github.com/user-attachments/assets/fbe1e6ce-6c1b-46c2-a0e1-76debcc6c5be" />
<img width="436" height="179" alt="tax calculation" src="https://github.com/user-attachments/assets/20f7dc89-cb69-4787-b6a8-6c031ae58a1f" />


4. The test files in `03_tests/`: `test_functions.sql`, `B5_functions_in_select.sql`, `test_validate_payroll.sql`.  
### You will see something like this here also  
<img width="485" height="401" alt="image" src="https://github.com/user-attachments/assets/88c9f3d1-ac64-4ce9-8cc2-c93f0bda14bb" />

<img width="661" height="406" alt="B5_select_output" src="https://github.com/user-attachments/assets/ed1afaf2-7810-4bbe-bcbf-4c1f867a71f3" />
<img width="536" height="406" alt="image" src="https://github.com/user-attachments/assets/acf29362-0ba4-4f55-9a96-3afafd85d8c0" />

5. Compare the output with the screenshots in `screenshots/`.

Quick check after step 1:

```sql
select count(*) from departments;  -- expect 8
select count(*) from employees;    -- expect 10
```

---

## Project Summary

### Part A - GOTO

| Task | What it does |
|---|---|
| A1 Number Classifier | Reads a number from the user and uses `GOTO` to classify it as positive, negative, or zero |
| A2 Salary Review | Compares each employee's salary with the average and uses `GOTO` to label it below average, average, or above average |
| A3 Illegal GOTO and Fix | Shows a `GOTO` that jumps into an `IF` block (error `PLS-00375`), then two legal fixes |
| A4 Rewrite Without GOTO | Rewrites A1 with `IF/ELSIF` and A2 with `CASE` |

### Part B - Functions

| Task | Function | What it does |
|---|---|---|
| B1 | `fn_annual_salary(salary, commission)` | Monthly salary x 12 x (1 + commission) |
| B2 | `fn_years_of_service(hire_date)` | Complete years from hire date to today |
| B3 | `fn_calculate_tax(salary)` | Monthly PAYE tax using progressive brackets |
| B4 | `fn_dept_name(department_id)` | Department name, with `no_data_found` handling |
| B5 | ` Functions in SQL` | Uses B1 to B4 in the `SELECT` list, `WHERE`, and `GROUP BY` |

### Part C - Combined Task

| Task | What it does |
|---|---|
| C1 `fn_validate_payroll(employee_id)` | Checks one employee's payroll data and returns `INVALID: <reason>` or `VALID` with department, years of service, and tax. Uses B2, B3 and B4 |
| C2 Reflection | `docs/REFLECTION.md` |

---

## Assumptions

The assignment does not give every rule, so I made these choices:

1. **Salary is a monthly amount in RWF.** `fn_annual_salary` multiplies it by 12, and `fn_calculate_tax` applies monthly PAYE brackets.
2. **Commission is stored as a fraction** (0.05 means 5%). A `NULL` commission is treated as 0.
3. **A2 "average" band:** a salary within 10% of the average salary counts as average. Below that is below average, above that is above average.
4. **B3 tax brackets** follow Rwanda PAYE on monthly income: 0% up to 30,000, 20% from 30,001 to 100,000, and 30% above 100,000. Tax is progressive, so each rate applies only to the part of the salary inside its band. These figures come from online tax guides, not an official Rwanda Revenue Authority document, so they are for learning only.
5. **B4 messages:** a `NULL` department ID returns `Unassigned`, and an ID that does not exist returns `Unknown Department`.
6. **C1 validation rules:** the employee must exist, salary must be present and greater than 0, commission must be between 0 and 1, hire date cannot be in the future, and the department must exist.
7. **Missing values:** functions return `NULL` when the main input is `NULL`, because "unknown" is different from 0.

---

## Screenshots

| File | Shows |
|---|---|
| `A1_output.png` | Number classifier run with a test value |
| `A2_output.png` | Salary review for all 10 employees |
| `A3_error_and_fix.png` | The `PLS-00375` error and the corrected blocks |
| `A4_output.png` | Rewritten programs without `GOTO` |
| `B5_select_output.png` | Functions called inside a `SELECT` |
| `C1_output.png` | Payroll validator showing VALID and INVALID results |

---

## Notes

**Use of an AI assistant:** I used an AI assistant (Claude) while working on this assignment. I used it to review my code and find errors (for example a `crate` typo, a wrong variable name, and an oversized `varchar2`), to explain concepts such as `GOTO` scope rules, `NVL`, `no_data_found`, and progressive tax, and to suggest drafts that I then tested, changed, and ran myself. The assumptions listed above were my decisions. I have read every file in this repository and can explain it.

---

## Author

CYUSA Bruno    
Student ID 29844  

AUCA - INSY 8311, October 2026
