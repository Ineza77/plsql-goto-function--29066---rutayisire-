# PL/SQL GOTO Statements and Functions — Individual Assignment III

**Course:** Database Development with PL/SQL (INSY 8311)
**Student:** <Ineza_Rutayisire_Merveille> | **ID:** <29066> | **Group B:**<B>

## Overview
Practical work on PL/SQL `GOTO`, stored functions, exception handling, and using functions inside SQL.

## Contents
| Folder | Files | Purpose |
|---|---|---|
| `00_setup` | `create_tables.sql` | `DEPARTMENTS` + `EMPLOYEES` tables and sample data |
| `01_goto` | A1–A4 | Number classifier, salary review, illegal GOTO + fix, rewrite without GOTO |
| `02_functions` | B1–B4, C1 | `fn_annual_salary`, `fn_years_of_service`, `fn_calculate_tax`, `fn_dept_name`, `fn_validate_payroll` |
| `03_tests` | B5, test files | Functions in SELECT, unit tests, payroll validator tests |
| `screenshots` | PNGs | Evidence of each output |
| `docs` | `REFLECTION.md` | Reflection (Task C2) |

## How to Run (Oracle SQL*Plus / SQL Developer)
1. `@00_setup/create_tables.sql`
2. `@02_functions/B1_fn_annual_salary.sql`, `B2`, `B3`, `B4`, then `C1_fn_validate_payroll.sql`
3. `@01_goto/A1_number_classifier.sql`, `A2`, `A3`, `A4`
4. `@03_tests/test_functions.sql`, `@03_tests/B5_functions_in_select.sql`, `@03_tests/test_validate_payroll.sql`
5. Compare results with the screenshots.

## Assumptions
- `salary` is a **monthly** salary in RWF.
- Tax uses progressive brackets: 0% to 60,000; 10% to 100,000; 20% to 200,000; 30% above.
- Salary review: below 300,000 → +10%; 800,000 and above → no raise; otherwise +5%.

## Sample data edge cases
Employee 106 has no department, 107 has salary 0, 108 has a future hire date — these exercise the validator.

## Notes
AI disclosure: <I used an AI assistant (Claude) to generate a first draft of the SQL and the repository structure. I then ran every script myself in Oracle, checked the output, and can explain each program. Edit this to describe exactly what you did.>

## Screenshots and Explanations

All screenshots were taken in Oracle SQL Developer.

### Setup

**1. Table creation** — Creates the `DEPARTMENTS` and `EMPLOYEES` tables. `EMPLOYEES.dept_id` is a foreign key to `DEPARTMENTS`. Oracle confirms both tables were created.

![Table creation](screenshots/00_table_creation.png)

**2. Data insertion** — Inserts 4 departments and 8 employees, then runs `COMMIT` to save them.

![Data insertion](screenshots/00_data_insertion.png)

**3. Verifying the data** — `SELECT` shows all 8 employees ("All Rows Fetched: 8"). Employee 106 has no department (null), 107 has salary 0 and 108 has a future hire date. These are deliberate test cases.

![Data verification](screenshots/00_data_verification.png)

### Part A: GOTO

**A1: Number Classifier** — Checks whether each number is positive, negative or zero and uses `GOTO` to jump to the matching label (`is_positive`, `is_negative`, `is_zero`). It then jumps to `check_parity` to decide even or odd. The block ran successfully.

![A1 output](screenshots/A1_output.png)

**A2: Salary Review** — For each employee, `GOTO` sends the program to `low_salary`, `normal_salary`, `high_salary` or `skip_employee`. Each branch ends with `GOTO next_employee`, which moves on to the next employee. The block ran successfully.

![A2 output](screenshots/A2_output.png)

**A3: Illegal GOTO and fix** — `GOTO` cannot jump *into* an IF block (this causes error PLS-00375). The fix is to jump *out of* the IF to a label in the enclosing block (`<<show_message>>`). The fixed version runs successfully.

![A3 error and fix](screenshots/A3_error_and_fix.png)

**A4: Rewrite without GOTO** — The same logic is written with `CASE`, `IF/ELSIF` and `CONTINUE`. The output ends with `Summary -> low: 3, normal: 3, high: 1, skipped: 1`, the same result as the GOTO version, and the code is easier to read.

![A4 output](screenshots/A4_output.png)

### Part B: Functions

**B1: `fn_annual_salary`** — Returns the monthly salary multiplied by 12. If the employee does not exist, it raises error -20001 ("Employee not found"). Oracle shows "Function FN_ANNUAL_SALARY compiled".

![B1 compiled](screenshots/B1_compiled.png)

**B2: `fn_years_of_service`** — Returns the number of completed years since the hire date, using `MONTHS_BETWEEN`. `GREATEST(0, ...)` makes sure a future hire date gives 0 instead of a negative number.

![B2 compiled](screenshots/B2_compiled.png)

**B3: `fn_calculate_tax`** — Calculates tax in brackets: 0% up to 60,000, 10% up to 100,000, 20% up to 200,000 and 30% above that. It returns NULL for a NULL salary and raises an error for a negative salary.

![B3 compiled](screenshots/B3_compiled.png)

**B4: `fn_dept_name`** — Looks up a department name from its ID. It returns 'Unassigned' if the ID is NULL and 'Unknown' if the department does not exist (`NO_DATA_FOUND`).

![B4 compiled](screenshots/B4_compiled.png)

**Function tests (`test_functions.sql`)** — A test block that checks each function: annual salary of employee 101, years of service, tax at 0, 50,000, 60,000, 80,000, 100,000, 150,000 and 250,000, department lookups, and an exception test for an unknown employee.

![Test functions](screenshots/test_functions_output.png)

**B5: Functions in SQL** — The functions are used directly inside SQL. This result is sorted by `fn_calculate_tax(salary)` from highest to lowest: for example, salary 850,000 gives tax 219,000 and salary 620,000 gives 150,000.

![B5 select output](screenshots/B5_select_output.png)

### Part C: Combined Task

**C1: `fn_validate_payroll` (compiled)** — Combines `GOTO`, the tax function and exception handling. Each failed check sets a message and jumps to the `invalid_payroll` label. Oracle shows "Function FN_VALIDATE_PAYROLL compiled".

![C1 compiled](screenshots/C1_compiled.png)

**C1: Payroll validator results** — Employees 101 to 105 are `VALID`. Employee 106 is `INVALID: Employee has no department`, 107 is `INVALID: Salary is missing or not positive` and 108 is `INVALID: Hire date is in the future`.

![C1 output](screenshots/C1_output.png)
