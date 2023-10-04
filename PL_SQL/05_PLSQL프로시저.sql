-- 프로시저(procedure) -> void 메서드 유사
-- 특정한 로직을 처리하고 결과값을 반환하지 않는 코드 덩어리 (쿼리)
-- 하지만 프로시저를 통해서 값을 리턴하는 방법도 있습니다.

--프로시저 생성 방법
CREATE PROCEDURE 프로시저_이름 (매개변수명 IN 데이터타입)
IS -- 선언부
BEGIN --실행부
END; --종료부
--프로시저는 생성하고 불러서 이용하는 개념이므로 CREATE 를 사용한다!
CREATE PROCEDURE guguproc
    (p_dan IN NUMBER)
IS --선언할 것이 없어도 생략 불가능.
BEGIN
    DBMS_OUTPUT.PUT_LINE(p_dan || '단');
    FOR i IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(p_dan || ' x ' || i || ' = ' || p_dan*i);
    END LOOP;
END;


--프로시저 사용 방법 EXEC
-- IS, BEGIN, END 순서대로 시행됨
-- EXEC 프로시저_이름(매개변수);
-- 익명블록 내부에선 그냥 부르면 됨 (EXEC 붙이지 않음)
EXEC guguproc(5);
EXEC guguproc(14);

--매개값(인수)이 없은 프로시저
CREATE PROCEDURE p_test
IS -- 선언부
    v_msg VARCHAR2(30) := 'Hello Procedure!';
BEGIN --실행부
    DBMS_OUTPUT.put_LINE(v_msg);
END; --종료부

EXEC p_test;


-- IN 입력값을 여러 개 전달받는 프로시저
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


--기존의 프로시저 개량하기
--job_id(PK)가 이미 존재하면 update, 없으면 insert를 하도록 개량.
CREATE OR REPLACE PROCEDURE my_new_job_proc --이미 존재하는 메서드이므로 기존 프로시저 구조가 수정될 것.
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE
    )
IS
    v_cnt NUMBER := 0;
BEGIN

    -- 동일한 job_id가 있는지 확인하여, 이미 존재한다면 1, 존재하지 않는다면 0 v_cnt대입.
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN --조회 결과가 없다면 INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE --조회 결과가 있다면 UPDATE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal;
    END IF;
    
    COMMIT;
END;


--매개값(인수)의 디폴트값(기본값) 설정
--지정한 매개변수가 전달되지 않을 때, 기본 값(초기값)으로 설정하는 방법
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

-- OUT, IN OUT 매개변수 사용
-- OUT 변수를 사용하면 프로시저 바깥쪽으로 값을 보냅니다.
-- OUT을 이용해서 보낸 값을 바깥 익명 블록에서 실행해야 합니다.
-- 왜냐햐면 OUT된 값을 돌려받을 변수를 선언해야 하기 때문에!!
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE := 0,
     p_max_sal IN jobs.max_salary%TYPE := 1000,
     p_result OUT VARCHAR2 -- 바깥쪽에서 출력(반환)을 하기 위한 변수(입력 받는 값이 아님)
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100):= '존재하지 않는 값이므로 INSERT 되었습니다.';
BEGIN
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN 
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- 기존에 존재하는 데이터라면 조회된 결과를 추출 
        SELECT
            p_job_id || '의 최대 연봉: ' || p_max_sal || ', 최소 연봉: ' || p_min_sal
        INTO
            v_result --조회 결과를 변수에 대입
        FROM jobs
        WHERE job_id = p_job_id;
    END IF;
    
    --OUT 매개변수에 조회 결과를 할당
    p_result := v_result;
    
    COMMIT;
END;


--OUT 될 값을 담을 매개변수 지정해주어야 함.
DECLARE
    msg VARCHAR2(100);
BEGIN
    my_new_job_proc('JOB2', 'test_job2', 2000, 8000, msg);
    DBMS_OUTPUT.PUT_LINE(msg);
    
    my_new_job_proc('CEO', 'test_ceo', 2000, 8000, msg); -- INSERT 되는 경우 msg가 오지 않음
    DBMS_OUTPUT.PUT_LINE(msg);
END;


SELECT * FROM jobs;

---------------------------------------------------------

-- IN, OUT 동시에 처리
CREATE OR REPLACE PROCEDURE my_parameter_test_proc
    (
    p_var1 IN VARCHAR2,
    p_var2 OUT VARCHAR2,
    p_var3 IN OUT VARCHAR2
    )
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('p_var1의 값은: ' || p_var1); --IN: 당연히 출력됨
    DBMS_OUTPUT.PUT_LINE('p_var2의 값은: ' || p_var2); --OUT: 값이 전달되지 않아 출력안됨.
    DBMS_OUTPUT.PUT_LINE('p_var3의 값은: ' || p_var3); --IN OUT: IN의 성질을 가지고 있음(출력됨)
    
    --p_var1 := '결과1';
    p_var2 := '결과2';
    p_var3 := '결과3';
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

--IN 매개변수는 아예 값 할당 자체가 불가능. 
--OUT 변수는 값을 프로시저 내부에서 사용하지 못하고 외부로 반환만 가능!

--IN변수 : 반환 불가, 받는 용도로만 활용
--OUT변수 : 값을 받아서 프로시저 내부에서 활용 불가, 반환하는 용도로만 활용
            --(OUT 변수의 할당(대입)은 PROCEDURE 가 끝날 때 이뤄지기 때문(CREATE 문에서의 디폴트값 할당도 포함임))
--IN OUT 변수: IN 과 OUT 모두 가능


----------------------------------


--RETURN (프로시저 강제 종료/ 값 반환 아님)


CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_result OUT VARCHAR2 
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '존재하지 않는 값이라 INSERT 처리 되었습니다.';
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN 
        dbms_output.put_line(p_job_id || '는 테이블에 존재하지 않습니다.');
        RETURN;
    END IF;

    SELECT p_job_id || '의 최대 연봉: ' || max_salary || ', 최소 연봉: ' || min_salary
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
OTHERS 자리에 예외의 타입을 작성해 줍니다.(자바의 EXCEPTION 모든 예외를 다 받음)

ACCESS_INTO_NULL -> 객체 초기화가 되어 있지 않은 상태에서 사용.
NO_DATA_FOUND -> SELECT INTO 시 데이터가 한 건도 없을 때
ZERO_DIVIDE -> 0으로 나눌 때
VALUE_ERROR -> 수치 또는 값 오류
INVALID_NUMBER -> 문자를 숫자로 변환할 때 실패한 경우
*/

--예외 처리 (프로시저에 에러가 발생했을 때, 강제종료가 되는 것이 아닌 코드를 우회 시키기)
-- EXCEPTION WHEN 에러타입 THEN 수행문1;
--SQLCODE : 에러코드 출력
--SQLERRM : 에러 메세지 출력
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num := 10 / 0;
    
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            dbms_output.put_line('0 으로는 나눌 수 없습니다');
            dbms_output.put_line('SQL ERROR CODE: '|| SQLCODE);
            dbms_output.put_line('SQL ERROR MSG: '|| SQLERRM);
        WHEN OTHERS THEN
            dbms_output.put_line('알 수 없는 예외 발생!');
            --WHEN으로 설정하느 예외가 아닌 다른 예외가 발생 시 OTHERS 실행.
    
END;










