SELECT * FROM AUTH;
SELECT * FROM INFO;

-- INNER JOIN - ���� �� ���� �����ʹ� ������ ����
SELECT *
FROM INFO 
INNER JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;

SELECT INFO.ID,
        INFO.TITLE,
        INFO.CONTENT,
        INFO.AUTH_ID, -- AUTH_ID�� ���ʿ� �� �ִ� KEY, ���̺�.�÷��� ��������� ��
        AUTH.NAME
FROM INFO
INNER JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;


--���̺� ALIAS
SELECT I.ID,
        I.TITLE,
        A.AUTH_ID,
        A.NAME,
        A.JOB
FROM INFO I -- ���̺� ALIAS
INNER JOIN AUTH A 
ON I.AUTH_ID = A.AUTH_ID;

--������ KEY�� ���ٸ� USING ������ ����� �� ����
SELECT *
FROM INFO I
INNER JOIN AUTH A
USING (AUTH_ID);

----------------------------------------------------------------------

--OUTER JOIN
--LEFT OUTER JOIN (OUTER ���� ����) - ���� ���̺��� ������ �Ǿ �������̺��� ���� ����
SELECT * FROM INFO I LEFT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGTH OUTER JOIN - ������ ���̺��� ������ �Ǿ ������ ���̺��� ���� ����
SELECT * FROM INFO I RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT JOIN�� ���̺� �ڸ��� �ٲ��ָ� LEFT JOIN
SELECT * FROM AUTH A RIGHT OUTER JOIN INFO I ON I.AUTH_ID = A.AUTH_ID;

--FULL OUTER JOIN - ���ʵ����� �������� �� ����
SELECT * FROM INFO I FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--CROSS JOIN(�߸��� JOIN�� ���� - ������ �� ���� ����)
SELECT * FROM INFO I CROSS JOIN AUTH A;

----------------------------------------------------------------------

--SELF JOIN (�ϳ��� ���̺��� ������ JOIN�� �Ŵ°� - ���� ���̺� �ȿ� ���� ������ KEY�� �ʿ���)
SELECT * FROM EMPLOYEES;

SELECT * 
FROM EMPLOYEES E 
LEFT JOIN EMPLOYEES E2
ON e.manager_id = e2.employee_id;

----------------------------------------------------------------------

-- ����Ŭ ���� - ����Ŭ������ ����� �� �ְ� ������ ���̺��� FROM�� ��
-- ���� ������ WHERE�� ��

-- ����Ŭ INNER JOIN
SELECT * 
FROM INFO I, AUTH A
WHERE i.auth_id = a.auth_id;

-- ����Ŭ LEFT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id = a.auth_id(+); --���� ���̺�� (+)

-- ����Ŭ RIGHT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id(+) = a.auth_id;

-- ����Ŭ FULL OUTER JOIN�� ����

-- CROSS JOIN�� �߸��� JOIN(JOIN ������ �� ������ ��� ��Ÿ��)
SELECT *
FROM INFO I, AUTH A;

----------------------------------------------------------------------

SELECT * FROM EMPLOYEES;
SELECT * FROM departments;
SELECT * FROM locations;

SELECT * FROM employees E INNER JOIN departments D ON e.department_id = d.department_id;

--JOIN�� ������ �� ���� ����
SELECT e.employee_id,
        e.first_name,
        d.department_name,
        l.city
FROM EMPLOYEES E 
LEFT JOIN departments D ON E.DEPARTMENT_ID = d.department_id
LEFT JOIN locations L ON d.location_id = l.location_id
WHERE EMPLOYEE_ID >= 150;

--����ϰ� �����ϸ� N���̺� 1���̺��� ���̴°� ���� ����

-- 1�� N�� ����
SELECT *FROM departments D LEFT EMPLOYEES E ON 