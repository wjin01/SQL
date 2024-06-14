--문제 1.
--EMPLOYEES 테이블과, DEPARTMENTS 테이블은 DEPARTMENT_ID로 연결되어 있습니다.
--EMPLOYEES, DEPARTMENTS 테이블을 엘리어스를 이용해서 
--각각 INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER 조인 하세요. (달라지는 행의 개수 확인)
SELECT * FROM employees E INNER JOIN departments D ON e.department_id = D.department_id;
SELECT * FROM employees E LEFT JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E RIGHT JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E FULL JOIN departments D ON e.department_id = d.department_id;


--문제 2.
--EMPLOYEES, DEPARTMENTS 테이블을 INNER JOIN하세요
--조건)employee_id가 200인 사람의 이름, department_id를 출력하세요
--조건)이름 컬럼은 first_name과 last_name을 합쳐서 출력합니다
SELECT CONCAT(FIRST_NAME, LAST_NAME) AS NAME,
        d.department_id
FROM employees E 
JOIN departments D
ON e.department_id = d.department_id
WHERE employee_id = 200;


--문제 3.
--EMPLOYEES, JOBS테이블을 INNER JOIN하세요
--조건) 모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고, 이름 기준으로 오름차순 정렬
--HINT) 어떤 컬럼으로 서로 연결되 있는지 확인
SELECT CONCAT(FIRST_NAME, LAST_NAME) AS NAME, 
        JOB_ID, 
        JOB_TITLE 
FROM employees E 
INNER JOIN jobs J 
USING(JOB_ID)
ORDER BY NAME;


--문제 4.
--JOBS테이블과 JOB_HISTORY테이블을 LEFT_OUTER JOIN 하세요.
SELECT *
FROM JOBS J1
LEFT JOIN job_history J2 
ON j1.job_id = j2.job_id;


--문제 5.
--Steven King의 부서명을 출력하세요.
SELECT E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King'; 


--문제 6.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(Cross join)처리하세요
SELECT * 
FROM employees E 
CROSS JOIN departments D;


--문제 7.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호, 이름, 
--급여, 부서명, 근무지를 출력하세요. (Alias를 사용)
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.SALARY,
       D.DEPARTMENT_NAME,
       L.STREET_ADDRESS
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
WHERE JOB_ID = 'SA_MAN';


--문제 8.
--employees, jobs 테이블을 조인 지정하고 job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보만
--출력하세요.
SELECT *
FROM employees E 
LEFT JOIN JOBS J 
ON e.job_id = j.job_id
WHERE JOB_TITLE IN ('Stock Manager','Stock Clerk');


--문제 9.
--departments 테이블에서 직원이 없는 부서를 찾아 출력하세요. LEFT OUTER JOIN 사용
SELECT d.department_name AS 부서
FROM departments D
LEFT JOIN departments D2
ON d.department_id = d.location_id
WHERE d.manager_id IS NULL;

SELECT * 
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE EMPLOYEE_ID IS NULL;


--문제 10. 
--join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요
--힌트) EMPLOYEES 테이블과 EMPLOYEES 테이블을 조인하세요.
SELECT CONCAT( E2.FIRST_NAME || ' > ', E1.FIRST_NAME) AS 매니저
FROM EMPLOYEES E1
LEFT JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID;


--문제 11. 
--EMPLOYEES 테이블에서 left join하여 관리자(매니저)와, 매니저의 이름, 매니저의 급여 까지 출력하세요
--조건) 매니저 아이디가 없는 사람은 배제하고 급여는 역순으로 출력하세요
SELECT e2.manager_id AS 이름,
        e2.salary AS 급여
FROM employees E
LEFT JOIN employees E2
ON e.employee_id = e2.manager_id
WHERE e.manager_id IS NOT NULL
ORDER BY 급여 DESC;

SELECT e1.first_name,-- 사원
        E1.SALARY,
        e2.first_name AS 매니저명,
        e2.salary AS 매니저의급여
FROM EMPLOYEES E1
LEFT JOIN employees E2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY SALARY DESC;

--보너스 문제 12.
--윌리엄스미스(William smith)의 직급도(상급자)를 구하세요.
SELECT * FROM EMPLOYEES;

SELECT * 
FROM EMPLOYEES
WHERE FIRST_NAME = 'William' AND LAST_NAME = 'Smith';

SELECT e3.first_name || ' > '|| e2.first_name || ' > ' || e1.first_name
FROM employees E1
LEFT JOIN employees E2
ON e1.manager_id = e2.employee_id
LEFT JOIN employees E3
ON e2.manager_id = e3.employee_id
WHERE e1.first_name = 'William' AND e1.last_name = 'Smith';
