-- B2: Completed years of service (0 if hire date is in the future)
CREATE OR REPLACE FUNCTION fn_years_of_service (p_emp_id IN NUMBER)
RETURN NUMBER
IS
  v_hire_date employees.hire_date%TYPE;
BEGIN
  SELECT hire_date INTO v_hire_date FROM employees WHERE emp_id = p_emp_id;
  RETURN GREATEST(0, TRUNC(MONTHS_BETWEEN(SYSDATE, v_hire_date) / 12));
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Employee ' || p_emp_id || ' not found');
END fn_years_of_service;
/
SHOW ERRORS
