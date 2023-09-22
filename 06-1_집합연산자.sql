
-- 집합 연산자
-- 서로 다른 쿼리 결과의 행들을 하나로 결합, 비교, 차이를 구할 수 있게 해 주는 연산자
-- UNION(합집합, 중복x), UNION ALL (합집합 중복 o), INTERSECT(교집합), MINUS(차집합)
-- 위 아래 column 개수와 데이터 타입이 정확히 일치해야 합니다.
-- 집합연산과 조인은 달라용! 조인은 정말 새로운 결과를 내보냄(테이블과 테이블이 합쳐져 내가 새로운 결과로 조회하는 것)
-- 집합연산자는 쿼리와 쿼리를 연산하는 것.(조회된 결과를 가지고 합치고 빼고 하는 것. 사용 목적이 다른 것임)

--UNION : 중복을 제거한 두 조회 결과의 합이 나옴.
-- 쿼리행 UNION 쿼리행;
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20;

-- UNION ALL : 중복을 제거하지 않은 두 결과의 합이 나옴
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20;

--INTERSECT : 두 쿼리의 결과를 비교하여 중복되는 데이터만 출력
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20;


--A-B 차집합 
--A 와 B에 중복되어있던 마이클을 제외한 A가 조회됨
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20;


-- B-A 차집합
-- 중복된 MICHAEL을 제외한 B의 결과가 출력됨.
SELECT
    employee_id, first_name
FROM employees
WHERE department_id LIKE 20
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';



--A^B: 배타적 차집합 ab합집합에서 교집합 뺀 부분



