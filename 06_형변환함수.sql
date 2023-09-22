
-- 형 변환 함수 TO_CHAR, TO_NUMBER, TO_DATE

-- 날짜를 문자로 TO_CHAR(값, 형식)
SELECT TO_CHAR(sysdate) FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD DY PM HH:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS') FROM dual;

-- 서식문자와 함께 사용하고 싶은 문자를 ""로 묶어 전달함.
-- 서식 문자가 아닌 문자를 표현하고 싶으면 쌍따옴표를 씌워줘야 함.
SELECT
    first_name,
    TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일"')
FROM employees;


-- 숫자를 문자로 TO_CHAR(값, 형식)
-- 형식에서 사용하는 9 -> 숫자 자릿수를 표현하는 기호
SELECT TO_CHAR(20000, '99999') FROM dual;
--실수부는 자동 반올림
SELECT TO_CHAR(20000.29, '99999.9') FROM dual;
-- 숫자 관련 문자도 함께 표현 가능(원=L(SQL Develpoer에서 지정한 단위(우린 한글로 설정했으니까))) (이런 문자가 들어가면 추후 연산 불가.)
SELECT TO_CHAR(20000, '$99,999') FROM dual; 
SELECT TO_CHAR(salary, 'L99,999') AS salary FROM employees;
--##### 주어진 자릿수로 지정숫자를 표현할 수 없을 때 
SELECT TO_CHAR(20000, '9999') FROM dual; 



--문자를 숫자로 TO_NUMBER(값, 형식)
SELECT '3300' + 2000 FROM dual; --자동 형 변환 (문자 -> 숫자)
SELECT TO_NUMBER('3300') + 2000 FROM dual; --명시적 형 변환
--즉, 문자가 순수한 숫자로 이루어져 있다면, TO_NUMBER을 부르지 않아도 자동 형변환.
SELECT '$3,300' + 2000 FROM dual; -- 순수한 숫자가 아니므로 자동 형변환 불가
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 FROM dual;


-- 문자를 날짜로 변환하는 함수 TO_DATE(값, 형식)
SELECT TO_DATE('2023-04-13') FROM dual;
SELECT sysdate - TO_DATE('2021-03-26') FROM dual; -- 연산을 위해서 형식을 날짜형식으로 변환해야 함.
SELECT TO_DATE('2020/12/25', 'YY-MM-DD') FROM dual;
SELECT TO_DATE('2021-03-31 12:23:50' , 'YYYY-MM-DD HH:MI:SS') FROM dual;
-- 참고로 주어진 문자열의 형태를 끝까지 모두 알려줘야 한다 'YYYY-MM-DD'이러고 끝내버리면 안된다!
SELECT TO_CHAR(TO_DATE('23년4월13일','YY"년"MM"월"DD"일"')+10,'YYYY-MM-DD') FROM dual;



SELECT
    TO_DATE('2023-04-13'),
    sysdate - TO_DATE('2023-04-13'),
    TO_DATE('23년4월13일','YY"년"MM"월"DD"일"')
FROM dual;



--NULL 의 형태를 변환하는 함수 NVL(컬럼, 변환할_타겟값)
-- 타겟값은 지정 컬럼의 데이터타입만 넣을 수 있음
SELECT NULL FROM dual;
SELECT NVL(NULL, 0) FROM dual;

SELECT
    first_name,
    NVL(commission_pct, 0) AS comm_pct
FROM employees;

--NULL 변환 함수 NVL2(컬럼, null이 아닐 경우의 값, null일 경우의 값)
SELECT
    NVL2('abc', '널아님', '널임')
FROM dual;

SELECT
    first_name,
    NVL2(commission_pct, TO_CHAR(commission_pct, '0.99') , '보너스 없음')
FROM employees;

SELECT
    first_name,
    commission_pct,
    salary,
    NVL2(
        commission_pct,
        salary+(salary*commission_pct),
        salary
    ) AS real_salary
FROM employees;

-- NULL 이 연산에 들어가면 전부 다 NULL이 되어버림...
SELECT
    first_name,
    salary,
    salary + (salary * commission_pct)
FROM employees;


--DECODE( 컬럼/표현식, 항목1,결과1, 항목2,결과2  ........  default결과 )
--switch case와 비슷함.
--default값을 쓰지 않으면 null 값이 옴
SELECT
    DECODE(
        'B',
        'A', 'A입니다.',
        'B', 'B입니다.',
        'C', 'C입니다.',
        '뭔지 모르겠읍니다;;'
    )
FROM dual;

SELECT
    job_id,
    salary,
    DECODE(
        job_id,
        'IT_PROG', salary*1.1,
        'FI_MGR', salary*1.2,
        'AD_VP', salary*1.3
    ) AS result
FROM employees;


-- CASE WHEN THEN END
-- case 기준_칼럼 when 기준1 then 수행식, else 디폴트 END
-- else 를 작성하지 않으면 null 값이 옴
SELECT 
    first_name,
    job_id,
    salary,
    (CASE job_id
        WHEN 'IT_PROG' THEN salary*1.1
        WHEN 'FI_MGR' THEN salary*1.2
        WHEN 'AD_VP' THEN salary*1.3
        Else salary
    END) AS result
FROM employees;




/*
문제 1.
현재일자를 기준으로 employees테이블의 입사일자(hire_date)를 참조해서 근속년수가 17년 이상인
사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다
*/
SELECT
    employee_id AS 사원번호,
    CONCAT(first_name, last_name) AS 사원명,
    hire_date AS 입사일자,
    TRUNC((sysdate-hire_date)/365) AS 근속년수
FROM employees
WHERE (sysdate - hire_date)/365 >= 17
ORDER BY 근속년수 DESC;

/*
sql 실행순서 때문에 where에서 별칭을 부를 수 없었음
1. From절 : 일단 테이블을 정한 뒤
2. WHERE절: 조건을 먼저 검 -> 여기서 SELECT에서 정한 별칭은 아직 정보가 없음
3. GROUP-BY절
4. HAVING절
5. SELECT절: 조건식에 따라 데이터가 걸러진 뒤 내가 지정한 컬럼이 조회됨.
6. ORDER BY절: 조회한 조건을 정렬/ 별칭이 결정된 뒤 오는 순서이므로 별칭 사용 가능
*/

/*
문제 2.
EMPLOYEES 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
100이라면 ‘사원’, 
120이라면 ‘주임’
121이라면 ‘대리’
122라면 ‘과장’
나머지는 ‘임원’ 으로 출력합니다.
조건 1) department_id가 50인 사람들을 대상으로만 조회합니다
*/

SELECT
    first_name AS 사원성씨,
    manager_id AS 매니저아이디,
    /*
    (CASE manager_id
        WHEN 100 THEN '사원'
        WHEN 120 THEN '주임'
        WHEN 121 THEN '대리'
        WHEN 122 THEN '과장'
        ELSE '임원'
    END)AS 직급
    */
    DECODE(manager_id,
        100, '사원',
        120, '주임',
        121, '대리',
        122, '과장',
        '임원'
    ) AS 직급
FROM employees
WHERE department_id = 50;



