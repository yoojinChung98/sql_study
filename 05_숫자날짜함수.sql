
-- �����Լ�
-- ROUND(�Ǽ�, �Ҽ������� � �ٱ�?)
-- ���ϴ� �ݿø� ��ġ�� �Ű������� ����. ������ �ִ� �͵� ����
SELECT
    ROUND(3.1415, 3), ROUND(45.923, 0), ROUND(45.923, -1)
FROM dual;


--TRUNC(�Ǽ�, �Ҽ�������_����)
-- ������ �Ҽ��� �ڸ������� �߶���ϴ�.
SELECT
    TRUNC(3.1415, 3), TRUNC(45.923, 0), TRUNC(45.923, -1)
FROM dual;


-- ABS(�Ǽ�)
-- ���밪 ���ϴ� �Լ�
SELECT ABS(-34) FROM dual;


-- CEIL(�Ǽ�): �����η� �ø�, FLOOR(�Ǽ�): �����η� ����
SELECT CEIL(3.14), FLOOR(3.14)
FROM dual;


-- MOD(�Ǽ�, ����_��) : ������
SELECT 10/4, MOD(10.1, 4)
FROM dual;


--------------------------------------------------------------

--��¥ �Լ�
--sysdate: ��ǻ���� ��¥ ������ �����ͼ� �����ϴ� �Լ�
--(����-ȯ�漳��-�����ͺ��̽�-NLS���� ���� ���� ����, �ð��������� ������ �ֱ� ��)
--systemstamp : ��ǻ���� ��¥-�ð� ������ �����ͼ� �����ϴ� �Լ�(�����ʱ��� ����)
SELECT sysdate FROM dual;
SELECT systimestamp FROM dual;

-- ��¥�� ������ �����մϴ�. (��¥�� ���ϴ� ��)
SELECT sysdate + 1 FROM dual;

--��¥ Ÿ�԰� ��¥ Ÿ���� ���� ������ �����մϴ�. (������ ������� �Ⱓ�� �ǹ�)
--������ ������� ����.(������ ������ ���ϴ� ������ �ƴϴϱ�)
SELECT first_name, sysdate - hire_date
FROM employees;
-- �� ���� ����� ��, �� Steven 7402�� �ٹ��� ��.

SELECT first_name, hire_date,
    (sysdate - hire_date) / 7 AS week
FROM employees;
-- �� ���� ǥ���� ��

SELECT first_name, hire_date,
    (sysdate - hire_date) / 365 AS year
FROM employees;
-- �� ���� ǥ���� ��



--ROUND(��¥, '����')
--��¥ �ݿø�, ����
--��¥ �ݿø��� ���� ����Ʈ�� �ð�
--������ �������� ��¥ �ݿø��� ��.
SELECT ROUND(sysdate) FROM dual;
--�� �������� �ݿø� (���� ù��° ���� �Ͽ�����, ��-ȭ ��-�� / �ش� ���� �Ͽ��� ��¥)
--�� �������� �ݿø�(�ش� ���� �Ͽ��� ��¥)
SELECT ROUND(sysdate, 'day') FROM dual;
--�� �������� �ݿø�
SELECT ROUND(sysdate, 'month') FROM dual;
--�� �������� �ݿø�
SELECT ROUND(sysdate, 'year') FROM dual;


SELECT TRUNC(sysdate) FROM dual;
SELECT TRUNC(sysdate, 'day') FROM dual;
SELECT TRUNC(sysdate, 'month') FROM dual;
SELECT TRUNC(sysdate, 'year') FROM dual;



