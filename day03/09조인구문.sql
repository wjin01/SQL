SELECT * FROM AUTH;
SELECT * FROM INFO;

-- INNER JOIN - 붙을 수 없는 데이터는 나오지 않음
SELECT *
FROM INFO 
INNER JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;

SELECT INFO.ID,
        INFO.TITLE,
        INFO.CONTENT,
        INFO.AUTH_ID, -- AUTH_ID는 양쪽에 다 있는 KEY, 테이블.컬럼명 기입해줘야 함
        AUTH.NAME
FROM INFO
INNER JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;


--테이블 ALIAS
SELECT I.ID,
        I.TITLE,
        A.AUTH_ID,
        A.NAME,
        A.JOB
FROM INFO I -- 테이블 ALIAS
INNER JOIN AUTH A 
ON I.AUTH_ID = A.AUTH_ID;

--연결할 KEY가 같다면 USING 구문을 사용할 수 있음
SELECT *
FROM INFO I
INNER JOIN AUTH A
USING (AUTH_ID);

----------------------------------------------------------------------

--OUTER JOIN
--LEFT OUTER JOIN (OUTER 생략 가능) - 왼쪽 테이블이 기준이 되어서 왼쪽테이블은 전부 나옴
SELECT * FROM INFO I LEFT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGTH OUTER JOIN - 오른쪽 테이블이 기준이 되어서 오른쪽 테이블은 전부 나옴
SELECT * FROM INFO I RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT JOIN의 테이블 자리만 바꿔주면 LEFT JOIN
SELECT * FROM AUTH A RIGHT OUTER JOIN INFO I ON I.AUTH_ID = A.AUTH_ID;

--FULL OUTER JOIN - 양쪽데이터 누락없이 다 나옴
SELECT * FROM INFO I FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--CROSS JOIN(잘못된 JOIN의 형태 - 실제로 쓸 일은 없음)
SELECT * FROM INFO I CROSS JOIN AUTH A;

----------------------------------------------------------------------

--SELF JOIN (하나의 테이블을 가지고 JOIN을 거는것 - 조건 테이블 안에 연결 가능한 KEY가 필요함)
SELECT * FROM EMPLOYEES;

SELECT * 
FROM EMPLOYEES E 
LEFT JOIN EMPLOYEES E2
ON e.manager_id = e2.employee_id;

----------------------------------------------------------------------

-- 오라클 조인 - 오라클에서만 사용할 수 있고 조인할 테이블을 FROM에 씀
-- 조인 조건을 WHERE에 씀

-- 오라클 INNER JOIN
SELECT * 
FROM INFO I, AUTH A
WHERE i.auth_id = a.auth_id;

-- 오라클 LEFT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id = a.auth_id(+); --붙일 테이블어 (+)

-- 오라클 RIGHT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id(+) = a.auth_id;

-- 오라클 FULL OUTER JOIN은 없음

-- CROSS JOIN은 잘못된 JOIN(JOIN 조건을 안 적었을 경우 나타남)
SELECT *
FROM INFO I, AUTH A;

----------------------------------------------------------------------

SELECT * FROM EMPLOYEES;
SELECT * FROM departments;
SELECT * FROM locations;

SELECT * FROM employees E INNER JOIN departments D ON e.department_id = d.department_id;

--JOIN은 여러번 할 수도 있음
SELECT e.employee_id,
        e.first_name,
        d.department_name,
        l.city
FROM EMPLOYEES E 
LEFT JOIN departments D ON E.DEPARTMENT_ID = d.department_id
LEFT JOIN locations L ON d.location_id = l.location_id
WHERE EMPLOYEE_ID >= 150;

--평범하게 생각하면 N테이블에 1테이블을 붙이는게 가장 많음

-- 1에 N을 붙임
SELECT *FROM departments D LEFT EMPLOYEES E ON 