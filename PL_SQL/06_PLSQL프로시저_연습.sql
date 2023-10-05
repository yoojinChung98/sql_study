/*
프로시저명 divisor_proc
숫자 하나를 전달받아 해당 값의 약수의 개수를 출력하는 프로시저를 선언합니다.
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
    dbms_output.put_line('약수의 갯수: '|| v_cnt);
END;

EXEC divisor_proc(10);


/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
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
            dbms_output.put_line('삭제하고자 하는 부서가 존재하지 않습니다.');
            RETURN;
        END IF;
        DELETE FROM depts
        WHERE department_id = p_department_id;
    ELSE
        dbms_output.put_line('flag를 정확히 입력해주세요 [ I / U / D ]');
    END IF;
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN 
        dbms_output.put_line('예외가 발생했습니다.');
        dbms_output.put_line('에러메세지: '||SQLERRM);
        ROLLBACK;
    
END;




DROP PROCEDURE depts_proc;
SELECT * FROM depts;

EXEC depts_proc(310, '영업부', 'U');

EXEC depts_proc(300, 'NEW NAME', 'I');

/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/
--내가 쓴거 (EXCEPTION 발생하지 않게 그냥 SELECT 두번 떄림)
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
        dbms_output.put_line('존재하지 않는 사원번호입니다.');
        RETURN;
    END IF;
    
    SELECT hire_date
    INTO v_h_date
    FROM employees
    WHERE employee_id = p_emp_id;
    
    p_w_year := TRUNC((sysdate - v_h_date)/365);
END;

--선생님이 쓴 코드
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
    
    -- 만약 존재하지 않는 사원번호라면, 조회되는 사원번호가 하나도 없을 텐데,
    -- 없는 것을 INTO로 넣겠다 하니 NO DATA FOUND 에러 발생!! (NULL 을 넣는다 같은 헛소리 하지말고)
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(p_employee_id || '은(는) 없는 데이터 입니다.');
END;

DECLARE
    v_w_years NUMBER;
BEGIN
    calc_working_days(106, v_w_years);
    IF v_w_years IS NOT NULL THEN
        dbms_output.put_line(v_w_years||'년 연속 근무');
    END IF;
END;

DECLARE
    v_w_years NUMBER;
BEGIN
    emp_hire_proc(50, v_w_years);
    IF v_w_years IS NOT NULL THEN
        dbms_output.put_line(v_w_years||'년 연속 근무');
    END IF;
END;

/*
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요

머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
프로시저가 전달받아야 할 값: 사번, last_name, email, hire_date, job_id
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

