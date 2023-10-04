
SET SERVEROUTPUT ON;
--IF��

DECLARE
    v_num1 NUMBER := 10;
    v_num2 NUMBER := 15;
BEGIN
    IF
        v_num1 > v_num2
    THEN
        dbms_output.put_line(v_num1 || '��(��) ū ��');
    ELSE
        dbms_output.put_line(v_num2 || '��(��) ū ��');
    END IF;
END;

--ELSIF
--���� ���� �Լ� -> DBMS_RANDOM.VALUE(���۹���,������(�̸�))
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    v_department_id := ROUND(dbms_RANDOM.VALUE(10,114),-1);
    
    SELECT
        salary
    INTO
        v_salary
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; --ù��° ���� ���ؼ� ������ ������ ����
    
    DBMS_OUTPUT.put_line('��ȸ�� �޿�: ' || v_salary);
    
    IF
        v_salary <= 5000
    THEN
        DBMS_OUTPUT.put_line('�޿��� �� ����');
    ELSIF
        v_salary <= 9000
    THEN
        DBMS_OUTPUT.PUT_LINE('�޿��� �߰���');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�޿��� ����');
    END IF;

END;

--CASE��
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    v_department_id := ROUND(dbms_RANDOM.VALUE(10,120),-1);
    SELECT
        salary
    INTO
        v_salary
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; --ù��° ���� ���ؼ� ������ ������ ����
    
    DBMS_OUTPUT.put_line('��ȸ�� �޿�: ' || v_salary);
    
    CASE
        WHEN v_salary <= 5000 THEN
            DBMS_OUTPUT.PUT_LINE('�޿��� �� ����');
        WHEN v_salary <= 9000 THEN
            DBMS_OUTPUT.PUT_LINE('�޿��� �߰���');
        ELSE
            DBMS_OUTPUT.PUT_LINE('�޿��� ����');
        END CASE;
END;



--��ø if��
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
    v_commission NUMBER := 0;
    v_name VARCHAR(50);
BEGIN
    v_department_id := ROUND(dbms_RANDOM.VALUE(10,120),-1);
    SELECT
        salary, commission_pct, first_name
    INTO
        v_salary, v_commission, v_name
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1;
    
    IF v_commission > 0 THEN 
        IF v_commission > 0.15 THEN
            DBMS_OUTPUT.PUT_LINE('Ŀ�̼��� 0.15 �̻���');
            DBMS_OUTPUT.PUT_LINE(v_salary * v_commission);
            DBMS_OUTPUT.put_line(v_name);
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ŀ�̼��� 0.15 ������');
        DBMS_OUTPUT.PUT_LINE(v_name);
    END IF;
END;



