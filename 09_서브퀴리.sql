/*
# �������� 
= ���� ����
- ������ �ɰų�, Ư�� ���̺��� �������� ���� �����ϰų� ���� �ϰ� ���� �� ����ϴ� ����
: SQL ���� �ȿ� �Ǵٸ� SQL ������ �����ϴ� ���
���� ���� ���Ǹ� ���ÿ� ó���� �� �ֽ��ϴ�.
WHERE, SELECT, FROM ���� �ۼ� ����.


- ���������� ������� () �ȿ� �����.
 ������������ �������� 1�� ���Ͽ��� �մϴ�.
- �������� ������ ���� ����� �ϳ� �ݵ�� ���� �մϴ�.
- �ؼ��� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.

- where, select, from �پ��� ���� ���� �� ����
- ����) ������ where���� �� �������� �ʴ� ��
*/

--'Nancy'�� �޿����� �޿��� ���� ����� �˻��ϴ� ����
SELECT salary FROM employees
WHERE first_name = 'Nancy';

SELECT first_name FROM employees
WHERE salary > 12008;
---->
SELECT first_name FROM employees
WHERE salary > (SELECT salary FROM employees
                WHERE first_name = 'Nancy');

-- employee_id �� 103���� ����� job_id�� ���� ����� ��ȸ.
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE employee_id = 103);

--������ ��������
--���������� ������ ����������. �� �ϳ��� �ุ �����ؾ���. �ٵ� ��� 5���� ������.
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG'); --����
-- ���� ������ ���������� �����ϴ� ���� ���� ���� ������ �����ڸ� ����� �� ����
-- �̷� ��쿡�� ������ �����ڸ� ����ؾ� �մϴ�.

-- ���� �� ������: �ַ� �񱳿����� ( = > < >= <= <>(->��������) )
-- ������ �����ڸ� ����ϴ� ��� ���������� �ݵ�� �ϳ��� �ุ�� ��ȯ�ؾ� ��.
-- ���� �� ������: (IN, ANY, ALL)
SELECT * FROM employees
WHERE job_id IN(SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG');
                
                
--IN ��ȸ�� ����� � ���� ������ Ȯ���մϴ�.
-- first_name�� David�� ������� �޿��� ���� �޿��� �޴� ������� ��ȸ.
SELECT * FROM employees
WHERE salary IN(SELECT salary FROM employees
                WHERE first_name = 'David');

                            



