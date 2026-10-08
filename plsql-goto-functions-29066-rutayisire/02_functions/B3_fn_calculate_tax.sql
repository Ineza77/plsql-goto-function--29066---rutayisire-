-- B3: Progressive monthly tax (PAYE-style brackets, RWF)
--   0       -  60,000 : 0%
--   60,001  - 100,000 : 10%
--   100,001 - 200,000 : 20%
--   above     200,000 : 30%
-- (If your lecturer gave different brackets, change only the constants.)
CREATE OR REPLACE FUNCTION fn_calculate_tax (p_salary IN NUMBER)
RETURN NUMBER DETERMINISTIC
IS
  v_tax NUMBER := 0;
BEGIN
  IF p_salary IS NULL THEN
    RETURN NULL;
  ELSIF p_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Salary cannot be negative');
  END IF;

  IF p_salary > 200000 THEN
    v_tax := v_tax + (p_salary - 200000) * 0.30;
  END IF;
  IF p_salary > 100000 THEN
    v_tax := v_tax + (LEAST(p_salary, 200000) - 100000) * 0.20;
  END IF;
  IF p_salary > 60000 THEN
    v_tax := v_tax + (LEAST(p_salary, 100000) - 60000) * 0.10;
  END IF;

  RETURN ROUND(v_tax, 2);
END fn_calculate_tax;
/
SHOW ERRORS
