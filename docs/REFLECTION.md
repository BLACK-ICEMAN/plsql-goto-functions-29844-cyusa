# Reflection - PL/SQL GOTO Statements and Functions

**Name:** CYUSA Bruno  
**Student ID:** 29844   
**Course:** Database Development with PL/SQL

This reflection covers seven areas: control flow, data handling in functions, debugging, structured code versus GOTO, my design decisions, process changes, and my use of AI.

## 1. Control Flow and GOTO Mechanics

**Scope:** labels and the rule that a `GOTO` can jump out of a block but never into one.

In A1 and A2, an `IF` decided where to jump, and each label section did the work. Every branch had to end with `goto end_label`, because otherwise execution fell through into the next label and printed wrong results. In A3 I jumped into an `IF` on purpose, and Oracle refused to compile the block with `PLS-00375`. Because it is a compile-time error, nothing in that block ran. I fixed it two ways: by moving the label to the same level as the `GOTO`, and by jumping out of the `IF` instead of into it.

## 2. Functional Data Handling

**Scope:** `NULL` values and exceptions in the Part B functions.

In B1, `nvl(commission, 0)` stops a missing commission from making the whole result `NULL`. A `NULL` salary returns `NULL` and not 0, because "unknown" is different from "zero". In B4, I handled `no_data_found` for a department ID that does not exist. That catches one expected problem. I chose not to use a broad `WHEN OTHERS THEN RETURN NULL`, because it hides real errors and makes bugs hard to find.

## 3. Debugging and Edge Cases (The Hardest Part)

**Scope:** the mistakes that cost me the most time.

- A typo, `crate table`, stopped the `employees` table from being created, so every later script failed.
- I used a variable that did not exist (`input` instead of `input_number`).
- I got `ORA-06502` because a `varchar2` variable was too small for the text I assigned to it.
- Some output strings had no spaces, so the text ran together.

For C1, my seed data is all valid, so a normal test proves little. I inserted temporary bad rows (no salary, negative salary, commission above 1, future hire date), checked the results, and used `rollback` to remove them.

## 4. GOTO Versus Structured Code

**Scope:** comparing A1 and A2 with the A4 rewrite.

The `IF/ELSIF` and `CASE` versions in A4 were shorter and easier to read. They had no labels to follow and no risk of fall-through. I would use structured code in almost every case. `GOTO` can still be useful for leaving deeply nested loops or jumping to one cleanup point.

## 5. Business Logic and Decisions

**Scope:** rules the assignment did not specify, which I chose and listed in the README.

- `salary` is a monthly amount in RWF, and `fn_annual_salary` multiplies it by 12.
- In A2, "average" means within 10% of the average salary.
- B3 uses progressive Rwanda PAYE brackets: 0% up to 30,000, 20% up to 100,000, and 30% above. Only the part of the salary inside each band is taxed at that rate. I took these figures from online guides, not from an official source.
- C1 checks that the employee exists, salary is above 0, commission is between 0 and 1, the hire date is not in the future, and the department exists.

## 6. Process Improvements

**Scope:** what I would change next time.

I would run and test each file right after writing it, instead of letting mistakes pile up. I would also confirm unclear rules with the instructor early, especially whether salary is monthly or annual, because that choice affected B1, B3 and the expected results.

## 7. Use of AI and Verification

**Scope:** how I used an AI assistant (Gemini Notebook) and how I checked its work.

I used it to review my code, mostly find errors, explain some concepts, and suggest improvements. I did not accept the drafts blindly. I ran the code, compared the output with what I expected, and fixed the problems that appeared. Some AI suggestions did not fit my data, such as test values that did not exist in my tables, and I corrected those. I can explain every file in this repository.
