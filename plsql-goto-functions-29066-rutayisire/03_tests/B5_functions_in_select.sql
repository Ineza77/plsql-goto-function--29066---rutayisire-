-- B5: Using the functions inside SQL (SELECT, WHERE, ORDER BY)
SET LINESIZE 220 PAGESIZE 50
COLUMN full_name FORMAT A18
COLUMN department FORMAT A16

PROMPT === 1. Functions in the SELECT list ===
SELECT e.emp_id,
       e.first_name || ' ' || e.last_name AS full_name,
       fn_dept_name(e.dept_id)            AS department,
       e.salary                           AS monthly_salary,
       fn_annual_salary(e.emp_id)         AS annual_salary,
       fn_years_of_service(e.emp_id)      AS years_service,
       fn_calculate_tax(e.salary)         AS monthly_tax
FROM   employees e
ORDER  BY e.emp_id;

PROMPT === 2. Function in WHERE: 5+ years of service ===
SELECT emp_id, first_name, fn_years_of_service(emp_id) AS years_service
FROM   employees
WHERE  fn_years_of_service(emp_id) >= 5
ORDER  BY years_service DESC;

PROMPT === 3. Function in ORDER BY: highest tax first ===
SELECT emp_id, first_name, salary, fn_calculate_tax(salary) AS monthly_tax
FROM   employees
ORDER  BY fn_calculate_tax(salary) DESC, emp_id;
