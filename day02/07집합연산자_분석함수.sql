-- ���տ�����

/*
UNION = ������(�ߺ�X)
UNION ALL = ������(�ߺ�O)
INTERSECT = ������
MINUS = ������

�÷� ������ ��ġ�ؾ� ���տ����� ����� ����
*/

SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE LIKE '04%'
UNION
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;
------------------------------------------
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE LIKE '04%'
UNION ALL
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;
------------------------------------------
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE LIKE '04%'
INTERSECT
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;
------------------------------------------
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE LIKE '04%'
MINUS
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;

------------------------------------------

-- ���տ����ڴ� DUAL���� ���� �����͸� ���� ��ĥ ���� ����

SELECT 200 AS ��ȣ, 'HONG' AS �̸�, '�����' AS ���� FROM DUAL
UNION ALL
SELECT 300, 'LEE', '��⵵' FROM DUAL
UNION ALL
SELECT EMPLOYEE_ID, LAST_NAME, '�����' FROM EMPLOYEES;

--------------------------------------------------------------------------------

--�м� �Լ�

--�м��Լ� OVER(���� ���)
SELECT FIRST_NAME,
       SALARY,
       RANK() OVER(ORDER BY SALARY DESC) AS �ߺ��������,
       DENSE_RANK() OVER(ORDER BY SALARY DESC) AS �ߺ����µ��,
       ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS �Ϸù�ȣ,
       ROWNUM AS ��ȸ���ȼ���
FROM EMPLOYEES;

-- ROWNUM�� ORDER ��ų �� ����� �ٲ�
SELECT ROWNUM,
       FIRST_NAME,
       SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;


