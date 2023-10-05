/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
*/

CREATE OR REPLACE PROCEDURE divisor_proc (v_num IN NUMBER)
IS
    v_cnt NUMBER := 0;
BEGIN
    FOR i IN 1..v_num
    LOOP
        IF MOD(v_num,i) = 0 THEN
            v_cnt := v_cnt + 1;
        END IF;
    END LOOP;
    dbms_output.put_line('����� ����: '|| v_cnt);
END;

EXEC divisor_proc(10);


/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/

CREATE OR REPlACE PROCEDURE depts_proc
    (p_department_id IN depts.department_id%TYPE,
     p_department_name IN depts.department_name%TYPE,
     p_flag IN VARCHAR2
    )  
IS
    v_cnt NUMBER := 0;
BEGIN
    
    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_department_id;
    
    IF p_flag = 'I' THEN
        INSERT INTO depts (department_id, department_name)
        VALUES (p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN
        UPDATE depts SET department_name = p_department_name
        WHERE department_id = p_department_id;
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
            RETURN;
        END IF;
        DELETE FROM depts
        WHERE department_id = p_department_id;
    ELSE
        dbms_output.put_line('flag�� ��Ȯ�� �Է����ּ��� [ I / U / D ]');
    END IF;
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN 
        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
        dbms_output.put_line('�����޼���: '||SQLERRM);
        ROLLBACK;
    
END;




DROP PROCEDURE depts_proc;
SELECT * FROM depts;

EXEC depts_proc(310, '������', 'U');

EXEC depts_proc(300, 'NEW NAME', 'I');

/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/
--���� ���� (EXCEPTION �߻����� �ʰ� �׳� SELECT �ι� ����)
CREATE OR REPlACE PROCEDURE calc_working_days
    (p_emp_id IN employees.employee_id%TYPE,
     p_w_year OUT NUMBER)
IS
    v_cnt NUMBER := 0;
    v_h_date DATE;
BEGIN
    SELECT COUNT(*)
    INTO v_cnt
    FROM employees
    WHERE employee_id = p_emp_id;
    
    IF v_cnt = 0 THEN
        dbms_output.put_line('�������� �ʴ� �����ȣ�Դϴ�.');
        RETURN;
    END IF;
    
    SELECT hire_date
    INTO v_h_date
    FROM employees
    WHERE employee_id = p_emp_id;
    
    p_w_year := TRUNC((sysdate - v_h_date)/365);
END;

--�������� �� �ڵ�
CREATE OR REPLACE PROCEDURE emp_hire_proc
    (p_employee_id IN employees.employee_id%TYPE,
     p_year OUT NUMBER)
IS
    v_hire_date employees.hire_date%TYPE;
BEGIN
    SELECT
        hire_date
    INTO
        v_hire_date
    FROM employees
    WHERE employee_id = p_employee_id;
    
    p_year := TRUNC((sysdate - v_hire_date) / 365);
    
    -- ���� �������� �ʴ� �����ȣ���, ��ȸ�Ǵ� �����ȣ�� �ϳ��� ���� �ٵ�,
    -- ���� ���� INTO�� �ְڴ� �ϴ� NO DATA FOUND ���� �߻�!! (NULL �� �ִ´� ���� ��Ҹ� ��������)
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(p_employee_id || '��(��) ���� ������ �Դϴ�.');
END;

DECLARE
    v_w_years NUMBER;
BEGIN
    calc_working_days(106, v_w_years);
    IF v_w_years IS NOT NULL THEN
        dbms_output.put_line(v_w_years||'�� ���� �ٹ�');
    END IF;
END;

DECLARE
    v_w_years NUMBER;
BEGIN
    emp_hire_proc(50, v_w_years);
    IF v_w_years IS NOT NULL THEN
        dbms_output.put_line(v_w_years||'�� ���� �ٹ�');
    END IF;
END;

/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
*/

CREATE TABLE emps AS ( SELECT * FROM employees );


CREATE OR REPLACE PROCEDURE  new_emp_proc
    (p_emp_id IN emps.employee_id%TYPE,
     p_emp_lName IN emps.last_name%TYPE,
     p_emp_email IN ems.email%TYPE,
     p_emp_hDate IN ems.hire_date%TYPE,
     p_emp_jId IN emps.job_id%TYPE
    )
IS
BEGIN
    MERGE INTO emps a
        USING ( SELECT p_emp_id AS employee_id FROM dual ) b
        ON (a.employee_id = b.employee_id)
    WHEN MATCHED THEN
        UPDATE SET
            a.last_name = p_emp_lName,
            a.email = p_emp_email,
            a.hire_date = p_emp_hDate,
            a.job_id = p_emp_jId
    WHEN NOT MATCHED THEN
        INSERT (a.employee_id, a.last_name, a.email, a.hire_date, a.job_id)
        VALUES(p_emp_id, p_emp_lName, p_emp_email, p_emp_hDate, p_emp_jId);
END;


EXEC new_emp_proc(300, 'testName', 'email', sysdate, 'AAAAA');
SELECT * FROM emps;

