--INSERT
--���̺� ������ ������ Ȯ���ϴ� ���
DESC departments;

--1ST
INSERT INTO departments VALUES(280, 'DEVELOPER', NULL, 1700);
-- DML���� Ʈ������� �׻� ��ϵǴµ�, ROLLBACK �̿��ؼ� �ǵ��� �� ����
ROLLBACK;

--2ND (�÷��� ���� ����)
INSERT INTO departments(department_ID, department_NAME, LOCATION_ID) VALUES(280, 'DEVELOPER', 1700);

--INSERT������ �������� �� (������)
INSERT INTO departments(department_ID, department_NAME) VALUES((SELECT MAX(department_ID) + 10 FROM departments),'DEV');
ROLLBACK;
--INSERT������ �������� (������)
CREATE TABLE EMPS AS (SELECT * FROM employees WHERE 1 = 2); -- ���̺� ���� ����

SELECT * FROM EMPS; -- �� ���̺� ���� ���̺��� Ư�� �����͸� �۴� ����

INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');

COMMIT; -- Ʈ������� �ݿ���


---------------------------------------------------------------------------------------------------

--UPDATE
SELECT * FROM EMPS;

-- UPDATE ������ ����ϱ� ������ SELECT�� �ش� ���� ������ ������ Ȯ���ϰ� UPDATE ó���ؾ���
UPDATE EMPS SET SALARY = 1000, COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148; -- KEY�� ���ǿ� �ִ°� �Ϲ���
UPDATE EMPS SET SALARY = NVL(SALARY, 0) + 1000 WHERE EMPLOYEE_ID >= 145; 

-- UPDATE ������ ����������
-- 1ST (���ϰ� ��������)
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;

-- 2ND (������ ��������)
UPDATE EMPS 
SET (SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
= (SELECT SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100)
WHERE EMPLOYEE_ID = 148;

-- 3ND (WHERE���� ��)
UPDATE EMPS
SET SALARY = 1000
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

---------------------------------------------------------------------------------------------------

--DELETE����
--Ʈ������� �ֱ� ������, �����ϱ����� �ݵ�� SELECT������ ���� ���ǿ� �ش��ϴ� �����͸� �� Ȯ���ϴ� ����
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;

DELETE FROM EMPS WHERE EMPLOYEE_ID = 148; -- KEY�� ���ؼ� ����� ���� ����
--DELETE������ ��������
DELETE FROM EMPS WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 80);
ROLLBACK;

---------------------------------------------------------------------------------------------------

--DELETE���� ���� ����Ǵ� ���� �ƴ�
--���̺��� ��������(FK)������ ������ �ִٸ� �������� ���� (�������Ἲ ����)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DELETE FROM departments WHERE department_ID = 100; -- EMPLOYEES���� 100�� �����͸� FK�� ����ϰ� �־ ���� �� ����

---------------------------------------------------------------------------------------------------

--MERGE�� - Ÿ�����̺� �����Ͱ� ������ UPDATE, ������ INSERT������ �����ϴ� ����

--1ST
MERGE INTO EMPS A --Ÿ�����̺�
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B --��ĥ���̺�
ON (A.employee_ID = B.employee_ID) --������ Ű
WHEN MATCHED THEN --��ġ�ϴ� ���
    UPDATE /*���̺��(����)*/ SET A.SALARY = B.SALARY,
                A.COMMISSION_PCT = B.COMMISSION_PCT,
                A.HIRE_DATE = SYSDATE
                -- .....����
WHEN NOT MATCHED THEN --��ġ���� �ʴ� ���
    INSERT /*INTO(����)*/(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID) 
    VALUES (B.EMPLOYEE_ID, B.LAST_NAME, B.EMAIL, B.HIRE_DATE, B.JOB_ID);
    
SELECT * FROM EMPS;

--2ND - ������������ �ٸ� ���̺��� �������°� �ƴ϶� ���� ���� ���� �� DUAL�� �� ���� ����
MERGE INTO EMPS A
USING DUAL
ON (A.EMPLOYEE_ID = 107) -- ����
WHEN MATCHED THEN -- ��ġ�ϸ�
    UPDATE SET A.SALARY = 10000,
                A.COMMISSION_PCT = 0.1,
                A.DEPARTMENT_ID = 100
WHEN NOT MATCHED THEN -- ��ġ���� ������
    INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (107, 'HONG', 'EXAMPLE', SYSDATE, 'DBA');
    
SELECT * FROM EMPS;

---------------------------------------------------------------------------------------------------

DROP TABLE EMPS;

--CTAS - ���̺� ���� ����
CREATE TABLE EMPS AS(SELECT * FROM  EMPLOYEES); -- �����Ͱ����� ����

CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- ������ ����   

SELECT * FROM EMPS;

---------------------------------------------------------------------------------------------------

--���� 1.
--DEPTS���̺��� �����͸� �����ؼ� �����ϼ���.
CREATE TABLE DEPTS AS (SELECT * FROM departments);
--DEPTS���̺��� ������ INSERT �ϼ���
INSERT INTO DEPTS VALUES(280, '����', NULL, 1800);
INSERT INTO DEPTS VALUES(290, 'ȸ���', NULL, 1800);
INSERT INTO DEPTS VALUES(300, '����', 301, 1800);
INSERT INTO DEPTS VALUES(310, '�λ�', 302, 1800);
INSERT INTO DEPTS VALUES(320, '����', 303, 1800);
COMMIT;


--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT bank' WHERE DEPARTMENT_NAME = 'IT Support';
--2. department_id�� 290�� �������� manager_id�� 301�� ����
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID = 290;
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵� 1800���� �����ϼ���
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT Help', MANAGER_ID = 303, LOCATION_ID = 1800 WHERE DEPARTMENT_NAME = 'IT Helpdesk';
--4. �μ���ȣ (290, 300, 310, 320) �� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
UPDATE DEPTS SET MANAGER_ID = 301 
WHERE department_id = 290 OR department_id = 300 OR department_id = 310 OR department_id = 320;


--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 320;
--2. �μ��� NOC�� �����ϼ���
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 220;


--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� ������ ������.
CREATE TABLE DEPTSCP AS(SELECT * FROM DEPTS);
DELETE FROM DEPTSCP WHERE DEPARTMENT_ID > 200;
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
UPDATE DEPTSCP SET MANAGER_ID = 100 WHERE MANAGER_ID IS NOT NULL;
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�, �������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
MERGE INTO DEPTS A
USING (SELECT * FROM departments) B
ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET A.DEPARTMENT_NAME = B.DEPARTMENT_NAME,
                A.MANAGER_ID = B.MANAGER_ID,
                A.LOCATION_ID = B.LOCATION_ID
WHEN NOT MATCHED THEN 
    INSERT VALUES (B.DEPARTMENT_ID, B.DEPARTMENT_NAME, B.MANAGER_ID, B.LOCATION_ID);

SELECT * FROM DEPTS;


--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000);
--2. jobs_it ���̺� �Ʒ� �����͸� �߰��ϼ���
INSERT INTO JOBS_IT VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO JOBS_IT VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO JOBS_IT VALUES('SEC_DEV', '���Ȱ�����', 6000, 20000);

SELECT * FROM JOBS_IT;
--3. obs_it�� Ÿ�� ���̺� �Դϴ�
--jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
MERGE INTO JOBS_IT A
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) B
ON (A.JOB_ID = B.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET A.MIN_SALARY = B.MIN_SALARY,
                A.MAX_SALARY = B.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES (B.JOB_ID, B.JOB_TITLE, B.MIN_SALARY, B.MAX_SALARY);
    
SELECT * FROM JOBS_IT;

COMMIT;