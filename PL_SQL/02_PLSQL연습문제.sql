-- 1. employees ���̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ�
-- �͸����� ����� ����. (������ ��Ƽ� ����ϼ���.)

DECLARE
    v_emp_name VARCHAR2(50);
    v_emp_email employees.email%TYPE;
    
BEGIN
    SELECT
        first_name || ' ' || last_name AS name,
        email
    INTO
        v_emp_name, v_emp_email
    FROM employees
    WHERE employee_id = 201;
    
    DBMS_OUTPUT.put_line(v_emp_name || ' - ' || v_emp_email);
END;


-- 2. employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX �Լ� ���)
-- �� ��ȣ + 1������ �Ʒ��� ����� emps ���̺�
-- employee_id, last_name, email, hire_date, job_id�� �ű� �����ϴ� �͸� ����� ���弼��.
-- SELECT�� ���Ŀ� INSERT�� ����� �����մϴ�.
/*
<�����>: steven
<�̸���>: stevenjobs
<�Ի�����>: ���ó�¥
<JOB_ID>: CEO
*/

DECLARE
    v_max_empid employees.employee_id%TYPE;
BEGIN
    SELECT
        MAX(employee_id)
    INTO
        v_max_empid
    FROM employees;
    
    INSERT INTO emps (employee_id, last_name, email, hire_date, job_id)
    VALUES (v_max_empid+1, 'steven', 'stevenjobs', sysdate, 'CEO');
END;
