-- A1: Number Classifier using GOTO
-- Classifies each number as positive/negative/zero and even/odd.
SET SERVEROUTPUT ON SIZE UNLIMITED

DECLARE
  v_list SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(15, -4, 0, 7, 22);
  v_num  NUMBER;
BEGIN
  FOR i IN 1 .. v_list.COUNT LOOP
    v_num := v_list(i);
    DBMS_OUTPUT.PUT_LINE('--- Number: ' || v_num);

    IF v_num > 0 THEN
      GOTO is_positive;
    ELSIF v_num < 0 THEN
      GOTO is_negative;
    ELSE
      GOTO is_zero;
    END IF;

    <<is_positive>>
    DBMS_OUTPUT.PUT_LINE('Sign   : positive');
    GOTO check_parity;

    <<is_negative>>
    DBMS_OUTPUT.PUT_LINE('Sign   : negative');
    GOTO check_parity;

    <<is_zero>>
    DBMS_OUTPUT.PUT_LINE('Sign   : zero');

    <<check_parity>>
    IF MOD(v_num, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Parity : even');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Parity : odd');
    END IF;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Classification complete.');
END;
/
