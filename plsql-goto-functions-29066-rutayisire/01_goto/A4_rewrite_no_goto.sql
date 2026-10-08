-- A4: A1 and A2 rewritten WITHOUT GOTO (structured IF / CASE / CONTINUE)
SET SERVEROUTPUT ON SIZE UNLIMITED

PROMPT === A1 without GOTO ===
DECLARE
  v_list SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(15, -4, 0, 7, 22);
  v_num  NUMBER;
  v_sign VARCHAR2(10);
BEGIN
  FOR i IN 1 .. v_list.COUNT LOOP
    v_num  := v_list(i);
    v_sign := CASE WHEN v_num > 0 THEN 'positive'
                   WHEN v_num < 0 THEN 'negative'
                   ELSE 'zero' END;
    DBMS_OUTPUT.PUT_LINE('--- Number: ' || v_num);
    DBMS_OUTPUT.PUT_LINE('Sign   : ' || v_sign);
    DBMS_OUTPUT.PUT_LINE('Parity : ' || CASE WHEN MOD(v_num,2) = 0 THEN 'even' ELSE 'odd' END);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Classification complete.');
END;
/

PROMPT === A2 without GOTO ===
DECLARE
  c_low_limit  CONSTANT NUMBER := 300000;
  c_high_limit CONSTANT NUMBER := 800000;
  v_new_salary NUMBER;
  v_low NUMBER := 0;  v_normal NUMBER := 0;  v_high NUMBER := 0;  v_skipped NUMBER := 0;
BEGIN
  FOR r IN (SELECT emp_id, first_name || ' ' || last_name AS full_name, salary
            FROM employees ORDER BY emp_id) LOOP

    IF r.salary IS NULL OR r.salary <= 0 THEN
      v_skipped := v_skipped + 1;
      DBMS_OUTPUT.PUT_LINE(r.emp_id || ' ' || RPAD(r.full_name,18) || ' SKIPPED (invalid salary)');
      CONTINUE;                                   -- replaces GOTO next_employee
    END IF;

    IF r.salary < c_low_limit THEN
      v_new_salary := r.salary * 1.10;  v_low := v_low + 1;
      DBMS_OUTPUT.PUT_LINE(r.emp_id || ' ' || RPAD(r.full_name,18) || ' LOW    -> +10% : '
        || TO_CHAR(r.salary,'FM999,999,999') || ' => ' || TO_CHAR(v_new_salary,'FM999,999,999'));
    ELSIF r.salary >= c_high_limit THEN
      v_high := v_high + 1;
      DBMS_OUTPUT.PUT_LINE(r.emp_id || ' ' || RPAD(r.full_name,18) || ' HIGH   -> no raise: '
        || TO_CHAR(r.salary,'FM999,999,999'));
    ELSE
      v_new_salary := r.salary * 1.05;  v_normal := v_normal + 1;
      DBMS_OUTPUT.PUT_LINE(r.emp_id || ' ' || RPAD(r.full_name,18) || ' NORMAL -> +5%  : '
        || TO_CHAR(r.salary,'FM999,999,999') || ' => ' || TO_CHAR(v_new_salary,'FM999,999,999'));
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Summary -> low: ' || v_low || ', normal: ' || v_normal ||
                       ', high: ' || v_high || ', skipped: ' || v_skipped);
END;
/
