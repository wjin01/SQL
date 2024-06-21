--제어문

/*
IF 조건절 THEN
ELSIF 조건절 THEN
ELSE ~~~
END IF;
*/
SET SERVEROUTPUT ON;

DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.value(1, 101)); --
BEGIN
    
    DBMS_OUTPUT.put_line('점수 : ' || POINT);
    /*
    IF POINT >= 90 THEN
        DBMS_OUTPUT.put_line('A학점 입니다');
    ELSIF POINT >= 80 THEN
        DBMS_OUTPUT.put_line('B학점 입니다');
    ELSIF POINT >= 70 THEN
        DBMS_OUTPUT.put_line('C학점 입니다');
    ELSE
        DBMS_OUTPUT.put_line('F학점 입니다');
    END IF;
    */
    
    CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.put_line('A학점 입니다');
         WHEN POINT >= 80 THEN DBMS_OUTPUT.put_line('B학점 입니다');
         WHEN POINT >= 70 THEN DBMS_OUTPUT.put_line('C학점 입니다');
         ELSE DBMS_OUTPUT.put_line('F학점 입니다');
    END CASE;
    
END;


--------------------------------------------------------------

--반복문

--WHILE문
DECLARE
    CNT NUMBER := 1;
BEGIN

    WHILE CNT <= 9
    LOOP
        dbms_output.put_line('3 X ' || CNT || ' = ' || CNT * 3);
        
        CNT := CNT +1; -- 1 증가
        
    END LOOP;
    
END;

------------------------------------------------------------------

--FOR문
DECLARE
    
BEGIN

    FOR I IN 1..9 -- 1~9까지
    LOOP
        CONTINUE WHEN I = 5; -- I가 5면 다음으로
        DBMS_OUTPUT.put_line('3 X ' || I || ' = ' || I * 3);
        EXIT WHEN I = 5; -- I가 5면 탈출
    END LOOP;
    
END;

----------------------------------------------------------------

--1. 2~9단까지 출력하는 익명블록 

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

--커서

DECLARE
    NAME VARCHAR2(30);
BEGIN
    --SELECT 결과가 여러행이라 에러
    SELECT FIRST_NAME
    INTO NAME
    FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
    
    dbms_output.put_line(NAME);
END;

---------------------------------------------------------------

DECLARE
    NM VARCHAR2(30); -- 일반 변수
    SALARY NUMBER;
    CURSOR X IS SELECT FIRST_NAME, SALARY FROM employees WHERE JOB_ID = 'IT_PROG';
BEGIN
    
    OPEN X; -- 커서 선언
        dbms_output.put_line('------- 커서 시작 -------');
    LOOP
        FETCH X INTO NM, SALARY; -- NM변수, SALARY 저장
        EXIT WHEN X%NOTFOUND; -- X커서에 더이상 읽을 값이 없으면 TRUE
               
        DBMS_OUTPUT.PUT_LINE(NM);
        DBMS_OUTPUT.PUT_LINE(SALARY);
        
    END LOOP;
    
     DBMS_OUTPUT.PUT_LINE('------- 커서 종료 -------');
     DBMS_OUTPUT.PUT_LINE('데이터수 : ' || X%ROWCOUNT); -- 커서에서 읽은 데이터 수
     
    CLOSE X; -- 커서 닫음
END;

----------------------------------------------------------------------------

--4. 부서벌 급여합을 출력하는 커서구문을 작성해봅시다.

DECLARE
    DEPARTMENT_ID NUMBER;
    SUM_SALARY NUMBER;
    CURSOR C IS SELECT DEPARTMENT_ID, SUM(SALARY) FROM EMPLOYEES GROUP BY department_id;
BEGIN

    OPEN C;
    DBMS_OUTPUT.PUT_LINE('-- 부서별 급여합 --');
    LOOP
        FETCH C INTO DEPARTMENT_ID, SUM_SALARY;
        EXIT WHEN C%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('부서 : ' || department_id  || ' 급여 : ' || SUM_SALARY);
        
    END LOOP;
    
    CLOSE C;
    
END;
--5. 사원테이블의 연도별 급여합을 구하여 EMP_SAL에 순차적으로 INSERT하는 커서구문을 작성해봅시다.
--연도별 급여합은?

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

    FOR I IN C -- 커서를 FOR IN 구문에 넣으면 OPEN, CLOSE 생략 가능
    LOOP
        --DBMS_OUTPUT.PUT_LINE(I.A || ' ' || I.B);    
        INSERT INTO EMP_SAL VALUES(I.A, I.B); --INSERT
        
    END LOOP;    
END;

SELECT * FROM EMP_SAL;  