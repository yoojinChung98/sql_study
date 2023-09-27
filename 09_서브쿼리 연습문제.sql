/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT COUNT(*) FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees
            WHERE job_id='IT_PROG');

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� �μ��� �����ִ� ������� ��� ������ ����ϼ���.
*/

--�� �̰� �Ȱ������� �׳� ...�ϸ�..�ȵǳ�?
SELECT * FROM employees WHERE manager_id = 100;

SELECT *
FROM employees
WHERE manager_id = (
    SELECT manager_id FROM departments d
    WHERE d.manager_id = 100
);
-- ���������� ������ ��ȯ�ϹǷ� ���࿬���� = �� ����ص� ����
-- ���� ANY ��� ���̱���

/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/
SELECT * FROM employees
WHERE manager_id > (SELECT manager_id FROM employees
                    WHERE first_name = 'Pat');
                    
SELECT * FROM employees
WHERE manager_id IN(SELECT manager_id FROM employees
                    WHERE first_name = 'James');

/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/


SELECT ROWNUM, tbl.*
FROM(
    SELECT ROWNUM AS rn, first_name
    FROM (
        SELECT first_name FROM employees
        ORDER BY first_name DESC
    )
) tbl
WHERE rn BETWEEN 41 AND 50;


/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȭ��ȣ, �Ի����� ����ϼ���.
*/

SELECT
    *
FROM (   
    SELECT ROWNUM AS rn, t.*
    FROM (
        SELECT employee_id, first_name, phone_number, hire_date
        FROM employees
        ORDER BY hire_date ASC
    ) t
)
WHERE rn >=31 AND rn<=40;


/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/
SELECT
    e.employee_id, CONCAT(e.first_name, e.last_name) AS �̸�,
    d.department_id, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id ASC;

/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
    e.employee_id,
    CONCAT(e.first_name, e.last_name) AS �̸�,
    e.department_id,
    (SELECT d.department_name
    FROM departments d
    WHERE d.department_id = e.department_id) AS department_name
FROM employees e
ORDER BY employee_id ASC;


/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/
SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.street_address, loc.postal_code, loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY department_id;

/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT 
    department_id, department_name, manager_id, location_id,
    (SELECT street_address FROM locations loc
    WHERE loc.location_id = d.location_id) AS street_address,
    (SELECT postal_code FROM locations loc
    WHERE loc.location_id = d.location_id) AS postal_code,
    (SELECT city FROM locations loc
    WHERE loc.location_id = d.location_id) AS city
FROM departments d
ORDER BY department_id;

/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
SELECT 
    loc.location_id, loc.street_address, loc.city,
    cy.country_id, cy.country_name
FROM locations loc
LEFT JOIN countries cy
ON loc.country_id = cy.country_id
ORDER BY country_name ASC;


/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
    loc.location_id, loc.street_address, loc.city, loc.country_id,
    (SELECT country_name FROM countries cy
    WHERE cy.country_id = loc.country_id) AS country_name
FROM locations loc
ORDER BY country_name ASC;
-- �ణ ���������� ���� �����ΰ���. �������� �ȿ��� ��Ī�� ���� �ܺο��� ����� �� �����.


/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 
1-10��° �����͸� ����մϴ�.
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, 
�μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/
--�̸� �ٵ����� employee ���̺�� �����ϸ� ��� �ϴ� �ñ����� ������ ������!������ ���ư���@!!!
SELECT
    e.*, d.department_name
FROM(
    SELECT
        ROWNUM AS rn,
        et.*
    FROM(
        SELECT
            employee_id, first_name, phone_number, hire_date, department_id
        FROM employees
        ORDER BY hire_date
    ) et
) e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE rn BETWEEN 1 AND 10
ORDER BY rn ASC;

--����� �̸� �����س���!

SELECT tbl.*
FROM(
    SELECT ROWNUM AS rn, t.*
    FROM(
        SELECT employee_id, first_name, phone_number, hire_date, d.DEPARTMENT_ID, department_name
        FROM employees e
        LEFT JOIN departments d
        ON e.department_id = d.department_id
        ORDER BY hire_date
    ) t
) tbl
WHERE rn BETWEEN 1 AND 10;


/*
���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/
SELECT
    e.last_name, e.job_id, d.department_id, department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE job_id = 'SA_MAN';


/*
���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.
*/
SELECT
    d.department_id, d.department_name, d.manager_id, tbl.count
FROM(
    SELECT
        department_id,
        COUNT(*) AS count
    FROM employees
    WHERE department_id IS NOT NULL
    GROUP BY department_id
) tbl
JOIN departments d
ON tbl.department_id = d.department_id
ORDER BY tbl.count DESC;


/*
���� 15
--�μ��� ���� ���� ����(d.*)��, �ּ�(loc), �����ȣ(loc), �μ��� ��� ����(e)�� ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.NVL(AVG(e.salary), 0)
*/

SELECT
    t.*,
    NVL((SELECT TRUNC(AVG(salary)) FROM employees e
        WHERE e.department_id = t.department_id),
    0) AS sal_avg
FROM(
    SELECT
        d.*, loc.street_address, loc.postal_code
    FROM departments d
    LEFT JOIN locations loc
    ON loc.location_id = d.location_id
) t;


SELECT
    d.*,
    loc.street_address,
    loc.postal_code,
    NVL(result.�μ�����տ���, 0) AS avg_salary
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
LEFT JOIN (
            SELECT
                department_id,
                TRUNC(AVG(salary)) AS �μ�����տ���
            FROM employees e
            GROUP BY department_id
            ) result
ON d.department_id = result.department_id;


/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� 
ROWNUM�� �ٿ� 1-10 ������ ������ ����ϼ���.
*/

SELECT ROWNUM AS rn, tbl.*
    FROM(
        SELECT
            t.*,
            NVL((SELECT AVG(salary) FROM employees e
                WHERE e.department_id = t.department_id),
            0) AS sal_avg
        FROM(
            SELECT
                d.*, loc.street_address, loc.postal_code
            FROM departments d
            LEFT JOIN locations loc
            ON loc.location_id = d.location_id
        ) t
        ORDER BY department_id
    ) tbl
WHERE ROWNUM <= 10;

