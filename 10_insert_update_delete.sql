
-- insert
-- 테이블 구조 확인 (DESC: ORDER BY 에선 descending / 단독으로 사용되면 describe )
DESC departments;

-- insert의 첫번째 방법
--1. 모든 컬럼 데이터를 한 번에 지정 (순서에 맞춰 모든 값을 넣어야 함)
--INSERT INTO 테이블명 VALUES(넣을 값1, 넣을 값2, ..., 넣을 값n);
INSERT INTO departments
VALUES(300, '개발부', null, null);

--2. 직접 컬럼을 지정하고 저장하는 것. (NOT NULL 반드시 확인할 것!)
-- 원하는 컬럼만 저장할 수 있음 
--INSERT INTO departments (컬럼1, 컬럼3, 컬럼n) VALUES (값1, 값3, 값n)
INSERT INTO departments
    (department_id, department_name, location_id)
VALUES
    (300, '총무부', 1700);


INSERT INTO departments
    (department_id, location_id)
VALUES
    (300,  1700);
--오류 보고 -
--ORA-01400: cannot insert NULL into ("HR"."DEPARTMENTS"."DEPARTMENT_NAME")
-- 해당 컬럼은 NULL을 허용하지 않기 때문에 해당 컬럼을 지정하지 않고는 INSERT를 할 수


--3. 서브쿼리 INSERT
-- 해당 테이블이 이 서브쿼리문의 결과를 삽입하겠다는 의미.
-- INSERT INTO 테이블명 
INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE department_id = 50);






--사본 테이블 생성 (CTAS)
CREATE TABLE emps AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees);

--데이터 없이 구조만 사본으로 만들고 싶은 경우
CREATE TABLE emps AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2);
--WHERE 1=2 는 false 값을 주기 위한 상징적인 의미.(오라클에는 boolean형이 없으므로, false의 의미를 주고 싶을 때 
--이렇게 상징적인 의미들을 사용함)

--사본 테이블 생성 시 그냥 생성하면 조회된 데이터까지 모두 복사됨
-- WHERE 절에 false 값(1=2)을 지정하면 테이블의 구조만 복사되고 데이터는 복사 X

--사본테이블은 제약조건까지 복사되지는 않음.
---------------------------------------------------------

--UPDATE
--UPDATE 테이블명 SET 컬럼명 = 수정할 값 WHERE 조건으로 지목;
--만일 WHERE 절에서 지목하지 않으면 모든 데이터가 수정됨

CREATE TABLE emps AS
(SELECT * FROM employees);



-- UPDATE를 진행할 때는, 누구를 수정할 지 잘 지목해야 합니다.
-- 그렇지 않으면 수정 대상이 테이블 전체로 지목됩니다.
UPDATE emps SET salary = 30000;

UPDATE emps SET salary = salary + salary*0.1
WHERE employee_id = 100;

-- 여러개의 데이터를 한번에 UPDATE 하는 방법
UPDATE emps
SET phone_number = '010.4742.8917', manager_id = 102
WHERE employee_id = 100;

-- UPDATE (서브쿼리)
--조회한 내용으로 수정하고 싶을 때 유용하게 사용
UPDATE emps
    SET(job_id, salary, manager_id) = 
    (
        SELECT job_id, salary, manager_id
        FROM emps
        WHERE employee_id = 100
    )
WHERE employee_id = 101;


-------------------------------------------------------
--DELETE
-- 한 행 자체를 날려버리는 것이기 때문에 컬럼을 지목할 필요가 없다!!!
DELETE FROM emps;
ROLLBACK;

DELETE FROM emps
WHERE employee_id = 103;


--DELETE (서브쿼리)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT');




-- CRUD = CREATE, READ, UPDATE, DELETE



SELECT * FROM emps;
DROP TABLE emps;


SELECT * FROM departments;
ROLLBACK; --실행 시점을 다시 뒤로 되돌리는 키워드






