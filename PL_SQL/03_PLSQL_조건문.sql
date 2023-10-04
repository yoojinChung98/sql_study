
SET SERVEROUTPUT ON;
--IF문

DECLARE
    v_num1 NUMBER := 10;
    v_num2 NUMBER := 15;
BEGIN
    IF
        v_num1 > v_num2
    THEN
        dbms_output.put_line(v_num1 || '이(가) 큰 수');
    ELSE
        dbms_output.put_line(v_num2 || '이(가) 큰 수');
    END IF;
END;

--ELSIF
--난수 생성 함수 -> DBMS_RANDOM.VALUE(시작범위,끝범위(미만))
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
    AND ROWNUM = 1; --첫번째 값만 구해서 변수에 저장할 예정
    
    DBMS_OUTPUT.put_line('조회된 급여: ' || v_salary);
    
    IF
        v_salary <= 5000
    THEN
        DBMS_OUTPUT.put_line('급여가 좀 낮음');
    ELSIF
        v_salary <= 9000
    THEN
        DBMS_OUTPUT.PUT_LINE('급여가 중간임');
    ELSE
        DBMS_OUTPUT.PUT_LINE('급여가 높음');
    END IF;

END;

--CASE문
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
    AND ROWNUM = 1; --첫번째 값만 구해서 변수에 저장할 예정
    
    DBMS_OUTPUT.put_line('조회된 급여: ' || v_salary);
    
    CASE
        WHEN v_salary <= 5000 THEN
            DBMS_OUTPUT.PUT_LINE('급여가 좀 낮음');
        WHEN v_salary <= 9000 THEN
            DBMS_OUTPUT.PUT_LINE('급여가 중간임');
        ELSE
            DBMS_OUTPUT.PUT_LINE('급여가 높음');
        END CASE;
END;



--중첩 if문
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
            DBMS_OUTPUT.PUT_LINE('커미션이 0.15 이상임');
            DBMS_OUTPUT.PUT_LINE(v_salary * v_commission);
            DBMS_OUTPUT.put_line(v_name);
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('커미션이 0.15 이하임');
        DBMS_OUTPUT.PUT_LINE(v_name);
    END IF;
END;



