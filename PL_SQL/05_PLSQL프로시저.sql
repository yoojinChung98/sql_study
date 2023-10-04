-- ���ν���(procedure) -> void �޼��� ����
-- Ư���� ������ ó���ϰ� ������� ��ȯ���� �ʴ� �ڵ� ��� (����)
-- ������ ���ν����� ���ؼ� ���� �����ϴ� ����� �ֽ��ϴ�.

--���ν��� ���� ���
CREATE PROCEDURE ���ν���_�̸� (�Ű������� IN ������Ÿ��)
IS -- �����
BEGIN --�����
END; --�����
--���ν����� �����ϰ� �ҷ��� �̿��ϴ� �����̹Ƿ� CREATE �� ����Ѵ�!
CREATE PROCEDURE guguproc
    (p_dan IN NUMBER)
IS --������ ���� ��� ���� �Ұ���.
BEGIN
    DBMS_OUTPUT.PUT_LINE(p_dan || '��');
    FOR i IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(p_dan || ' x ' || i || ' = ' || p_dan*i);
    END LOOP;
END;


--���ν��� ��� ��� EXEC
-- IS, BEGIN, END ������� �����
-- EXEC ���ν���_�̸�(�Ű�����);
-- �͸��� ���ο��� �׳� �θ��� �� (EXEC ������ ����)
EXEC guguproc(5);
EXEC guguproc(14);

--�Ű���(�μ�)�� ���� ���ν���
CREATE PROCEDURE p_test
IS -- �����
    v_msg VARCHAR2(30) := 'Hello Procedure!';
BEGIN --�����
    DBMS_OUTPUT.put_LINE(v_msg);
END; --�����

EXEC p_test;


-- IN �Է°��� ���� �� ���޹޴� ���ν���
CREATE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE
    )
IS
BEGIN
    INSERT INTO jobs
    VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    COMMIT;
END;

EXEC my_new_job_proc('JOB4', 'test job4', 8000, 10000);

SELECT * FROM jobs;


--������ ���ν��� �����ϱ�
--job_id(PK)�� �̹� �����ϸ� update, ������ insert�� �ϵ��� ����.
CREATE OR REPLACE PROCEDURE my_new_job_proc --�̹� �����ϴ� �޼����̹Ƿ� ���� ���ν��� ������ ������ ��.
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE
    )
IS
    v_cnt NUMBER := 0;
BEGIN

    -- ������ job_id�� �ִ��� Ȯ���Ͽ�, �̹� �����Ѵٸ� 1, �������� �ʴ´ٸ� 0 v_cnt����.
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN --��ȸ ����� ���ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE --��ȸ ����� �ִٸ� UPDATE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal;
    END IF;
    
    COMMIT;
END;


--�Ű���(�μ�)�� ����Ʈ��(�⺻��) ����
--������ �Ű������� ���޵��� ���� ��, �⺻ ��(�ʱⰪ)���� �����ϴ� ���
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE := 0,
     p_max_sal IN jobs.max_salary%TYPE := 1000
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN 
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE 
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal;
    END IF;
    COMMIT;
END;


EXEC my_new_job_proc('JOB5', 'test job5');
SELECT * FROM jobs;


---------------------------------------------------

-- OUT, IN OUT �Ű����� ���
-- OUT ������ ����ϸ� ���ν��� �ٱ������� ���� �����ϴ�.
-- OUT�� �̿��ؼ� ���� ���� �ٱ� �͸� ��Ͽ��� �����ؾ� �մϴ�.
-- �ֳ���� OUT�� ���� �������� ������ �����ؾ� �ϱ� ������!!
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE := 0,
     p_max_sal IN jobs.max_salary%TYPE := 1000,
     p_result OUT VARCHAR2 -- �ٱ��ʿ��� ���(��ȯ)�� �ϱ� ���� ����(�Է� �޴� ���� �ƴ�)
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100):= '�������� �ʴ� ���̹Ƿ� INSERT �Ǿ����ϴ�.';
BEGIN
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN 
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- ������ �����ϴ� �����Ͷ�� ��ȸ�� ����� ���� 
        SELECT
            p_job_id || '�� �ִ� ����: ' || p_max_sal || ', �ּ� ����: ' || p_min_sal
        INTO
            v_result --��ȸ ����� ������ ����
        FROM jobs
        WHERE job_id = p_job_id;
    END IF;
    
    --OUT �Ű������� ��ȸ ����� �Ҵ�
    p_result := v_result;
    
    COMMIT;
END;


--OUT �� ���� ���� �Ű����� �������־�� ��.
DECLARE
    msg VARCHAR2(100);
BEGIN
    my_new_job_proc('JOB2', 'test_job2', 2000, 8000, msg);
    DBMS_OUTPUT.PUT_LINE(msg);
    
    my_new_job_proc('CEO', 'test_ceo', 2000, 8000, msg); -- INSERT �Ǵ� ��� msg�� ���� ����
    DBMS_OUTPUT.PUT_LINE(msg);
END;


SELECT * FROM jobs;

---------------------------------------------------------

-- IN, OUT ���ÿ� ó��
CREATE OR REPLACE PROCEDURE my_parameter_test_proc
    (
    p_var1 IN VARCHAR2,
    p_var2 OUT VARCHAR2,
    p_var3 IN OUT VARCHAR2
    )
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('p_var1�� ����: ' || p_var1); --IN: �翬�� ��µ�
    DBMS_OUTPUT.PUT_LINE('p_var2�� ����: ' || p_var2); --OUT: ���� ���޵��� �ʾ� ��¾ȵ�.
    DBMS_OUTPUT.PUT_LINE('p_var3�� ����: ' || p_var3); --IN OUT: IN�� ������ ������ ����(��µ�)
    
    --p_var1 := '���1';
    p_var2 := '���2';
    p_var3 := '���3';
END;



DECLARE
    v_var1 VARCHAR(10) := 'value1';
    v_var2 VARCHAR(10) := 'value2';
    v_var3 VARCHAR(10) := 'value3';
BEGIN
    my_parameter_test_proc(v_var1, v_var2, v_var3);
    
    dbms_output.put_line('v_var1: ' || v_var1);
    dbms_output.put_line('v_var2: ' || v_var2);
    dbms_output.put_line('v_var3: ' || v_var3);
END;

--IN �Ű������� �ƿ� �� �Ҵ� ��ü�� �Ұ���. 
--OUT ������ ���� ���ν��� ���ο��� ������� ���ϰ� �ܺη� ��ȯ�� ����!

--IN���� : ��ȯ �Ұ�, �޴� �뵵�θ� Ȱ��
--OUT���� : ���� �޾Ƽ� ���ν��� ���ο��� Ȱ�� �Ұ�, ��ȯ�ϴ� �뵵�θ� Ȱ��
            --(OUT ������ �Ҵ�(����)�� PROCEDURE �� ���� �� �̷����� ����(CREATE �������� ����Ʈ�� �Ҵ絵 ������))
--IN OUT ����: IN �� OUT ��� ����


----------------------------------


--RETURN (���ν��� ���� ����/ �� ��ȯ �ƴ�)


CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_result OUT VARCHAR2 
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '�������� �ʴ� ���̶� INSERT ó�� �Ǿ����ϴ�.';
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN 
        dbms_output.put_line(p_job_id || '�� ���̺� �������� �ʽ��ϴ�.');
        RETURN;
    END IF;

    SELECT p_job_id || '�� �ִ� ����: ' || max_salary || ', �ּ� ����: ' || min_salary
    INTO v_result 
    FROM jobs
    WHERE job_id = p_job_id;

    p_result := v_result;
    COMMIT;
END;
 

DECLARE
    msg VARCHAR(100);
BEGIN
    my_new_job_proc('merong', msg);
    dbms_output.put_line(msg);
END;


----------------------------------------------

/*
OTHERS �ڸ��� ������ Ÿ���� �ۼ��� �ݴϴ�.(�ڹ��� EXCEPTION ��� ���ܸ� �� ����)

ACCESS_INTO_NULL -> ��ü �ʱ�ȭ�� �Ǿ� ���� ���� ���¿��� ���.
NO_DATA_FOUND -> SELECT INTO �� �����Ͱ� �� �ǵ� ���� ��
ZERO_DIVIDE -> 0���� ���� ��
VALUE_ERROR -> ��ġ �Ǵ� �� ����
INVALID_NUMBER -> ���ڸ� ���ڷ� ��ȯ�� �� ������ ���
*/

--���� ó�� (���ν����� ������ �߻����� ��, �������ᰡ �Ǵ� ���� �ƴ� �ڵ带 ��ȸ ��Ű��)
-- EXCEPTION WHEN ����Ÿ�� THEN ���๮1;
--SQLCODE : �����ڵ� ���
--SQLERRM : ���� �޼��� ���
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num := 10 / 0;
    
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            dbms_output.put_line('0 ���δ� ���� �� �����ϴ�');
            dbms_output.put_line('SQL ERROR CODE: '|| SQLCODE);
            dbms_output.put_line('SQL ERROR MSG: '|| SQLERRM);
        WHEN OTHERS THEN
            dbms_output.put_line('�� �� ���� ���� �߻�!');
            --WHEN���� �����ϴ� ���ܰ� �ƴ� �ٸ� ���ܰ� �߻� �� OTHERS ����.
    
END;










