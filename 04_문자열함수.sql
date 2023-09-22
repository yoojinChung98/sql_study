
--dual
/*
dual�̶�� ���̺��� sys(�ֻ��� ������)�� �����ϴ� ����Ŭ�� ǥ�� ���̺�μ�,
���� �� �࿡ �� �÷��� ��� �ִ� dummy ���̺� �Դϴ�.
�Ͻ����� ��� �����̳� ��¥ ���� ���̳�.
�Լ��� ����� ���캸�� ���� **�׽�Ʈ ���̺�**�� ����.
��� ����ڰ� ������ �� �ֽ��ϴ�.
*/
SELECT * FROM dual;


-- lower(�ҹ���), initCap(�ձ��ڸ� �빮��), upper(�빮��)
SELECT 
    'abcDEF', lower('abcDEF'), initCap('abcDEF'), upper('abcDEF')
FROM
    dual;
    

SELECT
    last_name,
    LOWER(last_name),
    INITCAP(last_name),
    UPPER(last_name)
FROM employees;

--�ش� �Լ� Ȱ�� ���: ������ ���ڿ��� ��ҹ��ڸ� �����ϱ� ������ �ϳ��� ���Ͻ��� ���� �� ����� ���� ������.
SELECT last_name FROM employees
WHERE LOWER(last_name) = 'austin';

--length(����), instr(����ã��, ������ 0�� ��ȯ, ������ �ε��� ��(1���� ����))
SELECT
    'abcdef', LENGTH('abcdef'), INSTR('abcdef','a')
FROM dual;

SELECT
    first_name, LENGTH(first_name), INSTR(first_name, 'a')
FROM employees;


--substr(���ڿ�, ���� �ε���, ������� )���ڿ� ����, concat(���� ����)
-- concat�� �Ű������� �ΰ��� ����, 3�� �̻� �����ϰ� ������ || �����ڸ� ����ؾ� ��
SELECT
    'abcdef' AS ex,
    SUBSTR('abcedf', 1, 4),
    CONCAT('abc', 'def')
FROM dual;

SELECT
    first_name,
    SUBSTR(first_name,1,3),
    CONCAT(first_name, last_name)
FROM employees;

--LPAD, RPAD (��, ������ ���� ���ڿ��� ä���)
--LPAD(���� ���ڿ�, �� ���ڿ� ����, ä�� ���ڿ�) ���ʺ��� ä��
--�ַ� �̸�/ �ֹε�Ϲ�ȣ�� ���� �� �����.
SELECT
    LPAD('abc',2, '*'),
    LPAD('abc',10, '*/'),
    RPAD('abd', 10, '*'),
    RPAD('abc',2, '*')
FROM dual;

-- LTRIM(), RTRIM(): ������ ���� ã�Ƽ� �����ִ� �Լ�
-- TRIM() �� ���� ������� �������ִ� �Լ�

--LTIRM(param1, param2) -> param2�� ���� param1���� ã�Ƽ� ���� (���ʺ���)
--LTIRM(param1, param2) -> param2�� ���� param1���� ã�Ƽ�  ���� (�����ʺ���)
SELECT LTRIM('javascript_java', 'java') FROM dual;
SELECT RTRIM('javascript_java', 'java') FROM dual;
SELECT RTRIM('javascript_java', '_') FROM dual; --�̰� �ȵȴ�?
SELECT TRIM(' j av  a   ') FROM dual;

--replace() ���� ���ڿ��� �� ���ڿ��� ��ü�ϴ� �Լ�
SELECT
    REPLACE('My dream is a president', 'president', 'programmer')
FROM dual;
--����� ���� ���ſ��� ����� �� ����.
SELECT
    REPLACE(' ja v  a  ', ' ', '')
FROM dual;

SELECT
    REPLACE(CONCAT('hello', ' world!'), REPLACE(' !  ',' ',''), '?')
FROM dual;

---------------------------------------------------------------
/*
���� 1.
EMPLOYEES ���̺��� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
*/
SELECT
    CONCAT(CONCAT(first_name,' '),last_name) AS �̸�,
    REPLACE(hire_date,'/','') AS �Ի�����
FROM employees
ORDER BY �̸�;
-- ���� �� �ٿ��� ��Ī���� �����ϱ�!

/*
���� 2.
EMPLOYEES ���̺��� phone_number�÷��� ###.###.####���·� ����Ǿ� �ִ�
���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� 
��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���. (CONCAT, SUBSTR, LENGTH ���)
*/
SELECT
    CONCAT('(02)',SUBSTR(phone_number,5)) AS ��ȭ��ȣ,
    REPLACE(CONCAT('(02)',SUBSTR(phone_number,5)),'.','-') AS ��ȭ��ȣ2
FROM employees;


/*
���� 3. 
EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
*/
SELECT
    RPAD(SUBSTR(first_name,1,3),LENGTH(first_name),'*') AS name,
    LPAD(salary, 10, '*')
FROM employees
WHERE LOWER(job_id) = 'it_prog';


