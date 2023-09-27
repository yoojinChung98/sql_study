
/*
DML
DATE MANAGER LANGUAGE
= select, insert, update, delete
*/

--어떤 하나의 작업이 하나의 쿼리만으로 이뤄지지 않을 수도 있음.

--DBMS에 따라 COMMIT 이 자동설정되어 있는 DBMS들이 있음! 그것을 확인하는 쿼리문.
--오토커밋 여부 확인
--오토커밋을 켠다 = 트랜잭션을 하지 않겠다는 의미(각 쿼리문마다 커밋이 진행되기 때문)
SHOW AUTOCOMMIT;
--오토커밋 온
SET AUTOCOMMIT ON;
--오토커밋 오프
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (304, 'lee', 'lee1234@gmail.com', sysdate, 1800);
    
DELETE FROM emps WHERE employee_id = 304;

--보류중인 모든 데이터 변경사항을 취소(폐기)
--직전 커밋 단계로 회귀(돌아가기) 및 트랜잭션 종료.
--ROLLBACK 시키면 savepoint 까지 날아감!!
ROLLBACK;
--insert 했는데 어?? 아냐아냐 실수였어!! 할 때 롤백 사용.
-- 우리가 보기에는 실제 DB에 적용된 것 같아 보이지마안! 사실은 확정되지 않은 것!???
-- 메인 DB에 반영되는 것이 아님!! 

-- 보류중인 모든 데이터 변경 사항을 영구적으로 적용하면서 트랜잭션 종료.
-- 커밋 후에는 어떠한 방법을 사용하더라도 되돌릴 수 없습니다.
COMMIT;



--커밋 시점을 조절해서 돌아갈 수 있음.
--오라클에만 있음 (ANSI 표준 문법은 아님 즉 다른 DBMS에는 없을 가능성 농후농후)
--ROLLBACK 시키면 savepoint 까지 날아감!! 세이브포인트는 그저 저장시점을 남겨놓는 것 뿐
-- 결국 돌아오는 시점을 하나 만드는 것 뿐, 그 어느것도 커밋되지는 않음

--왠지 나중에 여기로 돌아올 것 같은데... 세이브포인트가 있으면 좋겠다!!!
-- 세이브포인트 생성
-- 롤백할 포인트를 직접 이름을 붙여서 지정
-- ANSI 표준 문법이 아니기 때문에 그렇게 권장하지는 않음.
SAVEPOINT insert_park;
SELECT * FROM emps;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (305, 'park', 'park1234@gmail.com', sysdate, 1800);

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (306, 'kim', 'kim1234@gmail.com', sysdate, 1800);

--ROLLBACK TO SAVEPOINT 세이브포인트_명;
ROLLBACK TO SAVEPOINT insert_park;

