
--시퀀스 (순차적으로 증가하는 값을 만들어 주는 객체)

CREATE SEQUENCE dept2_seq
    START WITH 1 --기본값 = 최소값(증가시)/최대값(감소시)
    INCREMENT BY 1 --기본값=1, (양수면 증가, 음수면 감소)
    MAXVALUE 10 --최대값 (기본값 = 1027(증가시)/-1(감소시)
    MINVALUE 1 -- 최소값 (기본값 = 1(증가시), -1028(감소시)
    NOCACHE--캐시메모리 사용 여부 (기본값 = CACHE)
    NOCYCLE; --순환여부 (기본값 = NOCYCLE, 순환시키고 싶다면 CYCLE 작성)
    
DROP SEQUENCE dept2_seq;
DROP TABLE dept2;

CREATE TABLE dept2 (
    dept_no NUMBER(2) PRIMARY KEY,
    dept_name VARCHAR2(14),
    loca VARCHAR(13),
    dept_date DATE
);

-- 시퀀스 사용하기 (NEXTVAL, CURRVAL)
INSERT INTO dept2 VALUES(dept2_seq.NEXTVAL, 'test', 'test', sysdate);
--시퀀스가 최대값을 찍었을 때, noCycle이라면 시퀀스는 전부 사용한 것이고 더 사용할 수 없음(시퀀스가 사라지지는 않음)

SELECT * FROM dept2;

SELECT dept2_seq.CURRVAL FROM dual;

-- 시퀀스 수정 (직접 수정 가능)
-- START WITH 는 수정이 불가능합니다.
ALTER SEQUENCE dept2_seq MAXVALUE 9999;
ALTER SEQUENCE dept2_seq INCREMENT BY -1;
ALTER SEQUENCE dept2_seq MINVALUE -30;

--시퀀스 값을 다시 처음으로 돌리는 방법
SELECT dept2_seq.CURRVAL FROM dual;
ALTER SEQUENCE dept2_seq INCREMENT BY -55;
SELECT dept2_seq.NEXTVAL FROM dual;
ALTER SEQUENCE dept2_seq INCREMENT BY 1;

---------------------------------------------------

/*
- index
index는 primary key, unique 제약 조건에서 자동으로 생성되고,
조회를 빠르게 해 주는 hint 역할을 합니다.
index는 조회를 빠르게 하지만, 무작위하게 많은 인덱스를 생성해서
사용하면 오히려 성능 부하를 일으킬 수 있습니다.
정말 필요할 때만 index를 사용하는 것이 바람직합니다.

오라클의 옵티마이저가 우리가 작성한 sql를 실행해주는 친구!
그 친구가 index를 통해 조회를 빠르게 할 수 있도록 도와주는 역할

*/

SELECT * FROM employees WHERE salary = 12008;

-- 인덱스 생성
--CREATE INDEX 인덱스_이름 ON 테이블(인덱스_붙일_컬럼);
CREATE INDEX emp_salary_idx ON employees(salary);
DROP INDEX emp_salary_idx;


/*
테이블 조회 시 인덱스가 붙은 컬럼을 조건절로 사용한다면
테이블 전체 조회가 아닌, 컬럼에 붙은 인덱스를 이용해서 조회를 진행합니다.

인덱스를 생성하게 되면 지정한 컬럼에 ROWID를 붙인 인덱스가 준비되고,
조회를 진행할 시 해당 인덱스의 ROWID를 통해 빠른 스캔을 가능하게 합니다.


*/

-----------------------------------------------------------

--시퀀스와 인덱스를 사용하는 hint 방법
CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE TABLE tbl_board(
    bno NUMBER(2) PRIMARY KEY,
    writer VARCHAR2(20)
);

INSERT INTO tbl_board VALUES(board_seq.NEXTVAL, 'test'||board_seq.CURRVAL);
INSERT INTO tbl_board VALUES(board_seq.NEXTVAL, 'admin');
INSERT INTO tbl_board VALUES(board_seq.NEXTVAL, 'kim');
INSERT INTO tbl_board VALUES(board_seq.NEXTVAL, 'hong');

SELECT * FROM tbl_board
WHERE bno= 32;

COMMIT;

-- 인덱스 이름 변경
ALTER INDEX SYS_C007073
RENAME TO tbl_board_idx;

SELECT *
FROM(
    SELECT ROWNUM AS rn, a.*
    FROM(
        SELECT *
        FROM tbl_board
        ORDER BY bno DESC
    ) a   
)
WHERE rn>10 AND rn<=20;


-- /*+ INDEX(table_name index_name) */
-- 지정된 인덱스를 강제로 쓰게끔 지정.
-- INDEX ASC, DESC를 추가해서 내림차, 오름차 순으로 쓰게끔 지정 가능.
-- /*+ */ ->오라클 힌트 문법

SELECT * FROM
    (
    SELECT /*+ INDEX DESC (tbl_board tbl_board_idx) */
        ROWNUM AS rn,
        bno,
        writer
    FROM tbl_board
    )
WHERE rn>10 AND rn<=20;
-- 인덱스 값을 기준으로 내림차순 정리를 하는건지,
-- 아니면 인덱스를 가지고 있는 컬럼으로가서 컬럼의 값을 기준으로 내림차순 정리를 하는 건지?

--인덱스를 활용하여 미리 정렬이 되어있는 것에 ROWNUM이 붙으므로 정렬단계(ORDER BY) 하나 생략 가능.


/*
- 인덱스가 권장되는 경우 
1. 컬럼이 WHERE 또는 조인조건에서 자주 사용되는 경우 (는 보통 PRIMARY KEY임...ㅎ)
2. 열이 광범위한 값을 포함하는 경우 (무작위 값?)
3. 테이블이 대형인 경우
4. 타겟 컬럼이 많은 수의 null값을 포함하는 경우.(인덱스가 null을 모두 제거한 후 조회하므로 속도가 더 빨라짐)
5. 테이블이 자주 수정되고, 이미 하나 이상의 인덱스를 가지고 있는 경우에는
 권장하지 않습니다. (테이블 수정시 마다 인덱스도 함께 갱신되므로 성능저하를 유발할 수 있음)
*/












