
SELECT * FROM employees;


-- WHERE 절 비교 (데이터 값은 대/소문자를 구분합니다.)

--job_id 가 IT_PROG 인 레코드만 조회할 거임. 
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = 'IT_PROG'; --문자열이라서 홑따옴표로 씌운 것.


SELECT * FROM employees
WHERE last_name = 'King';


SELECT *
FROM employees
WHERE department_id = 90;

SELECT *
FROM employees
WHERE salary >= 15000 AND salary<20000 ;

-- 데이터 행 제한
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

SELECT * FROM employees
WHERE hire_date = '04/01/30';

-- IN 연산자의 사용 (특정 값들과 비교할 때 사용)
--매니저아이디가 100 101 102 인 사람만 조회하고 싶음(셋 중 하나에 해당하는 것)
--OR 키워드를 사용해도 상관없으나 코드가 길어져서 가독성 떨어짐
SELECT * FROM employees
WHERE manager_id IN (100, 101, 102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP');

-- LIKE 연산자
-- 유사한 데이터를 찾아내는 연산자
-- %는 아무 문자열 의미
-- _는 문자 하나를 의미.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '05%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%05';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '___05%';

--IS NULL (NULL 값을 찾음)
SELECT * FROM employees
WHERE manager_id IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NOT NULL;


-- AND, OR
-- AND가 OR 보다 연산 순서가 빠름
SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')
AND salary >= 6000;

-- 데이터의 정렬 (조회가 끝나고 마지막에 수행된다고 생각해!!)
--ORDER BY 기준_컬럼 (디폴트값 : ASC)
--SELECT  구문의 가장 마지막에 배치
--ASC: ascending 오름차순 (
--DESC: descending 내림차순
SELECT * FROM employees
ORDER BY hire_date;

SELECT * FROM employees
ORDER BY hire_date DESC;

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees
WHERE salary >= 5000
ORDER BY employee_id DESC;

--컬럼에 별칭을 붙였다면, 별칭으로 부르면 됨
SELECT
    first_name,
    department_id,
    salary*12 AS pay
FROM employees
WHERE job_id LIKE 'IT_PROG'
ORDER BY pay ASC;








