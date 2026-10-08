-- C1: Payroll validator (combines GOTO + functions + exception handling)
-- Returns 'VALID' or 'INVALID: <reason>'.
-- Run AFTER B1-B4 (it calls fn_calculate_tax).
CREATE OR REPLACE FUNCTION fn_validate_payroll (p_emp_id IN NUMBER)
RETURN VARCHAR2
IS
  v_salary employees.salary%TYPE;
  v_hire   employees.hire_date%TYPE;
  v_dept   employees.dept_id%TYPE;
  v_tax    NUMBER;
  v_msg    VARCHAR2(200);
BEGIN
  SELECT salary, hire_date, dept_id
    INTO v_salary, v_hire, v_dept
    FROM employees
   WHERE emp_id = p_emp_id;

  IF v_salary IS NULL OR v_salary <= 0 THEN
    v_msg := 'Salary is missing or not positive';
    GOTO invalid_payroll;
  END IF;

  IF v_hire > SYSDATE THEN
    v_msg := 'Hire date is in the future';
    GOTO invalid_payroll;
  END IF;

  IF v_dept IS NULL THEN
    v_msg := 'Employee has no department';
    GOTO invalid_payroll;
  END IF;

  v_tax := fn_calculate_tax(v_salary);
  IF v_tax >= v_salary THEN
    v_msg := 'Tax is not less than salary';
    GOTO invalid_payroll;
  END IF;

  RETURN 'VALID';

  <<invalid_payroll>>
  RETURN 'INVALID: ' || v_msg;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'INVALID: Employee ' || p_emp_id || ' not found';
  WHEN OTHERS THEN
    RETURN 'ERROR: ' || SQLERRM;
END fn_validate_payroll;
/
SHOW ERRORS
