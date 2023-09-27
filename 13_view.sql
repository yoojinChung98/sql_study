/*
view는 제한적인 자료만 보기 위해 사용하는 가상 테이블의 개념입니다.
뷰는 기본 테이블로 유도된 가상 테이블이기 때문에
필요한 컬럼만 저장해 두면 관리가 용이해 집니다.
뷰는 가상테이블로 실제 데이터가 물리적으로 저장된 형태(커밋만 제대로 진행되었다면 하드디스크에 물리적으로 저장되는 형태)는 아닙니다.
뷰는 객체형태로만 존재하는 것. 물리적인 파일 형태로 저장되는 것은 아님. 테이블이랑은 다르다는 말씀!!!
뷰를 통해서 데이터에 접근하면 원본 데이터는 안전하게 보호될 수 있습니다.
참고로 읽기전용으로 돌리지 않은 view에 삽입, 수정, 삭제 시 원본 테이블에도 반영된다!!!(주의!)


-외부에 공개하고 싶지 않은 커럼들은 거른 뒤 사용자에게 보여주고 싶을 때.
- 조인하기 귀찮을 때, 조인된 결과 자체를 가상 테이블로 만들어서 이용.

-테이블은 물리적으로 실제로 저장되는 것
-뷰는 가상 
-따라서 수정이 간편하고,
- 공개하고 싶지 않은 정보는 거르고 만들 수 있음 (테이블은 접근 권한을 지정해야하는데...)
- 뷰는 insert, update, delte 등이 제한적이고, 아예 뷰읭 ㅗㅂ션으로 읽기 전용으로 만들 수 있ㅇ므...
*/

-- 뷰를 생성할 수 있는 권한 확인 (CREATE VIEW)
SELECT * FROM user_sys_privs;

--뷰의 종류: 단순 뷰, 복합 뷰

--단순 뷰: 하나의 테이블을 이용하여 생성한 뷰
SELECT
    employee_id,
    first_name || ' ' || last_name,
    job_id,
    salary
FROM employees
WHERE department_id = 60;

--뷰의 컬러 이름으로 함수 호출문, 연산식 등과 같은 가상 표현식은 올 수 없음.
CREATE VIEW view_emp AS (
    SELECT
        employee_id,
        first_name || ' ' || last_name AS name,
        job_id,
        salary
    FROM employees
    WHERE department_id = 60
);
-- 컬럼끼리 합쳐져 새로 생성되는 컬럼의 경우 별칭을 꼭 설정해주어야 함


SELECT * FROM view_emp
WHERE salary >= 6000;

--복합 뷰: 여러 개의 테이블을 조인하여 생성한 뷰
-- 자주 사용되는 조인 결과일 경우, 미리 조인하여 필요한 데이터만 저장하고 빠른 확인을 위해 사용함
CREATE VIEW view_emp_dept_jobs AS (
    SELECT
        e.employee_id,
        first_name || ' ' || last_name AS name,
        d.department_name,
        j.job_title
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;

-- 뷰의 수정 (CREATE OR REPLACE VIEW 구문)
-- 해당 구문을 사용하면 동일 이름의 뷰가 있으면 생성, 없으면 데이터가 변경되면서 새롭게 생성됩니다
-- 그래서 애초에 view를 만들 때 create or repalce view 구문으로 생성함!
CREATE OR REPLACE VIEW view_emp_dept_jobs AS (
    SELECT
        e.employee_id,
        first_name || ' ' || last_name AS name,
        d.department_name,
        j.job_title,
        e.salary
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT
    job_title,
    AVG(salary) AS avg
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY avg DESC;

-- 뷰 삭제
DROP VIEW view_emp;


/*
VIEW 에 INSERT가 일어나는 경우 '실제 테이블에도 반영'이 됩니다!!!(따라서 VIEW 생성 시 읽기전용으로 제한하는 경우가 많음)
그래서 VIEW 의 INSERT, UPDATE, DELETE는 많은 제약 사항이 따름.
원본 테이블이 NOT NULL 인 경우, VIEW에 INSERT, UPDATE, DELETE가 불가능함
VIEW에서 사용하는 컬럼이 가상열인 경우에도 INSERT, UPDATE, DELETE  불가능 (원본에 존재하는 컬럼이 아니므로).
*/
INSERT INTO view_emp_dept_jobs
VALUES(300, 'test', 'test', 'test', 10000); --컴파일에러
--두번째 컬럼 'name'은 가상열(virtual column)이기 때문에 INSERT 불가

INSERT INTO view_emp_dept_jobs (employee_id, department_name, job_title, salary)
VALUES(300, 'test', 'test', 10000); --컴파일에러
--복합 뷰의 경우, 한 번에 수정할 수 없음 (다양한 테이블을 참조하는데, 각 테이블마다 제약조건이 다르므로 복잡해서 불가)

INSERT INTO view_emp (employee_id, job_id, salary)
VALUES (300, 'test', 10000); --컴파일에러
--원본 테이블의 NOT NULL이 컬럼엔 뭘 넣을 건데...? 넣을 수 있는 방법이 아예 없음.
-- 원본 테이블에 NULL을 허용하지 않는 컬럼의 존재로 인해 불가능.

DELETE FROM view_emp
WHERE employee_id = 103;
--103을 참조하는 외래테이블이 있어서 불가능(뷰 때문은 아님ㅋㅋ)

--삽입, 수정, 삭제 성공 시 원본 테이블에도 반영됩니다.
DELETE FROM view_emp
WHERE employee_id = 107;
SELECT * FROM view_emp;
SELECT * FROM employees;

ROLLBACK;

----------------뷰의 옵션---------------

--WITH CHECK OPTION -> 조건 제약 컬럼
-- 뷰를 생성할 때 조건으로 사용한 컬럼은 뷰를 통해서 변경할 수 없게 해주는 키워드
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
--WITH CHECK OPTION;
WITH CHECK OPTION CONSTRAINT view_emp_test_ck;

UPDATE view_emp_test SET department_id = 100
WHERE employee_id = 107;
-- WITH CHECK OPTION 으로 인해 조건컬럼(department_id)는 변경(update)할 수 없음.

SELECT * FROM view_emp_test;
ROLLBACK;




-- 읽기 전용 뷰
--WITH READ ONLY : DML 모든 연산을 막음 (= SELECT만 허용)
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
WITH READ ONLY;


UPDATE view_emp_test SET job_id = 'AD_VP'
WHERE employee_id = 107;
-- WITH READ ONLY 로 인해 DML 연산은 할 수 없음. (cannot perform a DML operation on a read-only view)


