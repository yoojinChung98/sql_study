
--dual
/*
dual이라는 테이블은 sys(최상위 관리자)가 소유하는 오라클의 표준 테이블로서,
오직 한 행에 한 컬럼만 담고 있는 dummy 테이블 입니다.
일시적인 산술 연산이나 날짜 연산 등이나.
함수의 기능을 살펴보기 위한 **테스트 테이블**로 사용됨.
모든 사용자가 접근할 수 있습니다.
*/
SELECT * FROM dual;


-- lower(소문자), initCap(앞글자만 대문자), upper(대문자)
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

--해당 함수 활용 방법: 조건의 문자열은 대소문자를 구분하기 때문에 하나로 통일시켜 비교할 때 경우의 수가 적어짐.
SELECT last_name FROM employees
WHERE LOWER(last_name) = 'austin';

--length(길이), instr(문자찾기, 없으면 0을 반환, 있으면 인덱스 값(1부터 시작))
SELECT
    'abcdef', LENGTH('abcdef'), INSTR('abcdef','a')
FROM dual;

SELECT
    first_name, LENGTH(first_name), INSTR(first_name, 'a')
FROM employees;


--substr(문자열, 시작 인덱스, 추출길이 )문자열 추출, concat(문자 연결)
-- concat은 매개변수를 두개만 받음, 3개 이상 연결하고 싶으면 || 연결자를 사용해야 함
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

--LPAD, RPAD (좌, 우측을 지정 문자열로 채우기)
--LPAD(기존 문자열, 총 문자열 갯수, 채울 문자열) 왼쪽부터 채움
--주로 이름/ 주민등록번호를 가릴 때 사용함.
SELECT
    LPAD('abc',2, '*'),
    LPAD('abc',10, '*/'),
    RPAD('abd', 10, '*'),
    RPAD('abc',2, '*')
FROM dual;

-- LTRIM(), RTRIM(): 지정한 값을 찾아서 없애주는 함수
-- TRIM() 양 끝의 공백들을 제거해주는 함수

--LTIRM(param1, param2) -> param2의 값을 param1에서 찾아서 제거 (왼쪽부터)
--LTIRM(param1, param2) -> param2의 값을 param1에서 찾아서  제거 (오른쪽부터)
SELECT LTRIM('javascript_java', 'java') FROM dual;
SELECT RTRIM('javascript_java', 'java') FROM dual;
SELECT RTRIM('javascript_java', '_') FROM dual; --이건 안된다?
SELECT TRIM(' j av  a   ') FROM dual;

--replace() 기존 문자열을 새 문자열로 교체하는 함수
SELECT
    REPLACE('My dream is a president', 'president', 'programmer')
FROM dual;
--참고로 공백 제거에도 사용할 수 있음.
SELECT
    REPLACE(' ja v  a  ', ' ', '')
FROM dual;

SELECT
    REPLACE(CONCAT('hello', ' world!'), REPLACE(' !  ',' ',''), '?')
FROM dual;

---------------------------------------------------------------
/*
문제 1.
EMPLOYEES 테이블에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
*/
SELECT
    CONCAT(CONCAT(first_name,' '),last_name) AS 이름,
    REPLACE(hire_date,'/','') AS 입사일자
FROM employees
ORDER BY 이름;
-- 정렬 시 붙였던 별칭으로 지목하기!

/*
문제 2.
EMPLOYEES 테이블에서 phone_number컬럼은 ###.###.####형태로 저장되어 있다
여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 
전화 번호를 출력하도록 쿼리를 작성하세요. (CONCAT, SUBSTR, LENGTH 사용)
*/
SELECT
    CONCAT('(02)',SUBSTR(phone_number,5)) AS 전화번호,
    REPLACE(CONCAT('(02)',SUBSTR(phone_number,5)),'.','-') AS 전화번호2
FROM employees;


/*
문제 3. 
EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
*/
SELECT
    RPAD(SUBSTR(first_name,1,3),LENGTH(first_name),'*') AS name,
    LPAD(salary, 10, '*')
FROM employees
WHERE LOWER(job_id) = 'it_prog';


