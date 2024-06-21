--���

/*
IF ������ THEN
ELSIF ������ THEN
ELSE ~~~
END IF;
*/
SET SERVEROUTPUT ON;

DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.value(1, 101)); --
BEGIN
    
    DBMS_OUTPUT.put_line('���� : ' || POINT);
    /*
    IF POINT >= 90 THEN
        DBMS_OUTPUT.put_line('A���� �Դϴ�');
    ELSIF POINT >= 80 THEN
        DBMS_OUTPUT.put_line('B���� �Դϴ�');
    ELSIF POINT >= 70 THEN
        DBMS_OUTPUT.put_line('C���� �Դϴ�');
    ELSE
        DBMS_OUTPUT.put_line('F���� �Դϴ�');
    END IF;
    */
    
    CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.put_line('A���� �Դϴ�');
         WHEN POINT >= 80 THEN DBMS_OUTPUT.put_line('B���� �Դϴ�');
         WHEN POINT >= 70 THEN DBMS_OUTPUT.put_line('C���� �Դϴ�');
         ELSE DBMS_OUTPUT.put_line('F���� �Դϴ�');
    END CASE;
    
END;


--------------------------------------------------------------

--�ݺ���

--WHILE��
DECLARE
    CNT NUMBER := 1;
BEGIN

    WHILE CNT <= 9
    LOOP
        dbms_output.put_line('3 X ' || CNT || ' = ' || CNT * 3);
        
        CNT := CNT +1; -- 1 ����
        
    END LOOP;
    
END;

------------------------------------------------------------------

--FOR��
DECLARE
    
BEGIN

    FOR I IN 1..9 -- 1~9����
    LOOP
        CONTINUE WHEN I = 5; -- I�� 5�� ��������
        DBMS_OUTPUT.put_line('3 X ' || I || ' = ' || I * 3);
        EXIT WHEN I = 5; -- I�� 5�� Ż��
    END LOOP;
    
END;

----------------------------------------------------------------

--1. 2~9�ܱ��� ����ϴ� �͸��� 

DECLARE
    NUM NUMBER := 2;
BEGIN
    WHILE NUM <= 9
    LOOP
        FOR I IN 1..9
        LOOP
         dbms_output.put_line(NUM || ' X ' || I || ' = ' || NUM * I);
        END LOOP;
        NUM := NUM + 1;
    END LOOP;
END;

----------------------------------------------------------

--Ŀ��

DECLARE
    NAME VARCHAR2(30);
BEGIN
    --SELECT ����� �������̶� ����
    SELECT FIRST_NAME
    INTO NAME
    FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
    
    dbms_output.put_line(NAME);
END;

---------------------------------------------------------------

DECLARE
    NM VARCHAR2(30); -- �Ϲ� ����
    SALARY NUMBER;
    CURSOR X IS SELECT FIRST_NAME, SALARY FROM employees WHERE JOB_ID = 'IT_PROG';
BEGIN
    
    OPEN X; -- Ŀ�� ����
        dbms_output.put_line('------- Ŀ�� ���� -------');
    LOOP
        FETCH X INTO NM, SALARY; -- NM����, SALARY ����
        EXIT WHEN X%NOTFOUND; -- XĿ���� ���̻� ���� ���� ������ TRUE
               
        DBMS_OUTPUT.PUT_LINE(NM);
        DBMS_OUTPUT.PUT_LINE(SALARY);
        
    END LOOP;
    
     DBMS_OUTPUT.PUT_LINE('------- Ŀ�� ���� -------');
     DBMS_OUTPUT.PUT_LINE('�����ͼ� : ' || X%ROWCOUNT); -- Ŀ������ ���� ������ ��
     
    CLOSE X; -- Ŀ�� ����
END;

----------------------------------------------------------------------------

--4. �μ��� �޿����� ����ϴ� Ŀ�������� �ۼ��غ��ô�.

DECLARE
    DEPARTMENT_ID NUMBER;
    SUM_SALARY NUMBER;
    CURSOR C IS SELECT DEPARTMENT_ID, SUM(SALARY) FROM EMPLOYEES GROUP BY department_id;
BEGIN

    OPEN C;
    DBMS_OUTPUT.PUT_LINE('-- �μ��� �޿��� --');
    LOOP
        FETCH C INTO DEPARTMENT_ID, SUM_SALARY;
        EXIT WHEN C%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('�μ� : ' || department_id  || ' �޿� : ' || SUM_SALARY);
        
    END LOOP;
    
    CLOSE C;
    
END;
--5. ������̺��� ������ �޿����� ���Ͽ� EMP_SAL�� ���������� INSERT�ϴ� Ŀ�������� �ۼ��غ��ô�.
--������ �޿�����?

DECLARE
    CURSOR C IS SELECT A,
                       SUM(SALARY) AS B
                FROM (SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS A,
                            SALARY
                            FROM EMPLOYEES
                      )
                GROUP BY A
                ORDER BY A;
BEGIN

    FOR I IN C -- Ŀ���� FOR IN ������ ������ OPEN, CLOSE ���� ����
    LOOP
        --DBMS_OUTPUT.PUT_LINE(I.A || ' ' || I.B);    
        INSERT INTO EMP_SAL VALUES(I.A, I.B); --INSERT
        
    END LOOP;    
END;

SELECT * FROM EMP_SAL;  