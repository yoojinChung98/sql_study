/*
# 서브쿼리 
= 하위 쿼리
- 조건을 걸거나, 특정 테이블을 쿼리문을 통해 조정하거나 등을 하고 싶을 때 사용하는 쿼리
: SQL 문장 안에 또다른 SQL 문장을 포함하는 방식
여러 개의 질의를 동시에 처리할 수 있습니다.
WHERE, SELECT, FROM 절에 작성 가능.


- 서브쿼리의 사용방법은 () 안에 명시함.
 서브쿼리절의 리턴행이 1줄 이하여야 합니다.
- 서브쿼리 절에는 비교할 대상이 하나 반드시 들어가야 합니다.
- 해석할 때는 서브쿼리절 부터 먼저 해석하면 됩니다.

- where, select, from 다양한 곳에 넣을 수 있음
- ㅇ예) 조건절 where에서 딱 떨어지지 않는 값
*/

--'Nancy'의 급여보다 급여가 많은 사람을 검색하는 문장
--Nancy의 급여, ~보다 급여가 많은 사람. 둘 다 조회를 통해 정보를 얻어내야 하는 상황 -> 아! 하나는 서브쿼리로 써야징~
SELECT salary FROM employees
WHERE first_name = 'Nancy';

SELECT first_name FROM employees
WHERE salary > 12008;
---->
SELECT first_name FROM employees
WHERE salary > (SELECT salary FROM employees
                WHERE first_name = 'Nancy');


-- employee_id 가 103번인 사람의 job_id를 가진 사람을 조회.
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE employee_id = 103);


--단일행 서브쿼리
--서브쿼리는 단일행 서브쿼리임. 단 하나의 행만 리턴해야함. 근데 얘는 5행을 리턴함.
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG'); --에러
-- 다음 문장은 서브쿼리가 리턴하는 행이 여러 개라서 단일행 연산자를 사용할 수 없음
-- 이런 경우에는 다중행 연산자를 사용해야 합니다.

-- 단일 행 연산자: 주로 비교연산자 ( = > < >= <= <>(->같지않음) )
-- 단일행 연산자를 사용하는 경우 서브쿼리는 반드시 하나의 행만을 반환해야 함.
-- 다중 행 연산자: (IN, ANY, ALL)
SELECT * FROM employees
WHERE job_id IN(SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG');
                
                
--IN 조회된 목록의 어떤 값과 같은지 확인합니다.
-- first_name이 David인 사람들의 급여와 같은 급여를 받는 사람들을 조회.
SELECT employee_id, first_name, job_id, salary FROM employees
WHERE salary IN(SELECT salary FROM employees
                WHERE first_name = 'David');

--ANY, SOME: 값을 서브쿼리에 의해 리턴된 각각의 값과 비교합니다.
-- 하나라도 만족하면 됩니다.
SELECT employee_id, first_name, job_id, salary FROM employees
WHERE salary > ANY(SELECT salary FROM employees
                WHERE first_name = 'David');
                
--ALL : 값을 서브쿼리에 의해 리턴된 각각의 값과 모두 비교함
-- 모두 만족해야 함
SELECT employee_id, first_name, job_id, salary FROM employees
WHERE salary > ALL(SELECT salary FROM employees
                WHERE first_name = 'David');


--EXISTS: 서브쿼리가 하나 이상의 행을 반환하면 참으로 간주
-- JOIN 으로도 할 수 있는데 EXIST를 써서 이렇게도 쿼리문을 작성할 수 있다~
-- job_history에 존재하는 직원이 employees에도 존재한다면 조회에 포함.
SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM job_history jh
             WHERE e.employee_id = jh.employee_id);
-- SELECT 1은 안에 있는 데이터의 세부내용은 궁금하지 않다는 상징적인 의미.
-- 그니까 쿼리를 돌려야해서 SELECT에 뭘 써야하는데... 세부내용은 별로 필요하지 않단 말이지.. 그때 1을 상징적인 의미로써 채워넣는데 사용함.

--EXISTS는 참인지 거짓인지만 체크하는 것.
SELECT * FROM employees
WHERE EXISTS (SELECT 1 FROM departments
                WHERE department_id = 200);
                
-------------------------------------------------

--SELECT 절에 서브쿼리를 붙이기

SELECT
    e.first_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

--조인을 쓰지 않아도 조인 결과와 비슷하게 결과를 낼 수 있다구???
--컬럼이 들어갈 자리에 괄호를 열어서 서브쿼리 작성.
--이를 스칼라 서브쿼리(Scalar Subquery)라고 칭함
-- 스칼라 서브쿼리: 실행 결과가 단일 값을 반환하는 서브쿼리. 주로 SELECT 절이나 WHERE 절에서 사용됨.
SELECT
    e.first_name,
    (
        SELECT
            department_name
        FROM departments d
        WHERE d.department_id = e.department_id
    ) AS department_name
FROM employees e
ORDER BY first_name ASC;
/*
-- 한 행당 한번씩 서브쿼리부분이 계속 한번씩 수행되는 것.
1. FROM employees e
2. SELECT e.first_name, (서브 쿼리), 한 행 출력, e_first_name, (서브쿼리), 한 행 출력... 107번.
즉, 안쪽에 있는 쿼리문이 매 행마다 반복실행되는 것
따라서 SELECT 안쪽에 작성하는 서브쿼리는 JOIN과 매우 유사함
*/
/*
- 스칼라 서브쿼리가 조인보다 좋은 경우
: 함수처럼 한 레코드당 정확히 하나의 값만을 리턴할 때.

- 조인이 스칼라 서브쿼리보다 좋은 경우
: 조회할 컬럼이나 데이터가 대용량인 경우, 해당 데이터가
수정, 삭제 등이 빈번한 경우 (sql 가독성의 측면에서 조인이 조금 더 뛰어남)
*/


-- 각 부서의 매니저 이름 조회
-- LEFT JOIN
SELECT
    d.*,
    e.first_name
FROM departments d
LEFT OUTER JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

SELECT
    d.*,
    (
        SELECT e.first_name
        FROM employees e
        WHERE e.employee_id = d.manager_id
    ) AS manager_name
FROM departments d
ORDER BY d.manager_id ASC;

-- 각 부서별 사원 수 뽑기
SELECT
    d.*,
    (
        SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id
    ) AS 사원수
FROM departments d;

SELECT
    --d.*, --에러 뜸.
    d.department_id,
    COUNT(*)
FROM departments d
LEFT JOIN employees e
ON  e.department_id = d.department_id
GROUP BY d.department_id;


-------------------------------------

-- 인라인 뷰 (FROM 구문에 서브쿼리가 오는 것.)
-- 특정 테이블 전체가 아닌 SELECT를 통해 일부 데이터를 조회한 것을 가상 테이블(=뷰)로 사용하고 싶을 때!
-- '순번을 정해놓은 조회 자료를 범위를 지정해서 가지고 오는 경우'

SELECT
    ROWNUM AS rn, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC
WHERE rn BETWEEN 1 AND 10;
-- ROWNUM 을 붙이고 난 뒤(SELECT 이후) ORDER BY로 정렬해버려서 ROWNUM의 순서가 틀어짐.
-- 조회하고 정렬까지 끝낸 다음에 ROWNUM 을 나중에 붙여버리자!

-- salary로 정렬을 진행하면서 바로 ROWNUM을 붙이면
-- ROWNUM이 정렬이 되지 않는 상황이 발생합니다.
-- 이유: ROWNUM이 먼저 붙고 정렬이 진행되기 때문. ORDER BY는 항상 마지막에 진행.
-- 해결: 정렬이 미리 진행된 자료에 ROWNUM을 붙여서 다시 조회하는 것이 좋을 것 같아요.

        SELECT *
        FROM
            (
            SELECT
                ROWNUM AS rn,
                tbl.*
            FROM (
                SELECT
                employee_id, first_name, salary
                FROM employees
                ORDER BY salary DESC
            ) tbl
        )
        WHERE rn > 0 AND rn <= 10;

/*
-문제점-
1.ORDER BY가 가장 후순위이므로 ROWNUM을 붙여놓은 것을 다시 salary 기준으로 재정렬하여 ROWNUM 활용 불가능
2. ROWNUM의 값을 기준으로 WHERE 걸려고 해도 sql 실행순서로 인해 아직 생성되지 않은 ROWNUM으로 WHERE로 조건을 걸 수 없음.

-문제 해결-
1. ORDER BY를 통해 salary 기준으로 정렬한 테이블을
2. 정렬된 테이블에 ROWNUM을 새로 붙인 테이블을
3. 조건을 붙여서 걸러냈다!
*/

/*
가장 안쪽 SELECT 절에서 필요한 테이블 형식(인라인 뷰)을 생성.
바깥쪽 SELECT 절에서 ROWNUM을 붙여서 다시 조회
가장 바깥쪽 SELECT 절에서는 이미 붙어있는 ROWNUM의 범위를 지정해서 조회.

** SQL의 실행 순서
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

-- 이 쿼리문은 게시판 등 페이징에 사용됨.
*/










