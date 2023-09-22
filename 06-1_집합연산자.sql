
-- ���� ������
-- ���� �ٸ� ���� ����� ����� �ϳ��� ����, ��, ���̸� ���� �� �ְ� �� �ִ� ������
-- UNION(������, �ߺ�x), UNION ALL (������ �ߺ� o), INTERSECT(������), MINUS(������)
-- �� �Ʒ� column ������ ������ Ÿ���� ��Ȯ�� ��ġ�ؾ� �մϴ�.
-- ���տ���� ������ �޶��! ������ ���� ���ο� ����� ������(���̺�� ���̺��� ������ ���� ���ο� ����� ��ȸ�ϴ� ��)
-- ���տ����ڴ� ������ ������ �����ϴ� ��.(��ȸ�� ����� ������ ��ġ�� ���� �ϴ� ��. ��� ������ �ٸ� ����)

--UNION : �ߺ��� ������ �� ��ȸ ����� ���� ����.
-- ������ UNION ������;
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20;

-- UNION ALL : �ߺ��� �������� ���� �� ����� ���� ����
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20;

--INTERSECT : �� ������ ����� ���Ͽ� �ߺ��Ǵ� �����͸� ���
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20;


--A-B ������ 
--A �� B�� �ߺ��Ǿ��ִ� ����Ŭ�� ������ A�� ��ȸ��
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20;


-- B-A ������
-- �ߺ��� MICHAEL�� ������ B�� ����� ��µ�.
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';



--A^B: ��Ÿ�� ������ ab�����տ��� ������ �� �κ�



