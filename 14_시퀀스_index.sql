
--������ (���������� �����ϴ� ���� ����� �ִ� ��ü)

CREATE SEQUENCE dept2_seq
    START WITH 1 --�⺻�� = �ּҰ�(������)/�ִ밪(���ҽ�)
    INCREMENT BY 1 --�⺻��=1, (����� ����, ������ ����)
    MAXVALUE 10 --�ִ밪 (�⺻�� = 1027(������)/-1(���ҽ�)
    MINVALUE 1 -- �ּҰ� (�⺻�� = 1(������), -1028(���ҽ�)
    NOCACHE--ĳ�ø޸� ��� ���� (�⺻�� = CACHE)
    NOCYCLE; --��ȯ���� (�⺻�� = NOCYCLE, ��ȯ��Ű�� �ʹٸ� CYCLE �ۼ�)
    
DROP SEQUENCE dept2_seq;
DROP TABLE dept2;

CREATE TABLE dept2 (
    dept_no NUMBER(2) PRIMARY KEY,
    dept_name VARCHAR2(14),
    loca VARCHAR(13),
    dept_date DATE
);

-- ������ ����ϱ� (NEXTVAL, CURRVAL)
INSERT INTO dept2 VALUES(dept2_seq.NEXTVAL, 'test', 'test', sysdate);
--�������� �ִ밪�� ����� ��, noCycle�̶�� �������� ���� ����� ���̰� �� ����� �� ����(�������� ��������� ����)

SELECT * FROM dept2;

SELECT dept2_seq.CURRVAL FROM dual;

-- ������ ���� (���� ���� ����)
-- START WITH �� ������ �Ұ����մϴ�.
ALTER SEQUENCE dept2_seq MAXVALUE 9999;
ALTER SEQUENCE dept2_seq INCREMENT BY -1;
ALTER SEQUENCE dept2_seq MINVALUE -30;

--������ ���� �ٽ� ó������ ������ ���
SELECT dept2_seq.CURRVAL FROM dual;
ALTER SEQUENCE dept2_seq INCREMENT BY -55;
SELECT dept2_seq.NEXTVAL FROM dual;
ALTER SEQUENCE dept2_seq INCREMENT BY 1;

---------------------------------------------------

/*
- index
index�� primary key, unique ���� ���ǿ��� �ڵ����� �����ǰ�,
��ȸ�� ������ �� �ִ� hint ������ �մϴ�.
index�� ��ȸ�� ������ ������, �������ϰ� ���� �ε����� �����ؼ�
����ϸ� ������ ���� ���ϸ� ����ų �� �ֽ��ϴ�.
���� �ʿ��� ���� index�� ����ϴ� ���� �ٶ����մϴ�.

����Ŭ�� ��Ƽ�������� �츮�� �ۼ��� sql�� �������ִ� ģ��!
�� ģ���� index�� ���� ��ȸ�� ������ �� �� �ֵ��� �����ִ� ����

*/

SELECT * FROM employees WHERE salary = 12008;

-- �ε��� ����
--CREATE INDEX �ε���_�̸� ON ���̺�(�ε���_����_�÷�);
CREATE INDEX emp_salary_idx ON employees(salary);
DROP INDEX emp_salary_idx;


/*
���̺� ��ȸ �� �ε����� ���� �÷��� �������� ����Ѵٸ�
���̺� ��ü ��ȸ�� �ƴ�, �÷��� ���� �ε����� �̿��ؼ� ��ȸ�� �����մϴ�.

�ε����� �����ϰ� �Ǹ� ������ �÷��� ROWID�� ���� �ε����� �غ�ǰ�,
��ȸ�� ������ �� �ش� �ε����� ROWID�� ���� ���� ��ĵ�� �����ϰ� �մϴ�.


*/

-----------------------------------------------------------

--�������� �ε����� ����ϴ� hint ���
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

-- �ε��� �̸� ����
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
-- ������ �ε����� ������ ���Բ� ����.
-- INDEX ASC, DESC�� �߰��ؼ� ������, ������ ������ ���Բ� ���� ����.
-- /*+ */ ->����Ŭ ��Ʈ ����

SELECT * FROM
    (
    SELECT /*+ INDEX DESC (tbl_board tbl_board_idx) */
        ROWNUM AS rn,
        bno,
        writer
    FROM tbl_board
    )
WHERE rn>10 AND rn<=20;
-- �ε��� ���� �������� �������� ������ �ϴ°���,
-- �ƴϸ� �ε����� ������ �ִ� �÷����ΰ��� �÷��� ���� �������� �������� ������ �ϴ� ����?

--�ε����� Ȱ���Ͽ� �̸� ������ �Ǿ��ִ� �Ϳ� ROWNUM�� �����Ƿ� ���Ĵܰ�(ORDER BY) �ϳ� ���� ����.


/*
- �ε����� ����Ǵ� ��� 
1. �÷��� WHERE �Ǵ� �������ǿ��� ���� ���Ǵ� ��� (�� ���� PRIMARY KEY��...��)
2. ���� �������� ���� �����ϴ� ��� (������ ��?)
3. ���̺��� ������ ���
4. Ÿ�� �÷��� ���� ���� null���� �����ϴ� ���.(�ε����� null�� ��� ������ �� ��ȸ�ϹǷ� �ӵ��� �� ������)
5. ���̺��� ���� �����ǰ�, �̹� �ϳ� �̻��� �ε����� ������ �ִ� ��쿡��
 �������� �ʽ��ϴ�. (���̺� ������ ���� �ε����� �Բ� ���ŵǹǷ� �������ϸ� ������ �� ����)
*/












