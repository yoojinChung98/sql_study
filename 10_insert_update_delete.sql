
-- insert
-- ���̺� ���� Ȯ�� (DESC: ORDER BY ���� descending / �ܵ����� ���Ǹ� describe )
DESC departments;

-- insert�� ù��° ���
--1. ��� �÷� �����͸� �� ���� ���� (������ ���� ��� ���� �־�� ��)
--INSERT INTO ���̺�� VALUES(���� ��1, ���� ��2, ..., ���� ��n);
INSERT INTO departments
VALUES(300, '���ߺ�', null, null);

--2. ���� �÷��� �����ϰ� �����ϴ� ��. (NOT NULL �ݵ�� Ȯ���� ��!)
-- ���ϴ� �÷��� ������ �� ���� 
--INSERT INTO departments (�÷�1, �÷�3, �÷�n) VALUES (��1, ��3, ��n)
INSERT INTO departments
    (department_id, department_name, location_id)
VALUES
    (300, '�ѹ���', 1700);


INSERT INTO departments
    (department_id, location_id)
VALUES
    (300,  1700);
--���� ���� -
--ORA-01400: cannot insert NULL into ("HR"."DEPARTMENTS"."DEPARTMENT_NAME")
-- �ش� �÷��� NULL�� ������� �ʱ� ������ �ش� �÷��� �������� �ʰ�� INSERT�� �� ��


--3. �������� INSERT
-- �ش� ���̺��� �� ������������ ����� �����ϰڴٴ� �ǹ�.
-- INSERT INTO ���̺�� 
INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE department_id = 50);






--�纻 ���̺� ���� (CTAS)
CREATE TABLE emps AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees);

--������ ���� ������ �纻���� ����� ���� ���
CREATE TABLE emps AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2);
--WHERE 1=2 �� false ���� �ֱ� ���� ��¡���� �ǹ�.(����Ŭ���� boolean���� �����Ƿ�, false�� �ǹ̸� �ְ� ���� �� 
--�̷��� ��¡���� �ǹ̵��� �����)

--�纻 ���̺� ���� �� �׳� �����ϸ� ��ȸ�� �����ͱ��� ��� �����
-- WHERE ���� false ��(1=2)�� �����ϸ� ���̺��� ������ ����ǰ� �����ʹ� ���� X

--�纻���̺��� �������Ǳ��� ��������� ����.
---------------------------------------------------------

--UPDATE
--UPDATE ���̺�� SET �÷��� = ������ �� WHERE �������� ����;
--���� WHERE ������ �������� ������ ��� �����Ͱ� ������

CREATE TABLE emps AS
(SELECT * FROM employees);



-- UPDATE�� ������ ����, ������ ������ �� �� �����ؾ� �մϴ�.
-- �׷��� ������ ���� ����� ���̺� ��ü�� ����˴ϴ�.
UPDATE emps SET salary = 30000;

UPDATE emps SET salary = salary + salary*0.1
WHERE employee_id = 100;

-- �������� �����͸� �ѹ��� UPDATE �ϴ� ���
UPDATE emps
SET phone_number = '010.4742.8917', manager_id = 102
WHERE employee_id = 100;

-- UPDATE (��������)
--��ȸ�� �������� �����ϰ� ���� �� �����ϰ� ���
UPDATE emps
    SET(job_id, salary, manager_id) = 
    (
        SELECT job_id, salary, manager_id
        FROM emps
        WHERE employee_id = 100
    )
WHERE employee_id = 101;


-------------------------------------------------------
--DELETE
-- �� �� ��ü�� ���������� ���̱� ������ �÷��� ������ �ʿ䰡 ����!!!
DELETE FROM emps;
ROLLBACK;

DELETE FROM emps
WHERE employee_id = 103;


--DELETE (��������)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT');




-- CRUD = CREATE, READ, UPDATE, DELETE



SELECT * FROM emps;
DROP TABLE emps;


SELECT * FROM departments;
ROLLBACK; --���� ������ �ٽ� �ڷ� �ǵ����� Ű����






