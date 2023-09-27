/*
view�� �������� �ڷḸ ���� ���� ����ϴ� ���� ���̺��� �����Դϴ�.
��� �⺻ ���̺�� ������ ���� ���̺��̱� ������
�ʿ��� �÷��� ������ �θ� ������ ������ ���ϴ�.
��� �������̺�� ���� �����Ͱ� ���������� ����� ����(Ŀ�Ը� ����� ����Ǿ��ٸ� �ϵ��ũ�� ���������� ����Ǵ� ����)�� �ƴմϴ�.
��� ��ü���·θ� �����ϴ� ��. �������� ���� ���·� ����Ǵ� ���� �ƴ�. ���̺��̶��� �ٸ��ٴ� ����!!!
�並 ���ؼ� �����Ϳ� �����ϸ� ���� �����ʹ� �����ϰ� ��ȣ�� �� �ֽ��ϴ�.
����� �б��������� ������ ���� view�� ����, ����, ���� �� ���� ���̺��� �ݿ��ȴ�!!!(����!)


-�ܺο� �����ϰ� ���� ���� Ŀ������ �Ÿ� �� ����ڿ��� �����ְ� ���� ��.
- �����ϱ� ������ ��, ���ε� ��� ��ü�� ���� ���̺�� ���� �̿�.

-���̺��� ���������� ������ ����Ǵ� ��
-��� ���� 
-���� ������ �����ϰ�,
- �����ϰ� ���� ���� ������ �Ÿ��� ���� �� ���� (���̺��� ���� ������ �����ؾ��ϴµ�...)
- ��� insert, update, delte ���� �������̰�, �ƿ� ��� �Ǥ������� �б� �������� ���� �� �֤���...
*/

-- �並 ������ �� �ִ� ���� Ȯ�� (CREATE VIEW)
SELECT * FROM user_sys_privs;

--���� ����: �ܼ� ��, ���� ��

--�ܼ� ��: �ϳ��� ���̺��� �̿��Ͽ� ������ ��
SELECT
    employee_id,
    first_name || ' ' || last_name,
    job_id,
    salary
FROM employees
WHERE department_id = 60;

--���� �÷� �̸����� �Լ� ȣ�⹮, ����� ��� ���� ���� ǥ������ �� �� ����.
CREATE VIEW view_emp AS (
    SELECT
        employee_id,
        first_name || ' ' || last_name AS name,
        job_id,
        salary
    FROM employees
    WHERE department_id = 60
);
-- �÷����� ������ ���� �����Ǵ� �÷��� ��� ��Ī�� �� �������־�� ��


SELECT * FROM view_emp
WHERE salary >= 6000;

--���� ��: ���� ���� ���̺��� �����Ͽ� ������ ��
-- ���� ���Ǵ� ���� ����� ���, �̸� �����Ͽ� �ʿ��� �����͸� �����ϰ� ���� Ȯ���� ���� �����
CREATE VIEW view_emp_dept_jobs AS (
    SELECT
        e.employee_id,
        first_name || ' ' || last_name AS name,
        d.department_name,
        j.job_title
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;

-- ���� ���� (CREATE OR REPLACE VIEW ����)
-- �ش� ������ ����ϸ� ���� �̸��� �䰡 ������ ����, ������ �����Ͱ� ����Ǹ鼭 ���Ӱ� �����˴ϴ�
-- �׷��� ���ʿ� view�� ���� �� create or repalce view �������� ������!
CREATE OR REPLACE VIEW view_emp_dept_jobs AS (
    SELECT
        e.employee_id,
        first_name || ' ' || last_name AS name,
        d.department_name,
        j.job_title,
        e.salary
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT
    job_title,
    AVG(salary) AS avg
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY avg DESC;

-- �� ����
DROP VIEW view_emp;


/*
VIEW �� INSERT�� �Ͼ�� ��� '���� ���̺��� �ݿ�'�� �˴ϴ�!!!(���� VIEW ���� �� �б��������� �����ϴ� ��찡 ����)
�׷��� VIEW �� INSERT, UPDATE, DELETE�� ���� ���� ������ ����.
���� ���̺��� NOT NULL �� ���, VIEW�� INSERT, UPDATE, DELETE�� �Ұ�����
VIEW���� ����ϴ� �÷��� ������ ��쿡�� INSERT, UPDATE, DELETE  �Ұ��� (������ �����ϴ� �÷��� �ƴϹǷ�).
*/
INSERT INTO view_emp_dept_jobs
VALUES(300, 'test', 'test', 'test', 10000); --�����Ͽ���
--�ι�° �÷� 'name'�� ����(virtual column)�̱� ������ INSERT �Ұ�

INSERT INTO view_emp_dept_jobs (employee_id, department_name, job_title, salary)
VALUES(300, 'test', 'test', 10000); --�����Ͽ���
--���� ���� ���, �� ���� ������ �� ���� (�پ��� ���̺��� �����ϴµ�, �� ���̺��� ���������� �ٸ��Ƿ� �����ؼ� �Ұ�)

INSERT INTO view_emp (employee_id, job_id, salary)
VALUES (300, 'test', 10000); --�����Ͽ���
--���� ���̺��� NOT NULL�� �÷��� �� ���� �ǵ�...? ���� �� �ִ� ����� �ƿ� ����.
-- ���� ���̺� NULL�� ������� �ʴ� �÷��� ����� ���� �Ұ���.

DELETE FROM view_emp
WHERE employee_id = 103;
--103�� �����ϴ� �ܷ����̺��� �־ �Ұ���(�� ������ �ƴԤ���)

--����, ����, ���� ���� �� ���� ���̺��� �ݿ��˴ϴ�.
DELETE FROM view_emp
WHERE employee_id = 107;
SELECT * FROM view_emp;
SELECT * FROM employees;

ROLLBACK;

----------------���� �ɼ�---------------

--WITH CHECK OPTION -> ���� ���� �÷�
-- �並 ������ �� �������� ����� �÷��� �並 ���ؼ� ������ �� ���� ���ִ� Ű����
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
--WITH CHECK OPTION;
WITH CHECK OPTION CONSTRAINT view_emp_test_ck;

UPDATE view_emp_test SET department_id = 100
WHERE employee_id = 107;
-- WITH CHECK OPTION ���� ���� �����÷�(department_id)�� ����(update)�� �� ����.

SELECT * FROM view_emp_test;
ROLLBACK;




-- �б� ���� ��
--WITH READ ONLY : DML ��� ������ ���� (= SELECT�� ���)
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
WITH READ ONLY;


UPDATE view_emp_test SET job_id = 'AD_VP'
WHERE employee_id = 107;
-- WITH READ ONLY �� ���� DML ������ �� �� ����. (cannot perform a DML operation on a read-only view)


