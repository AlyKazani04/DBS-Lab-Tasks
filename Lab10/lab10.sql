SET SERVEROUTPUT ON;

-- 1
DECLARE 
    E_ID NUMBER:= 101;
    E_FNAME EMPLOYEES.FIRST_NAME%TYPE;
    E_LNAME EMPLOYEES.LAST_NAME%TYPE;
    E_SAL EMPLOYEES.SALARY%TYPE;
    D_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
    D_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT E.FIRST_NAME, E.LAST_NAME, E.SALARY, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
    INTO E_FNAME, E_LNAME, E_SAL, D_ID, D_NAME
    FROM EMPLOYEES E 
    JOIN DEPARTMENTS D 
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE E.EMPLOYEE_ID = E_ID;
    
    DBMS_OUTPUT.PUT_LINE('ID: ' || E_ID);
    DBMS_OUTPUT.PUT_LINE('NAME: ' || E_FNAME || ' ' || E_LNAME);
    DBMS_OUTPUT.PUT_LINE('SALARY: ' || E_SAL);
    DBMS_OUTPUT.PUT_LINE('DEPARTMENT ID: ' || D_ID);
    DBMS_OUTPUT.PUT_LINE('DEPARTMENT: ' || D_NAME);
END;
/

-- 2
BEGIN 
    FOR C IN (
        SELECT FIRST_NAME, LAST_NAME, JOB_ID, SALARY
        FROM EMPLOYEES)
    LOOP
        DBMS_OUTPUT.PUT(C.FIRST_NAME || ' ' || C.LAST_NAME || ': ');
        IF C.JOB_ID LIKE '%PROG%' OR C.JOB_ID LIKE '%ENG%' THEN
            IF C.SALARY > 5000 THEN
                DBMS_OUTPUT.PUT_LINE('Eligible for Technical Recognition');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Salary below threshold.');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Standard Classification');
        END IF;
    END LOOP;
END;
/

-- 3
BEGIN 
    FOR C IN (
        SELECT FIRST_NAME, LAST_NAME, SALARY, JOB_ID
        FROM EMPLOYEES) 
        LOOP
            DECLARE
                SAL_LVL VARCHAR2(10) :=
                    CASE
                        WHEN C.SALARY > 10000 THEN 'High'
                        ELSE 'Standard'
                    END;
                PERFORM VARCHAR2(50) :=
                    CASE
                        WHEN C.JOB_ID LIKE '%MAN%' THEN 'Strategic'
                        ELSE 'Operational'
                    END;
            BEGIN
                DBMS_OUTPUT.PUT_LINE(C.FIRST_NAME || ' ' || C.LAST_NAME ||
                ' | Level: ' || SAL_LVL || ' | Label: ' || PERFORM);
            END;
        END LOOP;
END;
/

-- 4
BEGIN
    FOR C IN (
        SELECT LAST_NAME, SALARY, NVL(COMMISSION_PCT, 0) AS COMM
        FROM EMPLOYEES)
        LOOP
            DBMS_OUTPUT.PUT(C.LAST_NAME || ' Status: ');
            IF (C.SALARY * C.COMM) > 1000 OR C.SALARY > 12000 THEN
                DBMS_OUTPUT.PUT_LINE('High Perfomer');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Standard Performer');
            END IF;
        END LOOP;
END;
/

-- 5
BEGIN 
    FOR C IN (
        SELECT NVL(DEPARTMENT_ID, 0) AS DEPARTMENT_ID, SUM(SALARY) AS TOTAL_SAL, AVG(SALARY) AS AVG_SAL
        FROM EMPLOYEES GROUP BY DEPARTMENT_ID)
    LOOP
        DBMS_OUTPUT.PUT('Dept ' || C.DEPARTMENT_ID || ': ');
        IF C.TOTAL_SAL > 50000 THEN
            DBMS_OUTPUT.PUT_LINE('Over Budget (Total: ' || C.TOTAL_SAL || ')');
        ELSE
            DBMS_OUTPUT.PUT_lINE('Normal Budget: (Avg: ' || ROUND(C.AVG_SAL,2) || ')');
        END IF;
    END LOOP;
END;
/

-- 6
DECLARE
    TARGET_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE := 100;
BEGIN
    FOR C IN (
        SELECT * FROM EMPLOYEES 
        WHERE DEPARTMENT_ID = TARGET_DEPT)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Report: ' || C.LAST_NAME);
        DBMS_OUTPUT.PUT_LINE('Job Class: ' || SUBSTR(C.JOB_ID, 1, 2));
        DBMS_OUTPUT.PUT_LINE('Eligibility: ' || 
            CASE
                WHEN C.SALARY > 7000 THEN 'Qualified'
                ELSE 'Pending'
            END);
        DBMS_OUTPUT.PUT_LINE('Promotion: ' ||
            CASE
                WHEN C.COMMISSION_PCT IS NOT NULL THEN 'Consider'
                ELSE 'N/A'
            END);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;
/

-- 7
BEGIN 
    FOR C IN (
        SELECT LAST_NAME, SALARY, HIRE_DATE, JOB_ID 
        FROM EMPLOYEES)
        LOOP
            DBMS_OUTPUT.PUT_LINE(C.LAST_NAME ||
            ' | Grade: ' || 
            CASE 
                WHEN C.SALARY > 10000 THEN 'A'
                ELSE 'B' 
            END ||
            ' | Exp: ' ||
            CASE
                WHEN C.HIRE_DATE < TO_DATE('2015', 'YYYY') THEN 'Senior'
                ELSE 'Junior'
            END);
        END LOOP;
END;
/

-- 8
BEGIN
    FOR C IN(
    SELECT LAST_NAME, DEPARTMENT_ID, SALARY, COMMISSION_PCT 
    FROM EMPLOYEES)
    LOOP
        IF (C.DEPARTMENT_ID = 80 AND C.COMMISSION_PCT > 0) 
            OR C.SALARY < 5000 THEN
            DBMS_OUTPUT.PUT_LINE(C.LAST_NAME || ': Eligible for Bonus');
        ELSE
            DBMS_OUTPUT.PUT_LINE(C.LAST_NAME || ': No Bonus');
        END IF;
    END LOOP;
END;
/

-- 9
DECLARE
    AVG_SAL NUMBER;
BEGIN
    SELECT AVG(SALARY) INTO AVG_SAL FROM EMPLOYEES;
    
    FOR C IN (
        SELECT LAST_NAME, SALARY, DEPARTMENT_ID 
        FROM EMPLOYEES
        WHERE SALARY < AVG_SAL)
        LOOP
            DBMS_OUTPUT.PUT_LINE('Priority Update: ' || C.LAST_NAME ||
                ' | Dept: ' || C.DEPARTMENT_ID);
        END LOOP;
END;
/

-- 10
BEGIN
    FOR C IN (
        SELECT LAST_NAME, SALARY, JOB_ID, DEPARTMENT_ID
        FROM EMPLOYEES)
        LOOP
            DECLARE 
                TIER NUMBER := 
                    CASE
                        WHEN C.SALARY > 12000 THEN 1
                        WHEN C.SALARY > 6000 THEN 2
                        ELSE 3
                    END;
            BEGIN
                DBMS_OUTPUT.PUT_LINE('Ranking: ' ||
                C.LAST_NAME ||
                ' | Tier: ' || TIER ||
                ' | Job Group: ' || SUBSTR(C.JOB_ID,1, 2));
            END;
        END LOOP;
END;
/

-- 11
BEGIN 
    FOR C IN (
    SELECT DEPARTMENT_ID, DEPARTMENT_NAME
    FROM DEPARTMENTS ORDER BY DEPARTMENT_NAME)
    LOOP
        DBMS_OUTPUT.PUT_LINE('DEPT: ' || C.DEPARTMENT_NAME);
        FOR E IN (
        SELECT LAST_NAME, SALARY, JOB_ID
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = C.DEPARTMENT_ID)
        LOOP
            DBMS_OUTPUT.PUT_LINE(
            '  ' || E.LAST_NAME ||
            ' | Sal: ' || E.SALARY ||
            ' | Role: ' || E.JOB_ID);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('-=-=-=-=-=-=-=-=-=-=-=-=-=-');
    END LOOP;
END;
/

-- 12
DECLARE 
    E_ID EMPLOYEES.EMPLOYEE_ID%TYPE := 101;
    E_REC EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO E_REC FROM EMPLOYEES
    WHERE EMPLOYEE_ID = E_ID;
    DBMS_OUTPUT.PUT_LINE('Grade: ' ||
    CASE 
        WHEN E_REC.SALARY > 10000 THEN 'Gold'
        ELSE 'Silver'
    END);
    DBMS_OUTPUT.PUT_LINE('Promotion: ' ||
    CASE
        WHEN E_REC.COMMISSION_PCT > 0 THEN 'Eligible'
        ELSE 'Review Needed'
    END);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Invalid ID: ' || E_ID);
END;
/

-- 13
BEGIN 
    FOR C IN (
        SELECT LAST_NAME, DEPARTMENT_ID, SALARY, HIRE_DATE
        FROM EMPLOYEES)
        LOOP
            DECLARE
                NEW_SAL NUMBER := C.SALARY;
            BEGIN
                IF C.DEPARTMENT_ID = 90 THEN
                    NEW_SAL := C.SALARY * 1.10; 
                END IF;
                DBMS_OUTPUT.PUT_LINE(
                C.LAST_NAME ||
                ' | Old: ' || C.SALARY ||
                ' | New: ' || NEW_SAL);
            END;
        END LOOP;
END;
/

-- 14
BEGIN
    FOR C IN (
    SELECT LAST_NAME, JOB_ID, HIRE_DATE FROM EMPLOYEES)
    LOOP
        DECLARE 
            YEARS NUMBER := MONTHS_BETWEEN(SYSDATE, C.HIRE_DATE)/12;
            CAT VARCHAR2(20);
        BEGIN
            CAT := 
            CASE
                WHEN YEARS > 10 THEN 'Senior'
                WHEN YEARS > 5 THEN 'Mid'
                ELSE 'Junior'
            END;
            DBMS_OUTPUT.PUT_LINE(
            C.LAST_NAME || ' (' || C.JOB_ID || 
            ') Experience: ' || CAT);
        END;
    END LOOP;
END;
/

-- 15
BEGIN
    FOR C IN (
    SELECT E.*, D.DEPARTMENT_NAME 
    FROM EMPLOYEES E 
    LEFT JOIN DEPARTMENTS D 
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        'EMP: ' || C.LAST_NAME ||
        ' | DEPT: ' || NVL(C.DEPARTMENT_NAME, 'NONE') || 
        ' | GRADE: ' || 
            CASE 
                WHEN C.SALARY > 8000 THEN 'High'
                ELSE 'Low'
            END ||
        ' | BONUS: ' ||
            CASE
                WHEN C.COMMISSION_PCT > 0 THEN 'YES'
                ELSE 'NO'
            END);
    END LOOP;
END;
/

-- 16
CREATE OR REPLACE PROCEDURE GET_EMP_DETAILS(P_ID IN NUMBER)
AS
    REC EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO REC FROM EMPLOYEES
    WHERE EMPLOYEE_ID = P_ID;
    DBMS_OUTPUT.PUT_LINE(
    'Name: ' || REC.FIRST_NAME || 
    ' Job: ' || REC.JOB_ID ||
    ' Salary: ' || REC.SALARY);
END;
/
EXEC GET_EMP_DETAILS(105);

-- 17
CREATE OR REPLACE PROCEDURE RAISE_SALARY(
    P_ID IN NUMBER, P_PERCENT IN NUMBER) AS
    E_NAME EMPLOYEES.LAST_NAME%TYPE;
    NEW_SAL NUMBER;
BEGIN
    UPDATE EMPLOYEES SET SALARY = SALARY * (1 * P_PERCENT / 100)
    WHERE EMPLOYEE_ID = P_ID 
        RETURNING LAST_NAME, SALARY INTO E_NAME, NEW_SAL;
    DBMS_OUTPUT.PUT_LINE(
    E_NAME || ' Updated Salary: ' || NEW_SAL);
END;
/
EXEC RAISE_SALARY(150, 12);

-- 18
CREATE OR REPLACE PROCEDURE LIST_DEPT_EMPS(
    P_DEPT_ID IN NUMBER) AS
BEGIN
    FOR C IN (
    SELECT LAST_NAME, JOB_ID, SALARY 
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = P_DEPT_ID)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        C.LAST_NAME || 
        ' | ' || C.JOB_ID || 
        ' | ' || C.SALARY);
    END LOOP;
END;
/
EXEC LIST_DEPT_EMPS(50);

-- 19
CREATE OR REPLACE PROCEDURE DEPT_STATS (
    P_DEPT_ID IN NUMBER) AS
    V_COUNT NUMBER;
    V_SUM NUMBER;
    V_AVG NUMBER;
BEGIN
    SELECT COUNT(*), SUM(SALARY), AVG(SALARY) 
        INTO V_COUNT, V_SUM, V_AVG
    FROM EMPLOYEES 
    WHERE DEPARTMENT_ID = P_DEPT_ID;
    
    DBMS_OUTPUT.PUT_LINE(
    'Total Employees: ' || V_COUNT ||
    ' | Total Paid: ' || V_SUM ||
    ' | Average Pay: ' || ROUND(V_AVG, 2));
END;
/
EXEC DEPT_STATS(50);

-- 20
CREATE OR REPLACE PROCEDURE LIST_BY_JOB(
    P_JOB_ID IN VARCHAR2) AS
BEGIN
    FOR C IN (
    SELECT E.LAST_NAME, D.DEPARTMENT_NAME, E.SALARY
    FROM EMPLOYEES E
    JOIN DEPARTMENTS D 
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE E.JOB_ID = P_JOB_ID)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        C.LAST_NAME || ' in ' ||
        C.DEPARTMENT_NAME || ': $' ||
        C.SALARY);
    END LOOP;
END;
/
EXEC LIST_BY_JOB('SA_REP');