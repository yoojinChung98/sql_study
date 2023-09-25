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
SELECT * FROM employees
WHERE salary IN(SELECT salary FROM employees
                WHERE first_name = 'David');

                            



