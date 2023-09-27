
--MERGE: 테이블 병합

/*
UPDATE와 INSERT를 한 방에 처리.

한 테이블에 해당하는 데이터가 있다면 UPDATE를,
없으면 INSERT로 처리해라.
*/

CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1=2);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES
    (106, '춘식', '김', 'CHOONSIK', sysdate, 'IT_PROG');
    
SELECT * FROM emps_it;
SELECT * FROM employees WHERE job_id = 'IT_PROG';


--MERGE 를 이용한다면 삽입, 수정을 따로하지 않아도 됨! 한꺼번에 처리 가능
--이미 존재하는 값은 자동 수정이 될 것이고, 존재하지 않는 것은 삽입이 될 것임.
MERGE INTO emps_it a -- (머지를 할 타겟 테이블)
    USING -- 병합시킬 데이터
        (SELECT * FROM employees
        WHERE job_id = 'IT_PROG') b --병합하고자 하는 데이터를 서브쿼리로 표현
    ON (a.employee_id = b.employee_id) -- 병합시킬 데이터의 연결 조건
WHEN MATCHED THEN -- 조건이 일치하는 경우에는 타겟 테이블에 이렇게 실행하라. 라는 명령을 여기에 적어 주세요!(중복인 경우겠지?)
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
WHEN NOT MATCHED THEN -- 조건이 일치하지 않는 경우 (한쪽에만 데이터가 있는 경우) (인서트를 해야 겠지)
    INSERT /*속성(컬럼)*/ VALUES (b.employee_id, b.first_name, b.last_name,
                                b.email, b.phone_number, b.hire_date, b.job_id,
                                b.salary, b.commission_pct, b.manager_id, b.department_id);

--근데 머지를 왜 쓰지?
-- 백업테이블.
--실제 사용되고 있는 테이블과 여러 백업테이블들!
--사용되고 있는 테이블은 수시로 변경이 일어나지만, 백업테이블들은 마지막 저장상태 그대로 보존되어 있음.
--수정이 너무 많이 일어난 이 테이블의 최신데이터를 백업테이블로 백업해야하는데... 여기서 뭐가 인서트고 업데이트인지,,, 구분하기가,, 쉽지가 않음...
-- 이런 것들을 반영할 때, 종합적으로 처리하기 편리하다!

/*
# 머지를 사용하는 적절한 이유
- 실제 사용되고 있는 테이블을 백업 테이블로 백업할 때 사용하기 편리함.
- 수많은 요청 등으로 삽입, 변경, 삭제가 많이 일어난 테이블을 백업하기 위해서 인서트, 업데이트 체크가 어려움
- 이때 머지를 사용하면 종합적으로 한번에 처리하기 간편하다.
*/


INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '렉스', '박', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '니나', '최', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '흥민', '손', 'HMSON', '20/04/06', 'AD_VP');

SELECT * FROM emps_it;

/*
employees 테이블을 매번 빈번하게 수정되는 테이블이라고 가정하자.
기존의 데이터는 email, phone, salary, comm_pct, man_id, dept_id을
업데이트 하도록 처리
새로 유입된 데이터는 그대로 추가.
*/

MERGE INTO emps_it a
    USING (SELECT * FROM employees) b
    ON (a.employee_id = b.employee_id)

WHEN MATCHED THEN
    UPDATE SET 
        a.email = b.email,
        a.phone_number = b.phone_number,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
    
WHEN NOT MATCHED THEN    
    INSERT VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
SELECT * FROM emps_it
ORDER BY employee_id ASC;

------------------------------------------

--DELETE 는 단독적으로 사용할 수 없댕
--즉, 업데이트가 없으면 사용할 수 없음

--없으면 인서트, 있으면 delete 해보장
MERGE INTO emps_it a -- (머지를 할 타겟 테이블)
    USING -- 병합시킬 데이터
        (SELECT * FROM employees
        WHERE job_id = 'IT_PROG') b --병합하고자 하는 데이터를 서브쿼리로 표현
    ON (a.employee_id = b.employee_id) -- 병합시킬 데이터의 연결 조건
WHEN MATCHED THEN -- 조건이 일치하는 경우에는 타겟 테이블에 이렇게 실행하라. 라는 명령을 여기에 적어 주세요!(중복인 경우겠지?)
    UPDATE SET
        a.phone_number = b.phone_number
        
         /*
        DELETE만 단독으로 쓸 수는 없습니다.
        UPDATE 이후에 DELETE 작성이 가능합니다.
        UPDATE 된 대상을 DELETE 하도록 설계되어 있기 때문에
        삭제할 대상 컬럼들을 동일한 값으로 일단 UPDATE를 진행하고
        DELETE의 WHERE절에 아까 지정한 동일한 값을 지정해서 삭제합니다.
        */
    DELETE
        WHERE a.employee_id = b.employee_id
    
        
WHEN NOT MATCHED THEN -- 조건이 일치하지 않는 경우 (한쪽에만 데이터가 있는 경우) (인서트를 해야 겠지)
    INSERT /*속성(컬럼)*/ VALUES (b.employee_id, b.first_name, b.last_name,
                                b.email, b.phone_number, b.hire_date, b.job_id,
                                b.salary, b.commission_pct, b.manager_id, b.department_id);


---------------------------------------------------------------
CREATE TABLE DEPTS AS
(SELECT department_id, department_name, manager_id, location_id
FROM departments);

INSERT INTO depts (department_id, department_name, location_id)
VALUES (280, '개발', 1800);
INSERT INTO depts (department_id, department_name, location_id)
VALUES (290, '회계부', 1800);
INSERT INTO depts
VALUES (300, '재정', 301, 1800);
INSERT INTO depts
VALUES (310, '인사', 302, 1800);
INSERT INTO depts
VALUES (320, '영업', 303, 1700);

--2,.
UPDATE depts SET department_name = 'IT bank'
WHERE department_name = 'IT Support';

UPDATE depts SET manager_id = 301
WHERE department_id = 290;

UPDATE depts SET department_name = 'IT Help', manager_id = 303, location_id=1800
WHERE department_name = 'IT Helpdesk';

UPDATE depts SET manager_id = 301
WHERE department_name IN('회계부','재정','인사','영업');
--3.
DELETE FROM depts
WHERE department_name IN ('Sales', 'NOC');

DELETE FROM depts
WHERE department_id = (SELECT department_id FROM depts 
                        WHERE department_name = 'NOC');

--4.
DELETE FROM depts
WHERE department_id > 200;

UPDATE depts SET manager_id = 100
WHERE manager_id IS NOT NULL;

MERGE INTO depts a
    USING departments b
    ON (a.department_id = b.department_id)
WHEN MATCHED THEN
    UPDATE SET
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id
WHEN NOT MATCHED THEN
    INSERT VALUES (b.department_id, b.department_name, b.manager_id, b.location_id);

-----5.
CREATE TABLE jobs_it AS (SELECT job_id, job_title, min_salary, max_salary
                        FROM jobs WHERE min_salary > 6000);

INSERT INTO jobs_it VALUES ('IT_DEV', '아이티개발팀', 6000, 20000);
INSERT INTO jobs_it VALUES ('NET_DEV', '네트워크개발팀', 5000, 20000);
INSERT INTO jobs_it VALUES ('SEC_DEV', '보안개발팀', 6000, 19000);

MERGE INTO jobs_it a
    USING (SELECT * FROM jobs WHERE min_salary > 0) b
    ON (a.job_id = b.job_id)
WHEN MATCHED THEN
    UPDATE SET
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary
WHEN NOT MATCHED THEN
    INSERT VALUES(b.job_id, b.job_title, b.min_salary, b.max_salary);

SELECT * FROM jobs_it;

-----------------------------------
--차가 0 이상인 경우만 업데이트!! 를 체크해보자!
MERGE INTO jobs_it a
    USING (SELECT * FROM jobs WHERE min_salary > 0) b
    ON (a.job_id = b.job_id)
WHEN MATCHED THEN
    UPDATE SET (min_salary, max_salary)
        (
            SELECT min_salary, max_salary
            FROM jobs_it a1 JOIN jobs a2
            ON a1.job_id = a2.job_id;
            WHERE a2.min_salary - a1.min_salary > 0 )
        )
WHEN NOT MATCHED THEN
    INSERT VALUES(b.job_id, b.job_title, b.min_salary, b.max_salary);

SELECT * FROM jobs_it;










