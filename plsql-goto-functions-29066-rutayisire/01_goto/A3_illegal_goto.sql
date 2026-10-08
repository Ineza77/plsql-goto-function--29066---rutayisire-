-- A3: Illegal GOTO and Fix
-- RULE: GOTO cannot jump INTO an IF, LOOP, CASE or nested block,
--       cannot jump into/out of a subprogram, and cannot go from an
--       exception handler back into its own block.
-- It CAN jump to a label in the same block or in an enclosing block.
SET SERVEROUTPUT ON SIZE UNLIMITED

PROMPT === PART 1: ILLEGAL GOTO (expected: PLS-00375, block does not compile) ===
DECLARE
  v_x NUMBER := 5;
BEGIN
  GOTO inside_if;              -- ILLEGAL: label is inside the IF block
  IF v_x > 0 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Inside the IF');
  END IF;
END;
/

PROMPT === PART 2: FIXED VERSION (jump OUT of the IF to a label in the enclosing block) ===
DECLARE
  v_x NUMBER := 5;
BEGIN
  IF v_x > 0 THEN
    GOTO show_message;         -- LEGAL: label is in the enclosing block
  END IF;
  DBMS_OUTPUT.PUT_LINE('Skipped when v_x > 0');

  <<show_message>>
  DBMS_OUTPUT.PUT_LINE('Reached the label legally. v_x = ' || v_x);
END;
/
