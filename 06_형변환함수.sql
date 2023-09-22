
-- �� ��ȯ �Լ� TO_CHAR, TO_NUMBER, TO_DATE

-- ��¥�� ���ڷ� TO_CHAR(��, ����)
SELECT TO_CHAR(sysdate) FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD DY PM HH:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS') FROM dual;

-- ���Ĺ��ڿ� �Բ� ����ϰ� ���� ���ڸ� ""�� ���� ������.
-- ���� ���ڰ� �ƴ� ���ڸ� ǥ���ϰ� ������ �ֵ���ǥ�� ������� ��.
SELECT
    first_name,
    TO_CHAR(hire_date, 'YYYY"��" MM"��" DD"��"')
FROM employees;


-- ���ڸ� ���ڷ� TO_CHAR(��, ����)
-- ���Ŀ��� ����ϴ� 9 -> ���� �ڸ����� ǥ���ϴ� ��ȣ
SELECT TO_CHAR(20000, '99999') FROM dual;
--�Ǽ��δ� �ڵ� �ݿø�
SELECT TO_CHAR(20000.29, '99999.9') FROM dual;
-- ���� ���� ���ڵ� �Բ� ǥ�� ����(��=L(SQL Develpoer���� ������ ����(�츰 �ѱ۷� ���������ϱ�))) (�̷� ���ڰ� ���� ���� ���� �Ұ�.)
SELECT TO_CHAR(20000, '$99,999') FROM dual; 
SELECT TO_CHAR(salary, 'L99,999') AS salary FROM employees;
--##### �־��� �ڸ����� �������ڸ� ǥ���� �� ���� �� 
SELECT TO_CHAR(20000, '9999') FROM dual; 



--���ڸ� ���ڷ� TO_NUMBER(��, ����)
SELECT '3300' + 2000 FROM dual; --�ڵ� �� ��ȯ (���� -> ����)
SELECT TO_NUMBER('3300') + 2000 FROM dual; --����� �� ��ȯ
--��, ���ڰ� ������ ���ڷ� �̷���� �ִٸ�, TO_NUMBER�� �θ��� �ʾƵ� �ڵ� ����ȯ.
SELECT '$3,300' + 2000 FROM dual; -- ������ ���ڰ� �ƴϹǷ� �ڵ� ����ȯ �Ұ�
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 FROM dual;


-- ���ڸ� ��¥�� ��ȯ�ϴ� �Լ� TO_DATE(��, ����)
SELECT TO_DATE('2023-04-13') FROM dual;
SELECT sysdate - TO_DATE('2021-03-26') FROM dual; -- ������ ���ؼ� ������ ��¥�������� ��ȯ�ؾ� ��.
SELECT TO_DATE('2020/12/25', 'YY-MM-DD') FROM dual;
SELECT TO_DATE('2021-03-31 12:23:50' , 'YYYY-MM-DD HH:MI:SS') FROM dual;
-- ����� �־��� ���ڿ��� ���¸� ������ ��� �˷���� �Ѵ� 'YYYY-MM-DD'�̷��� ���������� �ȵȴ�!
SELECT TO_CHAR(TO_DATE('23��4��13��','YY"��"MM"��"DD"��"')+10,'YYYY-MM-DD') FROM dual;



SELECT
    TO_DATE('2023-04-13'),
    sysdate - TO_DATE('2023-04-13'),
    TO_DATE('23��4��13��','YY"��"MM"��"DD"��"')
FROM dual;



--NULL �� ���¸� ��ȯ�ϴ� �Լ� NVL(�÷�, ��ȯ��_Ÿ�ٰ�)
-- Ÿ�ٰ��� ���� �÷��� ������Ÿ�Ը� ���� �� ����
SELECT NULL FROM dual;
SELECT NVL(NULL, 0) FROM dual;

SELECT
    first_name,
    NVL(commission_pct, 0) AS comm_pct
FROM employees;

--NULL ��ȯ �Լ� NVL2(�÷�, null�� �ƴ� ����� ��, null�� ����� ��)
SELECT
    NVL2('abc', '�ξƴ�', '����')
FROM dual;

SELECT
    first_name,
    NVL2(commission_pct, TO_CHAR(commission_pct, '0.99') , '���ʽ� ����')
FROM employees;

SELECT
    first_name,
    commission_pct,
    salary,
    NVL2(
        commission_pct,
        salary+(salary*commission_pct),
        salary
    ) AS real_salary
FROM employees;

-- NULL �� ���꿡 ���� ���� �� NULL�� �Ǿ����...
SELECT
    first_name,
    salary,
    salary + (salary * commission_pct)
FROM employees;


--DECODE( �÷�/ǥ����, �׸�1,���1, �׸�2,���2  ........  default��� )
--switch case�� �����.
--default���� ���� ������ null ���� ��
SELECT
    DECODE(
        'B',
        'A', 'A�Դϴ�.',
        'B', 'B�Դϴ�.',
        'C', 'C�Դϴ�.',
        '���� �𸣰����ϴ�;;'
    )
FROM dual;

SELECT
    job_id,
    salary,
    DECODE(
        job_id,
        'IT_PROG', salary*1.1,
        'FI_MGR', salary*1.2,
        'AD_VP', salary*1.3
    ) AS result
FROM employees;


-- CASE WHEN THEN END
-- case ����_Į�� when ����1 then �����, else ����Ʈ END
-- else �� �ۼ����� ������ null ���� ��
SELECT 
    first_name,
    job_id,
    salary,
    (CASE job_id
        WHEN 'IT_PROG' THEN salary*1.1
        WHEN 'FI_MGR' THEN salary*1.2
        WHEN 'AD_VP' THEN salary*1.3
        Else salary
    END) AS result
FROM employees;




/*
���� 1.
�������ڸ� �������� employees���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 17�� �̻���
����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�
*/
SELECT
    employee_id AS �����ȣ,
    CONCAT(first_name, last_name) AS �����,
    hire_date AS �Ի�����,
    TRUNC((sysdate-hire_date)/365) AS �ټӳ��
FROM employees
WHERE (sysdate - hire_date)/365 >= 17
ORDER BY �ټӳ�� DESC;

/*
sql ������� ������ where���� ��Ī�� �θ� �� ������
1. From�� : �ϴ� ���̺��� ���� ��
2. WHERE��: ������ ���� �� -> ���⼭ SELECT���� ���� ��Ī�� ���� ������ ����
3. GROUP-BY��
4. HAVING��
5. SELECT��: ���ǽĿ� ���� �����Ͱ� �ɷ��� �� ���� ������ �÷��� ��ȸ��.
6. ORDER BY��: ��ȸ�� ������ ����/ ��Ī�� ������ �� ���� �����̹Ƿ� ��Ī ��� ����
*/

/*
���� 2.
EMPLOYEES ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
100�̶�� �������, 
120�̶�� �����ӡ�
121�̶�� ���븮��
122��� �����塯
�������� ���ӿ��� ���� ����մϴ�.
���� 1) department_id�� 50�� ������� ������θ� ��ȸ�մϴ�
*/

SELECT
    first_name AS �������,
    manager_id AS �Ŵ������̵�,
    /*
    (CASE manager_id
        WHEN 100 THEN '���'
        WHEN 120 THEN '����'
        WHEN 121 THEN '�븮'
        WHEN 122 THEN '����'
        ELSE '�ӿ�'
    END)AS ����
    */
    DECODE(manager_id,
        100, '���',
        120, '����',
        121, '�븮',
        122, '����',
        '�ӿ�'
    ) AS ����
FROM employees
WHERE department_id = 50;



