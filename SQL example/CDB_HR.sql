-- [요구사항]
-- 부서별 같은 직무를 담당하는 사원의 급여의 합과 사원수, 부서별 급여의 합과 사원수, 전체 사원의 급여의 합과 사원수를 구하고자 한다. 

-- 위 내용을 정리하면

SELECT * FROM EMPLOYEES;

-- 부서별 같은 직무를 담당하는 사원의 급여의 합과 사원수
SELECT JOB_ID AS "직무" , DEPARTMENT_ID AS 부서, SUM(SALARY) AS "부서별 급여의 합", COUNT(DEPARTMENT_ID) AS "부서별 사원수" 
FROM EMPLOYEES
GROUP BY JOB_ID,DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

--부서별 급여의 합과 사원수
SELECT DEPARTMENT_ID AS 부서, SUM(SALARY) AS "부서별 급여의 합", COUNT(DEPARTMENT_ID) AS "부서별 사원수" 
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- 전체 사원의 급여의 합과 사원수
SELECT SUM(SALARY), COUNT(DEPARTMENT_ID)
FROM EMPLOYEES;
-------------------------------------------------------------------------------

SELECT JOB_ID AS "직무" , DEPARTMENT_ID AS "부서", SUM(SALARY) AS "부서별 급여의 합", COUNT(DEPARTMENT_ID) AS "부서별 사원수" 
FROM EMPLOYEES
GROUP BY JOB_ID, DEPARTMENT_ID
UNION ALL
SELECT NULL JOB_ID, DEPARTMENT_ID AS "부서", SUM(SALARY) AS "부서별 급여의 합", COUNT(DEPARTMENT_ID) AS "부서별 사원수" 
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
UNION ALL
SELECT NULL JOB_ID,NULL DEPARTMENT_ID ,SUM(SALARY), COUNT(DEPARTMENT_ID)
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID;

