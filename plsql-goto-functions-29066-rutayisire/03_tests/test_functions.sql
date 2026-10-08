-- Tests for B1-B4
SET SERVEROUTPUT ON SIZE UNLIMITED

DECLARE
  PROCEDURE check_tax (p_salary NUMBER, p_expected NUMBER) IS
    v_actual NUMBER := fn_calculate_tax(p_salary);
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Tax(' || p_salary || ') = ' || v_actual ||
      ' expected ' || p_expected || ' -> ' ||
      CASE WHEN v_actual = p_expected THEN 'PASS' ELSE 'FAIL' END);
  END;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- B1 fn_annual_salary ---');
  DBMS_OUTPUT.PUT_LINE('Emp 101 annual = ' || fn_annual_salary(101) || ' (expected 10200000)');

  DBMS_OUTPUT.PUT_LINE('--- B2 fn_years_of_service ---');
  DBMS_OUTPUT.PUT_LINE('Emp 101 years  = ' || fn_years_of_service(101));
  DBMS_OUTPUT.PUT_LINE('Emp 108 years  = ' || fn_years_of_service(108) || ' (future hire -> 0)');

  DBMS_OUTPUT.PUT_LINE('--- B3 fn_calculate_tax ---');
  check_tax(0,       0);
  check_tax(50000,   0);
  check_tax(60000,   0);
  check_tax(80000,   2000);
  check_tax(100000,  4000);
  check_tax(150000,  14000);
  check_tax(250000,  39000);

  DBMS_OUTPUT.PUT_LINE('--- B4 fn_dept_name ---');
  DBMS_OUTPUT.PUT_LINE('Dept 10   = ' || fn_dept_name(10));
  DBMS_OUTPUT.PUT_LINE('Dept 999  = ' || fn_dept_name(999));
  DBMS_OUTPUT.PUT_LINE('Dept NULL = ' || fn_dept_name(NULL));

  DBMS_OUTPUT.PUT_LINE('--- Exception test ---');
  BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_annual_salary(999));
  EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Caught: ' || SQLERRM);
  END;
END;
/
