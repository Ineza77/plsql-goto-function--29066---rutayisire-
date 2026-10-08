# PL/SQL GOTO Statements and Functions — Individual Assignment III

**Course:** Database Development with PL/SQL (INSY 8311)
**Student:** <Ineza_RUTAYISIRE_Merveille> | **ID:** <29066> | **Group:** <B>

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
