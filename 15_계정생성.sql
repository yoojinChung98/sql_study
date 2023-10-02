
/*
DCL: GRANT(권한 부여), REVOKE(권한 회수)

CREATE USER -> 데이터베이스 유저 생성 권한
CREATE SESSION -> 데이터베이스 접속 권한
CREATE TABLE -> 테이블 생성 권한
CREATE VIEW -> 뷰 생성 권한
CREATE SEQUENCE -> 시퀀스 생성 권한
ALTER ANY TABLE -> 어떠한 테이블도 수정할 수 있는 권한
INSERT ANY TABLE -> 어떠한 테이블에도 데이터를 삽입하는 권한.
SELECT ANY TABLE...

SELECT ON [테이블 이름] TO [유저 이름] -> 특정 테이블만 조회할 수 있는 권한.
INSERT ON....
UPDATE ON....

- 관리자에 준하는 권한을 부여하는 구문.
RESOURCE(내부자원), CONNECT(접속), DBA TO [유저 이름]
*/

--DML : Data manipulation Lanaguage
--DCL : Data Control Language
--DDL : Data Definition Languate
--TCL : Transaction Control Language

-- 사용자 계정 확인
SELECT * FROM all_users;


-- 계정 생성 명령
--CREATE USER 아이디 IDENTIFIED BY 비밀번호;
CREATE USER user1 IDENTIFIED BY user1;
--insufficient privileges : 계정 생성 권한 없음.


--권한을 줄 땐 항상 GRANT 로 시작
GRANT CREATE SESSION TO user1;
--user1에게 데이터베이스 '접속'권한을 줌

SELECT * FROM hr.departments;
--특정 테이블에 대한 권한을 주지 않으면 방금 생성된 user1은 hr의 테이블인 departments를 함부로 조회할 수 없음

GRANT SELECT ON hr.departments TO user1;
--select 권한을 주겠다. hr.departments테이블에대한! user1에게

GRANT INSERT ON hr.departments TO user1;


--테이블이 넘 많아서 일일이 권한 주기 귀찮을 땐! ANY 사용! (어떠한 테이블이든 모두 권한을 주는 방법!)


GRANT CREATE TABLE TO user1;

ALTER USER user1
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

GRANT SELECT ANY TABLE to user1;

GRANT RESOURCE, CONNECT, DBA TO user1;
--관리자와 거의 동등한 권한을 거의 다 갖게 됨!

--권한을 줬다 다시 뺐는 방법(REVOKE)
REVOKE RESOURCE, CONNECT, DBA FROM user1;


-- 사용자 계정 삭제
-- DROP USER [유저이름] CASCADE;
-- CASCADE 없을 시 -> 테이블 or 시퀀스 등 객체가 존재한다면 계정 삭제 안됨.
DROP USER user1;
DROP USER user1 CASCADE;



----------------------------------------------------------------

/*
테이블 스페이스는 데이터베이스 객체 내 실제 데이터가 저장되는 공간입니다.
테이블 스페이스를 생성하면 지정된 경로에 실제 파일로 정의한 용량만큼의
파일이 생성이 되고, 데이터가 물리적으로 저장됩니다.
당연히 테이블 스페이스의 용량을 초과한다면 프로그램이 비정상적으로 동작합니다.
*/

SELECT * FROM dba_tablespaces;

CREATE USER test1 IDENTIFIED BY test1;

GRANT CREATE SESSION TO test1;
GRANT CONNECT, RESOURCE TO test1;

--user_tablespace 테이블 스페이스를 기본 사용 공간으로 지정하고 사용량 제한을 둠
ALTER user test1
DEFAULT TABLESPACE user_tablespace
QUOTA 10M ON user_tablespace; -- 유저_테이블스페이스 라는 공간을 10mb(k,m,g,t,unlimited)만 사용할 수 있는 권한을 주는 것.


-- 테이블 스페이스 내의 객체를 전체 삭제(물리적 공간(파일)은 그대로 놔두고!)
DROP TABLESPACE user_tablespace INCLUDING CONTENTS;

-- 물리적 파일까지 삭제.
DROP TABLESPACE user_tablespace INCLUDING CONTENTS AND DATAFILES;






