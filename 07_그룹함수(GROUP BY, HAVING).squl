
-- 그룹 함수, AVG, MAX, MIN, SUM, COUNT(컬럼)
--즉, 그룹화가 되어 있어야 사용할 수 있다는 것!(갑자기 최대값이 얼마죠? 하면.. 뭐... 뭐의 최대값...?)
--그룹화를 따로 진행하지 않으면, 전체 데이터를 디폴트 그룹으로 잡아서 계산한 데이터를 하나 뱉어냄. 되는 것(즉, 전 데이터의 컬럼이 자동으로 그룹이 되는 것)
SELECT
    AVG(salary) AS AVG,
    COUNT(commission_pct) AS CNT,
    MAX(salary) AS max,
    MIN(salary) as min,
    SUM(salary) as sum,
    STDDEV(salary) as stddev,
    VARIANCE(salary) as variance
FROM employees;

--COUNT(세고자 하는 컬럼)
--* : 총 데이터 행의 갯수
-- NULL값은 갯수로 안쳐줍니당!~
SELECT COUNT(*) FROM employees; -- 총 행 데이터의 수
SELECT COUNT(first_name) FROM employees; 
SELECT COUNT(commission_pct) FROM employees; --NULL이 아닌 행의 갯수
SELECT COUNT(manager_id) FROM employees; --NULL이 아닌 행의 갯수



-- 부서별로 그룹화, 그룹함수의 사용
-- 그룹으로 지정해서 각 그룹의 salary 평균을 구해서 한 행씩 뽑아내는 것.
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id;

--주의할 점
--그룹 함수는 일반 컬럼과 동시에 그냥 출력할 수는 없음
--당연하지, 왜냐면 봐봐, 출력되는 행 갯수부터가 차이가 있어 (너는 이거 합칠 수 있어? 니도 못하는걸 왜 얘한테 시켜...?)
-- department_id는 지금 조건이 없으니까 모든 사원의 id행이 총 107번 나오겠지
-- AVG(salary)는 만약 GROUP BY를 하지 않으면 디폴트그룹이 '*총 직원' 이 되는거라서 데이터 한 행만 나오겠지
-- AVG(salary) GROUP BY department_id  -> department_id를 기준으로 그룹을 나누어서 각 그룹의 평균의 데이터를 한 행씩 뱉어냄.
-- 중복 제거라기 보다는 종류를 쫙 뽑아주는 것.
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY salary; --에러


--GROUP BY절을 사용할 때 GROUP 절에 묶이지 않으면 다른 컬럼을 조회할 수 없습니다.
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id; -- 에러

-- GROUP BY절을 두 개 이상 사용할 때
-- 이 경우 조건이 AND로 묶이는 것 같은 느낌.
-- 이래서.. 그룹화를 세개 이상 하는 것부터는 좀 의미가 없는거지....
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

--GROUP BY를 통해 그룹화 할 때 조건을 걸 경우 WHERE 말고 HAVING을 사용
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id -- 데이터를 하나하나 뽑지말고 department_id를 기준으로 그룹화해서 하나씩만 뽑아
HAVING SUM(salary) > 100000;  -- 근데 각 그룹들의 salary의 합이 >100000 인 것만 출력해



SELECT
    job_id,
    COUNT(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5;


-- 부서 아이디가 50 이상인 것들을 그룹화 시키고, 그룹 월급 평균이 5000 이상 만 조회.
SELECT
    department_id AS 부서번호,
    AVG(salary) AS 평균
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id DESC;


/*
문제 1.
사원 테이블에서 JOB_ID별 사원 수를 구하세요.
사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
*/
SELECT
    job_id,
    COUNT(*) AS 사원수
    --COUNT(job_id) 로 했었음 나는....
FROM employees
GROUP BY job_id;

SELECT
    job_id,
    AVG(salary) AS 월급_평균
FROM employees
GROUP BY job_id
ORDER BY 월급_평균 DESC;


/*
문제 2.
사원 테이블에서 입사 년도 별 사원 수를 구하세요.
(TO_CHAR() 함수를 사용해서 연도만 변환합니다. 그리고 그것을 그룹화 합니다.)
*/
-- 결과값이 같다고 과정이 무시되는게 아니라서 안되는거야...
-- 그룹화 하는데 함수를 사용했다? select 할 때는 그룹화 했던 똑같은 내용만 넣어야 하는 거야.
SELECT
    SUBSTR(hire_date,1,2) AS 입사년도,
    COUNT(hire_date) AS 사원수
FROM employees
GROUP BY SUBSTR(hire_date,1,2);
/*
SELECT
    TO_CHAR(hire_date,'YYYY') AS 입사년도,
    COUNT(*) AS 사원수
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY');
*/


/*
문제 3.
급여가 5000 이상인 사원들의 부서별 평균 급여를 출력하세요. 
단 부서 평균 급여가 7000이상인 부서만 출력하세요.
*/
SELECT
    NVL2(department_id,
        TO_CHAR(department_id),
        '부서 미배정'
    )AS 부서번호,
    AVG(salary) AS 평균급여
FROM employees
WHERE salary>=5000
GROUP BY department_id
HAVING AVG(salary) >= 7000;


/*
문제 4.
사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
*/

SELECT
    NVL2(department_id, TO_CHAR(department_id), '부서 없음') AS 부서명,
    TRUNC(AVG(salary+salary*commission_pct),2) AS 월급평균,
    SUM(salary+salary*commission_pct) AS 월급합계,
    COUNT(*) AS 부서인원
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;









