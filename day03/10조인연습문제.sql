--���� 1.
--EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
--EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ� 
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT * FROM employees E INNER JOIN departments D ON e.department_id = D.department_id;
SELECT * FROM employees E LEFT JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E RIGHT JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E FULL JOIN departments D ON e.department_id = d.department_id;


--���� 2.
--EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT CONCAT(FIRST_NAME, LAST_NAME) AS NAME,
        d.department_id
FROM employees E 
JOIN departments D
ON e.department_id = d.department_id
WHERE employee_id = 200;


--���� 3.
--EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT CONCAT(FIRST_NAME, LAST_NAME) AS NAME, 
        JOB_ID, 
        JOB_TITLE 
FROM employees E 
INNER JOIN jobs J 
USING(JOB_ID)
ORDER BY NAME;


--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT *
FROM JOBS J1
LEFT JOIN job_history J2 
ON j1.job_id = j2.job_id;


--���� 5.
--Steven King�� �μ����� ����ϼ���.
SELECT E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King'; 


--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT * 
FROM employees E 
CROSS JOIN departments D;


--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
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


--���� 8.
--employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
SELECT *
FROM employees E 
LEFT JOIN JOBS J 
ON e.job_id = j.job_id
WHERE JOB_TITLE IN ('Stock Manager','Stock Clerk');


--���� 9.
--departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT d.department_name AS �μ�
FROM departments D
LEFT JOIN departments D2
ON d.department_id = d.location_id
WHERE d.manager_id IS NULL;

SELECT * 
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE EMPLOYEE_ID IS NULL;


--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT CONCAT( E2.FIRST_NAME || ' > ', E1.FIRST_NAME) AS �Ŵ���
FROM EMPLOYEES E1
LEFT JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID;


--���� 11. 
--EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--����) �Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
SELECT e2.manager_id AS �̸�,
        e2.salary AS �޿�
FROM employees E
LEFT JOIN employees E2
ON e.employee_id = e2.manager_id
WHERE e.manager_id IS NOT NULL
ORDER BY �޿� DESC;

SELECT e1.first_name,-- ���
        E1.SALARY,
        e2.first_name AS �Ŵ�����,
        e2.salary AS �Ŵ����Ǳ޿�
FROM EMPLOYEES E1
LEFT JOIN employees E2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY SALARY DESC;

--���ʽ� ���� 12.
--���������̽�(William smith)�� ���޵�(�����)�� ���ϼ���.
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
