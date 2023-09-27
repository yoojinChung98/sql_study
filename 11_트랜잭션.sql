
/*
DML
DATE MANAGER LANGUAGE
= select, insert, update, delete
*/

--� �ϳ��� �۾��� �ϳ��� ���������� �̷����� ���� ���� ����.

--DBMS�� ���� COMMIT �� �ڵ������Ǿ� �ִ� DBMS���� ����! �װ��� Ȯ���ϴ� ������.
--����Ŀ�� ���� Ȯ��
--����Ŀ���� �Ҵ� = Ʈ������� ���� �ʰڴٴ� �ǹ�(�� ���������� Ŀ���� ����Ǳ� ����)
SHOW AUTOCOMMIT;
--����Ŀ�� ��
SET AUTOCOMMIT ON;
--����Ŀ�� ����
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (304, 'lee', 'lee1234@gmail.com', sysdate, 1800);
    
DELETE FROM emps WHERE employee_id = 304;

--�������� ��� ������ ��������� ���(���)
--���� Ŀ�� �ܰ�� ȸ��(���ư���) �� Ʈ����� ����.
--ROLLBACK ��Ű�� savepoint ���� ���ư�!!
ROLLBACK;
--insert �ߴµ� ��?? �ƳľƳ� �Ǽ�����!! �� �� �ѹ� ���.
-- �츮�� ���⿡�� ���� DB�� ����� �� ���� ����������! ����� Ȯ������ ���� ��!???
-- ���� DB�� �ݿ��Ǵ� ���� �ƴ�!! 

-- �������� ��� ������ ���� ������ ���������� �����ϸ鼭 Ʈ����� ����.
-- Ŀ�� �Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� �����ϴ�.
COMMIT;



--Ŀ�� ������ �����ؼ� ���ư� �� ����.
--����Ŭ���� ���� (ANSI ǥ�� ������ �ƴ� �� �ٸ� DBMS���� ���� ���ɼ� ���ĳ���)
--ROLLBACK ��Ű�� savepoint ���� ���ư�!! ���̺�����Ʈ�� ���� ��������� ���ܳ��� �� ��
-- �ᱹ ���ƿ��� ������ �ϳ� ����� �� ��, �� ����͵� Ŀ�Ե����� ����

--���� ���߿� ����� ���ƿ� �� ������... ���̺�����Ʈ�� ������ ���ڴ�!!!
-- ���̺�����Ʈ ����
-- �ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����
-- ANSI ǥ�� ������ �ƴϱ� ������ �׷��� ���������� ����.
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

--ROLLBACK TO SAVEPOINT ���̺�����Ʈ_��;
ROLLBACK TO SAVEPOINT insert_park;

