-- Tests for C1
SET LINESIZE 200 PAGESIZE 50
SET SERVEROUTPUT ON SIZE UNLIMITED
COLUMN verdict FORMAT A55

SELECT emp_id, fn_validate_payroll(emp_id) AS verdict
FROM   employees
ORDER  BY emp_id;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Emp 999: ' || fn_validate_payroll(999));
END;
/
