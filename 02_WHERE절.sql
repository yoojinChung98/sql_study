
SELECT * FROM employees;


-- WHERE �� �� (������ ���� ��/�ҹ��ڸ� �����մϴ�.)

--job_id �� IT_PROG �� ���ڵ常 ��ȸ�� ����. 
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = 'IT_PROG'; --���ڿ��̶� Ȭ����ǥ�� ���� ��.


SELECT * FROM employees
WHERE last_name = 'King';


SELECT *
FROM employees
WHERE department_id = 90;

SELECT *
FROM employees
WHERE salary >= 15000 AND salary<20000 ;

-- ������ �� ����
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

SELECT * FROM employees
WHERE hire_date = '04/01/30';

-- IN �������� ��� (Ư�� ����� ���� �� ���)
--�Ŵ������̵� 100 101 102 �� ����� ��ȸ�ϰ� ����(�� �� �ϳ��� �ش��ϴ� ��)
--OR Ű���带 ����ص� ��������� �ڵ尡 ������� ������ ������
SELECT * FROM employees
WHERE manager_id IN (100, 101, 102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP');

-- LIKE ������
-- ������ �����͸� ã�Ƴ��� ������
-- %�� �ƹ� ���ڿ� �ǹ�
-- _�� ���� �ϳ��� �ǹ�.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '05%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%05';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '___05%';

--IS NULL (NULL ���� ã��)
SELECT * FROM employees
WHERE manager_id IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NOT NULL;


-- AND, OR
-- AND�� OR ���� ���� ������ ����
SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')
AND salary >= 6000;

-- �������� ���� (��ȸ�� ������ �������� ����ȴٰ� ������!!)
--ORDER BY ����_�÷� (����Ʈ�� : ASC)
--SELECT  ������ ���� �������� ��ġ
--ASC: ascending �������� (
--DESC: descending ��������
SELECT * FROM employees
ORDER BY hire_date;

SELECT * FROM employees
ORDER BY hire_date DESC;

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees
WHERE salary >= 5000
ORDER BY employee_id DESC;

--�÷��� ��Ī�� �ٿ��ٸ�, ��Ī���� �θ��� ��
SELECT
    first_name,
    department_id,
    salary*12 AS pay
FROM employees
WHERE job_id LIKE 'IT_PROG'
ORDER BY pay ASC;








