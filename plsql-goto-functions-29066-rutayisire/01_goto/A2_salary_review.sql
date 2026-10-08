-- A2: Salary Review using GOTO
-- Low (< 300,000): +10% | Normal: +5% | High (>= 800,000): no raise
-- Missing / zero salaries are skipped.
SET SERVEROUTPUT ON SIZE UNLIMITED

DECLARE
  c_low_limit  CONSTANT NUMBER := 300000;
  c_high_limit CONSTANT NUMBER := 800000;
  v_new_salary NUMBER;
  v_low NUMBER := 0;  v_normal NUMBER := 0;  v_high NUMBER := 0;  v_skipped NUMBER := 0;
BEGIN
  FOR r IN (SELECT emp_id, first_name || ' ' || last_name AS full_name, salary
            FROM employees ORDER BY emp_id) LOOP

    IF r.salary IS NULL OR r.salary <= 0 THEN
      GOTO skip_employee;
    ELSIF r.salary < c_low_limit THEN
      GOTO low_salary;
    ELSIF r.salary >= c_high_limit THEN
      GOTO high_salary;
    ELSE
      GOTO normal_salary;
    END IF;

    <<low_salary>>
    v_new_salary := r.salary * 1.10;
    v_low := v_low + 1;
    DBMS_OUTPUT.PUT_LINE(r.emp_id || ' ' || RPAD(r.full_name,18) || ' LOW    -> +10% : '
      || TO_CHAR(r.salary,'FM999,999,999') || ' => ' || TO_CHAR(v_new_salary,'FM999,999,999'));
    GOTO next_employee;

    <<normal_salary>>
    v_new_salary := r.salary * 1.05;
    v_normal := v_normal + 1;
    DBMS_OUTPUT.PUT_LINE(r.emp_id || ' ' || RPAD(r.full_name,18) || ' NORMAL -> +5%  : '
      || TO_CHAR(r.salary,'FM999,999,999') || ' => ' || TO_CHAR(v_new_salary,'FM999,999,999'));
    GOTO next_employee;

    <<high_salary>>
    v_high := v_high + 1;
    DBMS_OUTPUT.PUT_LINE(r.emp_id || ' ' || RPAD(r.full_name,18) || ' HIGH   -> no raise: '
      || TO_CHAR(r.salary,'FM999,999,999'));
    GOTO next_employee;

    <<skip_employee>>
    v_skipped := v_skipped + 1;
    DBMS_OUTPUT.PUT_LINE(r.emp_id || ' ' || RPAD(r.full_name,18) || ' SKIPPED (invalid salary)');

    <<next_employee>>
    NULL;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Summary -> low: ' || v_low || ', normal: ' || v_normal ||
                       ', high: ' || v_high || ', skipped: ' || v_skipped);
END;
/
