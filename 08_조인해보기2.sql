SELECT * FROM info;
SELECT * FROM auth;

-- �̳�(����)����
SELECT
    *
FROM info i INNER JOIN auth a
ON i.auth_id = a.auth_id;

-- ����Ŭ ���� (���� ������ ����)
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id;


-- auth_id �÷��� �׳� ���� ��ȣ�ϴ� ��� ��ϴ�.
-- �� ������ ���� ���̺� ��� �����ϱ� �����Դϴ�.
-- �̷� ����, �÷��� ���̺� �̸��� ���̴���, ��Ī�� ���ż�
-- Ȯ���ϰ� ������ ���ּ���.
SELECT
    info.auth_id, title, content, name
FROM info
JOIN auth -- �׳� JOIN �̶�� ���� �⺻������ INNER JOIN �� ��.
ON info.auth_id = auth.auth_id;

-- �ʿ��� �����͸� ��ȸ�ϰڴ�!
-- WHERE ������ ���� �Ϲ� ������ �ɾ��� �� ����.
SELECT
    i.auth_id, title, content, name
FROM info i
INNER JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.name = '�̼���';

-- �ƿ��� (�ܺ�) ����
SELECT
    *
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

SELECT
    *
FROM info i , auth a
WHERE i.auth_id = a.auth_id(+);

-- ���� ���̺�� ���� ���̺� �����͸� ��� �о� �ߺ��� �����ʹ� �����Ǵ� �ܺ� ����
SELECT
    *
FROM info i FULL JOIN auth a
ON i.auth_id = a.auth_id;

-- CROSS JOIN�� JOIN ������ �������� �ʱ� ������ �ܼ��� ��� �÷��� ���� JOIN�� ����
-- �����Ͱ� ����ϰ� �ǹ̰� ���� ������ �����δ� ���� ������� ����.
SELECT
    *
FROM info
CROSS JOIN auth
ORDER BY id ASC;

-- ���� �� ���̺� ���� -> ���������� ���� �ִ� key ���� ã�Ƽ� ������ �����ؼ� ���� ��
SELECT
    *
FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations loc ON d.location_id = loc.location_id;


/*
- ���̺� ��Ī a, i�� �̿��Ͽ� LEFT OUTER JOIN ���.
- info, auth ���̺� ���
- job �÷��� scientist�� ����� id, title, content, job�� ���.
*/

SELECT
    i.id, i.title, i.content, a.job
FROM auth a
LEFT OUTER JOIN info i ON a.auth_id = i.auth_id
WHERE a.job = 'scientist';

--self join
-- ���� �����̶� ���� ���̺� ������ ������ ���մϴ�.
-- ���� ���̺� �÷��� ���� ������ �����ϴ� ���� ��Ī���� ������ �� ����մϴ�.
SELECT
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.employee_id
FROM employees e1
INNER JOIN employees e2
ON e1.manager_id = e2.employee_id
ORDER BY e1.employee_id ASC;


-----------------------





