/*
# �������� 
= ���� ����
- ������ �ɰų�, Ư�� ���̺��� �������� ���� �����ϰų� ���� �ϰ� ���� �� ����ϴ� ����
: SQL ���� �ȿ� �Ǵٸ� SQL ������ �����ϴ� ���
���� ���� ���Ǹ� ���ÿ� ó���� �� �ֽ��ϴ�.
WHERE, SELECT, FROM ���� �ۼ� ����.


- ���������� ������� () �ȿ� �����.
 ������������ �������� 1�� ���Ͽ��� �մϴ�.
- �������� ������ ���� ����� �ϳ� �ݵ�� ���� �մϴ�.
- �ؼ��� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.

- where, select, from �پ��� ���� ���� �� ����
- ����) ������ where���� �� �������� �ʴ� ��
*/

--'Nancy'�� �޿����� �޿��� ���� ����� �˻��ϴ� ����
--Nancy�� �޿�, ~���� �޿��� ���� ���. �� �� ��ȸ�� ���� ������ ���� �ϴ� ��Ȳ -> ��! �ϳ��� ���������� ���¡~
SELECT salary FROM employees
WHERE first_name = 'Nancy';

SELECT first_name FROM employees
WHERE salary > 12008;
---->
SELECT first_name FROM employees
WHERE salary > (SELECT salary FROM employees
                WHERE first_name = 'Nancy');


-- employee_id �� 103���� ����� job_id�� ���� ����� ��ȸ.
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE employee_id = 103);


--������ ��������
--���������� ������ ����������. �� �ϳ��� �ุ �����ؾ���. �ٵ� ��� 5���� ������.
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG'); --����
-- ���� ������ ���������� �����ϴ� ���� ���� ���� ������ �����ڸ� ����� �� ����
-- �̷� ��쿡�� ������ �����ڸ� ����ؾ� �մϴ�.

-- ���� �� ������: �ַ� �񱳿����� ( = > < >= <= <>(->��������) )
-- ������ �����ڸ� ����ϴ� ��� ���������� �ݵ�� �ϳ��� �ุ�� ��ȯ�ؾ� ��.
-- ���� �� ������: (IN, ANY, ALL)
SELECT * FROM employees
WHERE job_id IN(SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG');
                
                
--IN ��ȸ�� ����� � ���� ������ Ȯ���մϴ�.
-- first_name�� David�� ������� �޿��� ���� �޿��� �޴� ������� ��ȸ.
SELECT employee_id, first_name, job_id, salary FROM employees
WHERE salary IN(SELECT salary FROM employees
                WHERE first_name = 'David');

--ANY, SOME: ���� ���������� ���� ���ϵ� ������ ���� ���մϴ�.
-- �ϳ��� �����ϸ� �˴ϴ�.
SELECT employee_id, first_name, job_id, salary FROM employees
WHERE salary > ANY(SELECT salary FROM employees
                WHERE first_name = 'David');
                
--ALL : ���� ���������� ���� ���ϵ� ������ ���� ��� ����
-- ��� �����ؾ� ��
SELECT employee_id, first_name, job_id, salary FROM employees
WHERE salary > ALL(SELECT salary FROM employees
                WHERE first_name = 'David');


--EXISTS: ���������� �ϳ� �̻��� ���� ��ȯ�ϸ� ������ ����
-- JOIN ���ε� �� �� �ִµ� EXIST�� �Ἥ �̷��Ե� �������� �ۼ��� �� �ִ�~
-- job_history�� �����ϴ� ������ employees���� �����Ѵٸ� ��ȸ�� ����.
SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM job_history jh
             WHERE e.employee_id = jh.employee_id);
-- SELECT 1�� �ȿ� �ִ� �������� ���γ����� �ñ����� �ʴٴ� ��¡���� �ǹ�.
-- �״ϱ� ������ �������ؼ� SELECT�� �� ����ϴµ�... ���γ����� ���� �ʿ����� �ʴ� ������.. �׶� 1�� ��¡���� �ǹ̷ν� ä���ִµ� �����.

--EXISTS�� ������ ���������� üũ�ϴ� ��.
SELECT * FROM employees
WHERE EXISTS (SELECT 1 FROM departments
                WHERE department_id = 200);
                
-------------------------------------------------

--SELECT ���� ���������� ���̱�

SELECT
    e.first_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

--������ ���� �ʾƵ� ���� ����� ����ϰ� ����� �� �� �ִٱ�???
--�÷��� �� �ڸ��� ��ȣ�� ��� �������� �ۼ�.
--�̸� ��Į�� ��������(Scalar Subquery)��� Ī��
-- ��Į�� ��������: ���� ����� ���� ���� ��ȯ�ϴ� ��������. �ַ� SELECT ���̳� WHERE ������ ����.
SELECT
    e.first_name,
    (
        SELECT
            department_name
        FROM departments d
        WHERE d.department_id = e.department_id
    ) AS department_name
FROM employees e
ORDER BY first_name ASC;
/*
-- �� ��� �ѹ��� ���������κ��� ��� �ѹ��� ����Ǵ� ��.
1. FROM employees e
2. SELECT e.first_name, (���� ����), �� �� ���, e_first_name, (��������), �� �� ���... 107��.
��, ���ʿ� �ִ� �������� �� �ึ�� �ݺ�����Ǵ� ��
���� SELECT ���ʿ� �ۼ��ϴ� ���������� JOIN�� �ſ� ������
*/
/*
- ��Į�� ���������� ���κ��� ���� ���
: �Լ�ó�� �� ���ڵ�� ��Ȯ�� �ϳ��� ������ ������ ��.

- ������ ��Į�� ������������ ���� ���
: ��ȸ�� �÷��̳� �����Ͱ� ��뷮�� ���, �ش� �����Ͱ�
����, ���� ���� ����� ��� (sql �������� ���鿡�� ������ ���� �� �پ)
*/


-- �� �μ��� �Ŵ��� �̸� ��ȸ
-- LEFT JOIN
SELECT
    d.*,
    e.first_name
FROM departments d
LEFT OUTER JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

SELECT
    d.*,
    (
        SELECT e.first_name
        FROM employees e
        WHERE e.employee_id = d.manager_id
    ) AS manager_name
FROM departments d
ORDER BY d.manager_id ASC;

-- �� �μ��� ��� �� �̱�
SELECT
    d.*,
    (
        SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id
    ) AS �����
FROM departments d;

SELECT
    --d.*, --���� ��.
    d.department_id,
    COUNT(*)
FROM departments d
LEFT JOIN employees e
ON  e.department_id = d.department_id
GROUP BY d.department_id;


-------------------------------------

-- �ζ��� �� (FROM ������ ���������� ���� ��.)
-- Ư�� ���̺� ��ü�� �ƴ� SELECT�� ���� �Ϻ� �����͸� ��ȸ�� ���� ���� ���̺�(=��)�� ����ϰ� ���� ��!
-- '������ ���س��� ��ȸ �ڷḦ ������ �����ؼ� ������ ���� ���'

SELECT
    ROWNUM AS rn, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC
WHERE rn BETWEEN 1 AND 10;
-- ROWNUM �� ���̰� �� ��(SELECT ����) ORDER BY�� �����ع����� ROWNUM�� ������ Ʋ����.
-- ��ȸ�ϰ� ���ı��� ���� ������ ROWNUM �� ���߿� �ٿ�������!

-- salary�� ������ �����ϸ鼭 �ٷ� ROWNUM�� ���̸�
-- ROWNUM�� ������ ���� �ʴ� ��Ȳ�� �߻��մϴ�.
-- ����: ROWNUM�� ���� �ٰ� ������ ����Ǳ� ����. ORDER BY�� �׻� �������� ����.
-- �ذ�: ������ �̸� ����� �ڷῡ ROWNUM�� �ٿ��� �ٽ� ��ȸ�ϴ� ���� ���� �� ���ƿ�.

        SELECT *
        FROM
            (
            SELECT
                ROWNUM AS rn,
                tbl.*
            FROM (
                SELECT
                employee_id, first_name, salary
                FROM employees
                ORDER BY salary DESC
            ) tbl
        )
        WHERE rn > 0 AND rn <= 10;

/*
-������-
1.ORDER BY�� ���� �ļ����̹Ƿ� ROWNUM�� �ٿ����� ���� �ٽ� salary �������� �������Ͽ� ROWNUM Ȱ�� �Ұ���
2. ROWNUM�� ���� �������� WHERE �ɷ��� �ص� sql ��������� ���� ���� �������� ���� ROWNUM���� WHERE�� ������ �� �� ����.

-���� �ذ�-
1. ORDER BY�� ���� salary �������� ������ ���̺���
2. ���ĵ� ���̺� ROWNUM�� ���� ���� ���̺���
3. ������ �ٿ��� �ɷ��´�!
*/

/*
���� ���� SELECT ������ �ʿ��� ���̺� ����(�ζ��� ��)�� ����.
�ٱ��� SELECT ������ ROWNUM�� �ٿ��� �ٽ� ��ȸ
���� �ٱ��� SELECT �������� �̹� �پ��ִ� ROWNUM�� ������ �����ؼ� ��ȸ.

** SQL�� ���� ����
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

-- �� �������� �Խ��� �� ����¡�� ����.
*/










