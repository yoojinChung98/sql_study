-- ���̺� ������ ��������
-- ���� ������ �ǹ�: ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���� ��Ģ�� �����ϴ� ��.

-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű) (�ߺ��� �� NULL ����)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����. (�ʼ���)
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷� (�ܷ�Ű ��������, )
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.(�������� Ŀ����)

--�÷� ���� ���� ����(�÷� ���𸶴� �������� ����)
CREATE TABLE dept1 (
    dept_no NUMBER(2) CONSTRAINT dept1_deptno_pk PRIMARY KEY,
    dept_name VARCHAR(14) NOT NULL CONSTRAINT dept1_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept1_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept1_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept1_gender_ck CHECK(dept_gender IN('M','F'))
);

-- �÷� ���� ���� ���� (�÷� ���𸶴� �������� ����)
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
    �÷�1 ������Ÿ�� CONSTRAINT ��������_�̸� PRIMARY KEY,
    dept_name VARCHAR(14),
    loca VARCHAR(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);
- ���� PRIMARY KEY�� �������� ���� ���̶�� ���� ���� : �÷�1 ������Ÿ�� PRIMARY KEY
- ���� UNIQUE�� �������� ���� ���̶�� ���� ���� : �÷�1 ������Ÿ�� UNIQUE
- �ش� �÷��� ���� locations ���̺��� location_id �÷��� �����ϰ� ������ �˷���
- �������� ���� ���� ���� ������. �ش� �÷��� �����ʹ� �ݵ�� locations.location_id �÷��� �ش��ϴ� ���̾�� ��.
-�ֳĸ� �ش� ���� �����ؼ� �ܷ����̺� �����ؾ� �ϱ� ������, �̿� �ش��ϴ� ���� �ƴϸ� �ƿ� ������ �ʰڴٴ� ��! ���Ἲ�� �������ֱ� ���� ����!
-����Ű ��������: �����ϰ� �ִ� �÷��� �����ϴ� �����ͷθ� �Էµ� �� �ֵ��� �ϴ� ��������.
- CHECK(����);
*/

--�ܷ�Ű (employees ���̺��� department_id �� departments ���̺�� �����ϱ� ���� �ܷ�Ű��)
-- Ÿ ���̺� �ִ� Ű�� �����ϱ� ���� �����
-- Ÿ ���̺��� �⺻Ű�� �ܷ�Ű�� �����ϴ� ���� ������ ���չ��(���Ἲ ����)

-- ���̺� ���� ���� ���� (��� �� ���� �� ���� ������ ���ϴ� ���)
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

--�ܷ�Ű�� �θ����̺�(�������̺�)�� ���ٸ� insert�� �Ұ���.
INSERT INTO dept2 VALUES(10, 'gg', 4000, 100000, 'M');--����: �ܷ�Ű �������� ����

--PK �ߺ��� �� null �� ����.. �ռ� 10�� ����� �����Ͱ� �־ ��� �Ұ���.
INSERT INTO dept2 VALUES(10, 'hh', 1900, 100000, 'M');

INSERT INTO dept2 VALUES(20, 'hh', 1900, 100000, 'M');

--�ܷ�Ű�� �θ����̺�(�������̺�)�� ���ٸ� update�� �Ұ���.
UPDATE dept2 SET loca = 4000
WHERE dept_no = 10;--����: �ܷ�Ű �������� ����

------���� ���� ����
--���� ������ �߰�, ������ ����! ������ �Ұ���
-- �����Ϸ��� �����ϰ� ���ο� �������� �߰��ؾ� ��. (������ �ٿ����� �̸����� �����Ͽ� )
--����: NOT NULL -> �� �������·� ����.
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR(1)
);

-- pk �߰� (���̺��� ������ ����Ǿ��ٰ� �ν��ϹǷ�...)
--ALTER TABLE ���̺�� ADD CONSTRAINT ����� ����Ű����(�÷���)
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);

ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);

ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck
CHECK(dept_bonus > 0);

ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk
UNIQUE(dept_name);

--NOT NULL�� �� ����.
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

--���� ���� Ȯ��
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

--------------���� ���� ���� (���� ���� �̸�����)
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;


----------------------------------------��������---------------------
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




-- ����1�� �����ϰ� ��ȸ�ϱ�
SELECT
    m_name,
    m_num,
    TO_CHAR(reg_date,'YYYY-MM-DD'),
    gender,
    loca
FROM members;










