
/* 
-- 같은 이름의 테이블은 존재할 수 없음
CREATE TABLE 테이블명 (
    컬럼명1  데이터타입 ,
    컬럼명2  데이터타입 ,
        ...
    컬럼명n  데이터타입 ,
    
)
*/
/* 표로 정리하자 (자주 쓰이는 컬럼 데이터타입 종류)
- NUMBER(n) 정수타입 -> 정수를 n자리까지 저장할 수 있는 숫자형 타입.
- NUMBER(n, f) 실수타입 -> 정수부, 실수부를 합친 총 자리수 n자리, 소수점 f자리
- NUMBER -> 괄호를 생략할 시 (38, 0)으로 자동 지정됩니다.
- VARCHAR2(byte) 문자열타입 -> 괄호 안에 들어올 문자열의 최대 길이를 지정. (4000byte까지)
-- CHAR는 고정형 타입(최대 2000byte) -> 지정문자열이 10byte라도 지정한 크기를 유지하고 있음, VARCHAR2 는 가변형 -> 사이즈에 따라 달라짐
- CLOB 대용량 텍스트 데이터 타입 -> 4000byte 가 넘어가는 문자열이 올 때, (최대 4Gbyte)
--caracer large object...
- BLOB 이진형 대용량 객체 -> (이미지, 파일 저장 시 사용), (최대 4Gbyte)
-- 직접 이런 객체를 저장하기 보다는 주로 서버컴퓨터 하드디스크에 저장하고, DB에는 그 경로를 저장히는 것이 일반적임.
--binary large object....
- DATE 날짜-시간 타입 -> BC 4712년 1월 1일 ~ AD 9999년 12월 31일까지 지정 가능
- 시, 분, 초 지원 가능.
*/
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR(14),
    loca VARCHAR(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

--DDL 는 트랜잭션(DML에 영향을 줌)에 영향을 받지 않음.!! ROLLBACK한다고 테이블이 사라지거나 하지 않음.
--CREATE 명령이 들어갈 때 자동으로 커밋이 들어가기 때문!



INSERT INTO dept2 VALUES (10, '개발', '서울', sysdate, 1000000);
INSERT INTO dept2 VALUES (20, '영업', '서울', sysdate, 2000000);
-- dept_no 의 지정된 데이터타입의 범위에 벗어나는 값이므로 insert 불가능(SQL 오류: value larger than specified precision allowed for this column_
--INSERT INTO dept2 VALUES (300, '경영지원', '경기도', sysdate, 1000000);
--참고로 오라클은 한글을 글자당 3byte 로 인식 (자바는 2byte)
--INSERT INTO dept2 VALUES (30, 'abcdefghijklmnop', '경기도', sysdate, 1000000);



----------------------테이블 수정하기
--컬럼 추가
-- ALTER TABLE 테이블명 ADD (컬럼명 데이터타입);
ALTER TABLE dept1
ADD (dept_count NUMBER(3));

--테이블이름 변경
ALTER TABLE dept1
RENAME TO dept2;

-- 열 이름 변경
-- ALTER TABLE 테이블명 RENAME COLUMN (컬럼명 TO 바꿀_컬럼명);
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;

--열 속성 변경
--만약 변경하고자 하는 컬럼에 데이터가 이미 있다면 그에 맞는 타입으로 변경해야 함.
--맞지 않는 타입으로는 변경이 불가능.
-- ALTER TABLE 테이블명 MODIFY (컬럼명  바꿀_데이터타입);
ALTER TABLE dept2
MODIFY (dept_name VARCHAR2(100));

ALTER TABLE dept2
MODIFY (dept_name VARCHAR2(2)); --에러

-- 열 삭제
ALTER TABLE dept2
DROP COLUMN dept_bonus;

-------------------------삭제
--테이블 내부 데이터 삭제 (테이블의 구조는 남겨두고 내부 데이터만 모두 삭제)
TRUNCATE TABLE dept2;

--테이블 진짜 삭제
DROP TABLE dept2;


DESC dept2;
SELECT * FROM dept2;

ROLLBACK;


