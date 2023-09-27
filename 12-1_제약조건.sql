-- 테이블 생성과 제약조건
-- 제약 조건의 의미: 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해 규칙을 설정하는 것.

-- 테이블 열레벨 제약조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키) (중복값 과 NULL 방지)
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL: null을 허용하지 않음. (필수값)
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼 (외래키 제약조건, )
-- CHECK: 정의된 형식만 저장되도록 허용.(제약조건 커스텀)

--컬럼 레벨 제약 조건(컬럼 선언마다 제약조건 지정)
CREATE TABLE dept1 (
    dept_no NUMBER(2) CONSTRAINT dept1_deptno_pk PRIMARY KEY,
    dept_name VARCHAR(14) NOT NULL CONSTRAINT dept1_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept1_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept1_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept1_gender_ck CHECK(dept_gender IN('M','F'))
);

-- 컬럼 레벨 제약 조건 (컬럼 선언마다 제약조건 지정)
CREATE TABLE dept2 (
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

CREATE TABLE dept (
    dept_no NUMBER(2) PRIMARY KEY,
    dept_name VARCHAR2(14) NOT NULL UNIQUE,
    loca NUMBER(4) REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CHECK(dept_gender IN('M', 'F'))
);

/*
CREATE TABLE dept1 (
    컬럼1 데이터타입 CONSTRAINT 제약조건_이름 PRIMARY KEY,
    dept_name VARCHAR(14),
    loca VARCHAR(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);
- 만일 PRIMARY KEY를 지목하지 않을 것이라면 생략 가능 : 컬럼1 데이터타입 PRIMARY KEY
- 만일 UNIQUE를 지목하지 않을 것이라면 생략 가능 : 컬럼1 데이터타입 UNIQUE
- 해당 컬럼은 현재 locations 테이블의 location_id 컬럼을 참조하고 있음을 알려줌
- 쓸데없는 값이 들어가는 것을 막아줌. 해당 컬럼의 데이터는 반드시 locations.location_id 컬럼에 해당하는 것이어야 함.
-왜냐면 해당 값을 참조해서 외래테이블에 접근해야 하기 때문에, 이에 해당하는 값이 아니면 아예 받지도 않겠다는 뜻! 무결성을 보장해주기 위한 조건!
-포린키 제약조건: 참조하고 있는 컬럼에 존재하는 데이터로만 입력될 수 있도록 하는 제약조건.
- CHECK(조건);
*/

--외래키 (employees 테이블의 department_id 는 departments 테이블과 조인하기 위한 외래키임)
-- 타 테이블에 있는 키와 조인하기 위해 사용함
-- 타 테이블의 기본키를 외래키로 지정하는 것이 안전한 결합방법(무결성 보장)

-- 테이블 레벨 제약 조건 (모든 열 선언 후 제약 조건을 취하는 방식)
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

--외래키가 부모테이블(참조테이블)에 없다면 insert가 불가능.
INSERT INTO dept2 VALUES(10, 'gg', 4000, 100000, 'M');--에러: 외래키 제약조건 위반

--PK 중복값 과 null 값 방지.. 앞서 10을 등록한 데이터가 있어서 등록 불가능.
INSERT INTO dept2 VALUES(10, 'hh', 1900, 100000, 'M');

INSERT INTO dept2 VALUES(20, 'hh', 1900, 100000, 'M');

--외래키가 부모테이블(참조테이블)에 없다면 update가 불가능.
UPDATE dept2 SET loca = 4000
WHERE dept_no = 10;--에러: 외래키 제약조건 위반

------제약 조건 변경
--제약 조건은 추가, 삭제만 가능! 변경은 불가능
-- 변경하려면 삭제하고 새로운 내용으로 추가해야 함. (생성시 붙여놓은 이름으로 지목하여 )
--예외: NOT NULL -> 열 수정형태로 변경.
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR(1)
);

-- pk 추가 (테이블의 구조가 변경되었다고 인식하므로...)
--ALTER TABLE 테이블명 ADD CONSTRAINT 제약명 제약키워드(컬럼명)
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);

ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);

ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck
CHECK(dept_bonus > 0);

ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk
UNIQUE(dept_name);

--NOT NULL은 열 수정.
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

--제약 조건 확인
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

--------------제약 조건 삭제 (제약 조건 이름으로)
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;


----------------------------------------연습문제---------------------
CREATE TABLE members(
    m_name VARCHAR(20) NOT NULL,
    m_num NUMBER(3) CONSTRAINT mem_memnum_pk PRIMARY KEY,
    reg_date DATE NOT NULL CONSTRAINT mem_regdate_uk UNIQUE,
    gender VARCHAR2(1),
    loca NUMBER(4) CONSTRAINT mem_loca_loc_locid_fk REFERENCES locations(location_id)
);

INSERT INTO members VALUES ('AAA', 1, '2018-07-01', 'M', 1800);
INSERT INTO members VALUES ('BBB', 2, '2018-07-02', 'F', 1900);
INSERT INTO members VALUES ('CCC', 3, '2018-07-03', 'M', 2000);
INSERT INTO members VALUES ('DDD', 4, sysdate, 'M', 2000);

SELECT
    m.m_name, m.m_num, loc.street_address, loc.location_id
FROM members m
JOIN locations loc
ON loc.location_id = m.loca
ORDER BY m.m_num ASC;

DESC members;
SELECT * FROM user_constraints WHERE table_name = 'MEMBERS';
SELECT * FROM members;
COMMIT;
DROP TABLE members;




-- 문제1과 동일하게 조회하기
SELECT
    m_name,
    m_num,
    TO_CHAR(reg_date,'YYYY-MM-DD'),
    gender,
    loca
FROM members;










