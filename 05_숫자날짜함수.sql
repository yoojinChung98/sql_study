
-- 숫자함수
-- ROUND(실수, 소숫점이하 몇개 줄까?)
-- 원하는 반올림 위치를 매개값으로 지정. 음수를 주는 것도 가능
SELECT
    ROUND(3.1415, 3), ROUND(45.923, 0), ROUND(45.923, -1)
FROM dual;


--TRUNC(실수, 소숫점이하_개수)
-- 정해진 소숫점 자리수까지 잘라냅니다.
SELECT
    TRUNC(3.1415, 3), TRUNC(45.923, 0), TRUNC(45.923, -1)
FROM dual;


-- ABS(실수)
-- 절대값 구하는 함수
SELECT ABS(-34) FROM dual;


-- CEIL(실수): 정수부로 올림, FLOOR(실수): 정수부로 내림
SELECT CEIL(3.14), FLOOR(3.14)
FROM dual;


-- MOD(실수, 나눌_값) : 나머지
SELECT 10/4, MOD(10.1, 4)
FROM dual;


--------------------------------------------------------------

--날짜 함수
--sysdate: 컴퓨터의 날짜 정보를 가져와서 제공하는 함수
--(도구-환경설정-데이터베이스-NLS에서 형태 변경 가능, 시간정보까지 가지고 있긴 함)
--systemstamp : 컴퓨터의 날짜-시간 정보를 가져와서 제공하는 함수(나노초까지 제공)
SELECT sysdate FROM dual;
SELECT systimestamp FROM dual;

-- 날짜도 연산이 가능합니다. (날짜를 더하는 것)
SELECT sysdate + 1 FROM dual;

--날짜 타입과 날짜 타입은 뺄셈 연산을 지원합니다. (뺄셈의 결과값은 기간을 의미)
--덧셈은 허용하지 않음.(시점과 시점은 더하는 개념이 아니니까)
SELECT first_name, sysdate - hire_date
FROM employees;
-- 일 수로 계산이 됨, 즉 Steven 7402일 근무한 것.

SELECT first_name, hire_date,
    (sysdate - hire_date) / 7 AS week
FROM employees;
-- 주 수로 표현한 것

SELECT first_name, hire_date,
    (sysdate - hire_date) / 365 AS year
FROM employees;
-- 햇 수로 표현한 것



--ROUND(날짜, '기준')
--날짜 반올림, 절사
--날짜 반올림의 기준 디폴트는 시간
--정오를 기준으로 날짜 반올림을 함.
SELECT ROUND(sysdate) FROM dual;
--일 기준으로 반올림 (주의 첫번째 날은 일요일임, 일-화 수-토 / 해당 주의 일요일 날짜)
--일 기준으로 반올림(해당 주의 일요일 날짜)
SELECT ROUND(sysdate, 'day') FROM dual;
--달 기준으로 반올림
SELECT ROUND(sysdate, 'month') FROM dual;
--연 기준으로 반올림
SELECT ROUND(sysdate, 'year') FROM dual;


SELECT TRUNC(sysdate) FROM dual;
SELECT TRUNC(sysdate, 'day') FROM dual;
SELECT TRUNC(sysdate, 'month') FROM dual;
SELECT TRUNC(sysdate, 'year') FROM dual;



