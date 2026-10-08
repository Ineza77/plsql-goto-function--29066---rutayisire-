-- 00_setup/create_tables.sql
-- Creates DEPARTMENTS and EMPLOYEES with sample data (re-runnable).

BEGIN EXECUTE IMMEDIATE 'DROP TABLE employees PURGE';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE departments PURGE';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

CREATE TABLE departments (
  dept_id    NUMBER(4)     PRIMARY KEY,
  dept_name  VARCHAR2(50)  NOT NULL
);

CREATE TABLE employees (
  emp_id     NUMBER(6)      PRIMARY KEY,
  first_name VARCHAR2(30)   NOT NULL,
  last_name  VARCHAR2(30)   NOT NULL,
  salary     NUMBER(12,2),                 -- MONTHLY salary (RWF)
  hire_date  DATE           NOT NULL,
  dept_id    NUMBER(4)      REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES (10, 'Finance');
INSERT INTO departments VALUES (20, 'IT');
INSERT INTO departments VALUES (30, 'Human Resources');
INSERT INTO departments VALUES (40, 'Marketing');

INSERT INTO employees VALUES (101,'Alice',   'Uwase',     850000, DATE '2015-03-01', 10);
INSERT INTO employees VALUES (102,'Eric',    'Mugisha',   450000, DATE '2019-07-15', 20);
INSERT INTO employees VALUES (103,'Grace',   'Ingabire',  280000, DATE '2022-01-10', 30);
INSERT INTO employees VALUES (104,'Jean',    'Habimana',  150000, DATE '2024-05-20', 20);
INSERT INTO employees VALUES (105,'Diane',   'Mukamana',   55000, DATE '2025-02-01', 40);
INSERT INTO employees VALUES (106,'Patrick', 'Nshuti',    620000, DATE '2018-09-12', NULL); -- no dept
INSERT INTO employees VALUES (107,'Claire',  'Umutoni',        0, DATE '2023-04-03', 30);   -- bad salary
INSERT INTO employees VALUES (108,'Samuel',  'Kalisa',    300000, DATE '2027-01-15', 10);   -- future hire date
COMMIT;

SELECT * FROM departments ORDER BY dept_id;
SELECT * FROM employees   ORDER BY emp_id;
