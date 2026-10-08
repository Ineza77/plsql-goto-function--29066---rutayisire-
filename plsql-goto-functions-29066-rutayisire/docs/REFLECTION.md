# Reflection (Task C2)

> Rewrite these answers in your own words after running the code. Add what you personally saw or struggled with.

## 1. What did you learn about GOTO?
GOTO jumps to a label (`<<label>>`) in the same or an enclosing block. It cannot jump into an IF, LOOP, CASE or nested block (error PLS-00375), as I saw in A3. A label must be followed by an executable statement, so I used `NULL;` where needed.

## 2. GOTO vs structured code
In A4 the same logic became shorter and easier to read using `IF/ELSIF`, `CASE` and `CONTINUE`. GOTO makes the flow jump around, which makes programs harder to read, debug and maintain. I would use it only rarely, such as for a single early exit to shared cleanup code, as in `fn_validate_payroll`.

## 3. Why use functions?
Functions package logic once (e.g. tax calculation) and let me reuse it in PL/SQL and directly in SQL (`SELECT`, `WHERE`, `ORDER BY`), as in B5. They always return one value, and they make code easier to test (`test_functions.sql`).

## 4. Exception handling
`NO_DATA_FOUND` is handled in each lookup function. `RAISE_APPLICATION_ERROR` gives a clear message (e.g. ORA-20001 for an unknown employee), while `fn_dept_name` returns `'Unknown'` instead so one bad row does not break a whole query.

## 5. Difficulties and how I solved them
<Write 2–3 sentences about real problems you hit (compile errors, SERVEROUTPUT, label rules, etc.).>

## 6. Quiz preparation
- Syntax of a label and GOTO; where GOTO is illegal
- Function syntax: `CREATE OR REPLACE FUNCTION ... RETURN ... IS ... BEGIN ... RETURN ...; EXCEPTION ... END;`
- Functions vs procedures; calling functions from SQL
- `NO_DATA_FOUND`, `RAISE_APPLICATION_ERROR`
