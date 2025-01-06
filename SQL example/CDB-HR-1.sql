-- 기본 SELECT문 예제


SELECT * FROM EMPLOYEES;

-- [문제1] EMPLOYEES 테이블에서 급여가 3000이상인 사원의 정보를 사원번호, 이름, 담당업무, 급여를 출력하라.
SELECT EMPLOYEE_ID AS "사원번호", FIRST_NAME AS "사원이름", JOB_ID AS "담당업무", SALARY AS "급여" 
FROM EMPLOYEES
WHERE SALARY > 3000
ORDER BY SALARY ASC;

-- [문제2] EMPLOYEES 테이블에서 담당 업무가 ST_MAN인 사원의 정보를 사원번호, 이름, 담당업무, 급여, 부서번호를 출력하라.
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE '%ST_MAN%';

-- [문제3] EMPLOYEES 테이블에서 입사일자가 2006년 1월 1일 이후에 입사한 사원의 정보를  사원번호, 이름, 담당업무, 급여, 입사일자, 부서번호를 출력하라.

SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, HIRE_DATE, DEPARTMENT_ID
FROM EMPLOYEES
WHERE HIRE_DATE > '2006.01.01'
--WHERE HIRE_DATE >= TO_DATE('2006/01/01', 'YYYYMMDD') 이렇게도 가능
ORDER BY HIRE_DATE ASC;


-- [문제4] EMPLOYEES 테이블에서 급여가 3000에서 5000사이의 정보를 이름, 담당업무, 급여, 부서번호를 출력하라.

SELECT FIRST_NAME, JOB_ID, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY BETWEEN '3000' AND '5000'
ORDER BY SALARY ASC;

--[문제5] EMPLOYEES 테이블에서 입사일자가 05년도에 입사한 사원의 정보를  사원번호, 이름, 담당업무, 급여, 입사일자, 부서번호를 출력하라.

SELECT EMPLOYEE_ID FIRST_NAME, JOB_ID, SALARY, HIRE_DATE, DEPARTMENT_ID
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '05_%'
--WHERE HIRE_DATE BETWEEN '2005.01.01' AND '2005.12.31'
ORDER BY HIRE_DATE ASC;

--[문제5 추가질문] EMPLOYEES 테이블에서 사원번호가 145,152,203인 사원의 정보를  사원번호, 이름, 담당업무, 급여, 입사일자를 출력하라

SELECT EMPLOYEE_ID AS "사원번호", FIRST_NAME AS "이름", JOB_ID AS "담당업무", SALARY AS "급여", HIRE_DATE AS "고용일자"
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(145,152,203);

-- [문제6] EMPLOYEES 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오. 이때 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오

SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS "Name", SALARY, JOB_ID, HIRE_DATE, MANAGER_ID
FROM EMPLOYEES;

-- [문제 7] EMPLOYEES 테이블에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary, 
-- 연봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary, 급여에 $100 보너스를 추가하여 
-- 계산한 연봉은 Increased Salary라는 별칭으로 출력하시오

SELECT 
FIRST_NAME || ' ' || LAST_NAME AS NAME ,
JOB_ID AS JOB, 
SALARY, 
(12 *SALARY)+100 AS "Increased Ann_Salary",
(SALARY + 100)*12 "Increased Salary"
FROM EMPLOYEES;

--[문제 8] 사원정보(EMPLOYEES) 테이블에서 모든 사원의 이름(FIRST_NAME)과 연봉을 “이름: 1 Year Salary = $연봉” 형식으로 출력하고, 1 Year Salary라는 별칭을 붙여 출력하시오.
--(예시) King: 1 Year Salary = $288000

SELECT FIRST_NAME ||': 1 YEAR SALARY = '|| '$'||SALARY*12 
FROM EMPLOYEES;

-- [문제 9] 부서별로 담당하는 업무ID를 한 번씩만 출력하시오
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

--[문제 10] 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 
--EMPLOYEES 테이블에서 급여가 $7,000~$10,000 범위 이외
--사람의 성과 이름(Name으로 별칭) 및 급여를 급여가 작은 순서로 출력하시오.

SELECT FIRST_NAME||' '||LAST_NAME AS "NAME",SALARY
FROM EMPLOYEES
WHERE  SALARY BETWEEN 7000 AND 10000
ORDER BY SALARY ASC;


-- [문제 11] EMPLOYEES 테이블에서 2006년 05월 20일부터 2007년 05월 20일 사이에 고용된 사원들의 성과 이름(Name으로 별칭), 사원번호, 고용일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오

SELECT LAST_NAME, EMPLOYEE_ID, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE , 'YYYYMMDD') BETWEEN'20060520' AND '20070520'
ORDER BY HIRE_DATE;


-- [문제 12] EMPLOYEES 테이블에서 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다. 
-- 이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오. 
-- 이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오.

SELECT FIRST_NAME ||' '|| LAST_NAME AS "NAME" ,SALARY, JOB_ID, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY DESC, COMMISSION_PCT DESC;

