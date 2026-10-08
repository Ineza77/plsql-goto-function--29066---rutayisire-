-- B1: Annual salary = monthly salary x 12
CREATE OR REPLACE FUNCTION fn_annual_salary (p_emp_id IN NUMBER)
RETURN NUMBER
IS
  v_salary employees.salary%TYPE;
BEGIN
  SELECT salary INTO v_salary FROM employees WHERE emp_id = p_emp_id;
  RETURN NVL(v_salary, 0) * 12;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Employee ' || p_emp_id || ' not found');
END fn_annual_salary;
/
SHOW ERRORS
