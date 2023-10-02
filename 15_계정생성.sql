
/*
DCL: GRANT(���� �ο�), REVOKE(���� ȸ��)

CREATE USER -> �����ͺ��̽� ���� ���� ����
CREATE SESSION -> �����ͺ��̽� ���� ����
CREATE TABLE -> ���̺� ���� ����
CREATE VIEW -> �� ���� ����
CREATE SEQUENCE -> ������ ���� ����
ALTER ANY TABLE -> ��� ���̺� ������ �� �ִ� ����
INSERT ANY TABLE -> ��� ���̺��� �����͸� �����ϴ� ����.
SELECT ANY TABLE...

SELECT ON [���̺� �̸�] TO [���� �̸�] -> Ư�� ���̺� ��ȸ�� �� �ִ� ����.
INSERT ON....
UPDATE ON....

- �����ڿ� ���ϴ� ������ �ο��ϴ� ����.
RESOURCE(�����ڿ�), CONNECT(����), DBA TO [���� �̸�]
*/

--DML : Data manipulation Lanaguage
--DCL : Data Control Language
--DDL : Data Definition Languate
--TCL : Transaction Control Language

-- ����� ���� Ȯ��
SELECT * FROM all_users;


-- ���� ���� ���
--CREATE USER ���̵� IDENTIFIED BY ��й�ȣ;
CREATE USER user1 IDENTIFIED BY user1;
--insufficient privileges : ���� ���� ���� ����.


--������ �� �� �׻� GRANT �� ����
GRANT CREATE SESSION TO user1;
--user1���� �����ͺ��̽� '����'������ ��

SELECT * FROM hr.departments;
--Ư�� ���̺� ���� ������ ���� ������ ��� ������ user1�� hr�� ���̺��� departments�� �Ժη� ��ȸ�� �� ����

GRANT SELECT ON hr.departments TO user1;
--select ������ �ְڴ�. hr.departments���̺�����! user1����

GRANT INSERT ON hr.departments TO user1;


--���̺��� �� ���Ƽ� ������ ���� �ֱ� ������ ��! ANY ���! (��� ���̺��̵� ��� ������ �ִ� ���!)


GRANT CREATE TABLE TO user1;

ALTER USER user1
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

GRANT SELECT ANY TABLE to user1;

GRANT RESOURCE, CONNECT, DBA TO user1;
--�����ڿ� ���� ������ ������ ���� �� ���� ��!

--������ ��� �ٽ� ���� ���(REVOKE)
REVOKE RESOURCE, CONNECT, DBA FROM user1;


-- ����� ���� ����
-- DROP USER [�����̸�] CASCADE;
-- CASCADE ���� �� -> ���̺� or ������ �� ��ü�� �����Ѵٸ� ���� ���� �ȵ�.
DROP USER user1;
DROP USER user1 CASCADE;



----------------------------------------------------------------

/*
���̺� �����̽��� �����ͺ��̽� ��ü �� ���� �����Ͱ� ����Ǵ� �����Դϴ�.
���̺� �����̽��� �����ϸ� ������ ��ο� ���� ���Ϸ� ������ �뷮��ŭ��
������ ������ �ǰ�, �����Ͱ� ���������� ����˴ϴ�.
�翬�� ���̺� �����̽��� �뷮�� �ʰ��Ѵٸ� ���α׷��� ������������ �����մϴ�.
*/

SELECT * FROM dba_tablespaces;

CREATE USER test1 IDENTIFIED BY test1;

GRANT CREATE SESSION TO test1;
GRANT CONNECT, RESOURCE TO test1;

--user_tablespace ���̺� �����̽��� �⺻ ��� �������� �����ϰ� ��뷮 ������ ��
ALTER user test1
DEFAULT TABLESPACE user_tablespace
QUOTA 10M ON user_tablespace; -- ����_���̺����̽� ��� ������ 10mb(k,m,g,t,unlimited)�� ����� �� �ִ� ������ �ִ� ��.


-- ���̺� �����̽� ���� ��ü�� ��ü ����(������ ����(����)�� �״�� ���ΰ�!)
DROP TABLESPACE user_tablespace INCLUDING CONTENTS;

-- ������ ���ϱ��� ����.
DROP TABLESPACE user_tablespace INCLUDING CONTENTS AND DATAFILES;






