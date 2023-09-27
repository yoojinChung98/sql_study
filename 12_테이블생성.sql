
/* 
-- ���� �̸��� ���̺��� ������ �� ����
CREATE TABLE ���̺�� (
    �÷���1  ������Ÿ�� ,
    �÷���2  ������Ÿ�� ,
        ...
    �÷���n  ������Ÿ�� ,
    
)
*/
/* ǥ�� �������� (���� ���̴� �÷� ������Ÿ�� ����)
- NUMBER(n) ����Ÿ�� -> ������ n�ڸ����� ������ �� �ִ� ������ Ÿ��.
- NUMBER(n, f) �Ǽ�Ÿ�� -> ������, �Ǽ��θ� ��ģ �� �ڸ��� n�ڸ�, �Ҽ��� f�ڸ�
- NUMBER -> ��ȣ�� ������ �� (38, 0)���� �ڵ� �����˴ϴ�.
- VARCHAR2(byte) ���ڿ�Ÿ�� -> ��ȣ �ȿ� ���� ���ڿ��� �ִ� ���̸� ����. (4000byte����)
-- CHAR�� ������ Ÿ��(�ִ� 2000byte) -> �������ڿ��� 10byte�� ������ ũ�⸦ �����ϰ� ����, VARCHAR2 �� ������ -> ����� ���� �޶���
- CLOB ��뷮 �ؽ�Ʈ ������ Ÿ�� -> 4000byte �� �Ѿ�� ���ڿ��� �� ��, (�ִ� 4Gbyte)
--caracer large object...
- BLOB ������ ��뷮 ��ü -> (�̹���, ���� ���� �� ���), (�ִ� 4Gbyte)
-- ���� �̷� ��ü�� �����ϱ� ���ٴ� �ַ� ������ǻ�� �ϵ��ũ�� �����ϰ�, DB���� �� ��θ� �������� ���� �Ϲ�����.
--binary large object....
- DATE ��¥-�ð� Ÿ�� -> BC 4712�� 1�� 1�� ~ AD 9999�� 12�� 31�ϱ��� ���� ����
- ��, ��, �� ���� ����.
*/
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR(14),
    loca VARCHAR(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

--DDL �� Ʈ�����(DML�� ������ ��)�� ������ ���� ����.!! ROLLBACK�Ѵٰ� ���̺��� ������ų� ���� ����.
--CREATE ����� �� �� �ڵ����� Ŀ���� ���� ����!



INSERT INTO dept2 VALUES (10, '����', '����', sysdate, 1000000);
INSERT INTO dept2 VALUES (20, '����', '����', sysdate, 2000000);
-- dept_no �� ������ ������Ÿ���� ������ ����� ���̹Ƿ� insert �Ұ���(SQL ����: value larger than specified precision allowed for this column_
--INSERT INTO dept2 VALUES (300, '�濵����', '��⵵', sysdate, 1000000);
--����� ����Ŭ�� �ѱ��� ���ڴ� 3byte �� �ν� (�ڹٴ� 2byte)
--INSERT INTO dept2 VALUES (30, 'abcdefghijklmnop', '��⵵', sysdate, 1000000);



----------------------���̺� �����ϱ�
--�÷� �߰�
-- ALTER TABLE ���̺�� ADD (�÷��� ������Ÿ��);
ALTER TABLE dept1
ADD (dept_count NUMBER(3));

--���̺��̸� ����
ALTER TABLE dept1
RENAME TO dept2;

-- �� �̸� ����
-- ALTER TABLE ���̺�� RENAME COLUMN (�÷��� TO �ٲ�_�÷���);
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;

--�� �Ӽ� ����
--���� �����ϰ��� �ϴ� �÷��� �����Ͱ� �̹� �ִٸ� �׿� �´� Ÿ������ �����ؾ� ��.
--���� �ʴ� Ÿ�����δ� ������ �Ұ���.
-- ALTER TABLE ���̺�� MODIFY (�÷���  �ٲ�_������Ÿ��);
ALTER TABLE dept2
MODIFY (dept_name VARCHAR2(100));

ALTER TABLE dept2
MODIFY (dept_name VARCHAR2(2)); --����

-- �� ����
ALTER TABLE dept2
DROP COLUMN dept_bonus;

-------------------------����
--���̺� ���� ������ ���� (���̺��� ������ ���ܵΰ� ���� �����͸� ��� ����)
TRUNCATE TABLE dept2;

--���̺� ��¥ ����
DROP TABLE dept2;


DESC dept2;
SELECT * FROM dept2;

ROLLBACK;


