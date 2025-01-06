select * from v$instance;

--사용자 권한 부여
GRANT CREATE VIEW TO hr;

CREATE TABLE EMP_COPY
AS SELECT * FROM EMPLOYEES;
-----------------------------------
CREATE VIEW VIEW_EMP01
AS 
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMP_COPY
WHERE DEPARTMENT_ID = 10;
-----------------------------------
DROP TABLE EMP01;

CREATE TABLE EMP01
AS
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,DEPARTMENT_ID
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMP01
WHERE DEPARTMENT_ID = 30;
-----------------------------------
--뷰 생성
--CREATE [OR REPLACE][FORCE|NOFORCE] VIEW view_name
--[(alias,alias,alias...)]
--AS SUBQUERY
--[WITH CHECK OPTION]
--[WITH READ ONLY];

CREATE OR REPLACE VIEW VIEW_EMP01
AS
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY,DEPARTMENT_ID
FROM EMP01
WHERE DEPARTMENT_ID = 30;

SELECT * 
FROM VIEW_EMP01;

INSERT INTO VIEW_EMP01
VALUES(250,'ANGEL',7000,30);

-----------------------------------
--뷰 확인
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;

--뷰 삭제
DROP VIEW VIEW_SALARY;
-----------------------------------
--ROWNUM
-- INSERT 문에 의해 입력한 순서에 따라 1씩 증가되면서 값이 지정 된다. 

SELECT ROWNUM, EMPLOYEE_ID, FIRST_NAME,  TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') HIRE_DATE
FROM EMPLOYEES
ORDER BY HIRE_DATE DESC;
-----------------------------------
--인라인뷰

--인라인뷰는 서브쿼리를 사용하여 생성된 일시적인 테이블이라 할 수 있다. 
--FROM절에 사용되며 쿼리내에 다른 테이블과 동일하게 취급된다. 
--복잡한 쿼리를 단순화하고 재사용가능한 논리적 뷰를 생성하는데 유용하다.
--문법: SELECT 컬럼, 컬럼 ... FROM (SELECT 컬럼 FROM 테이블명) WHERE 조건문

SELECT ROWNUM, EMPLOYEE_ID, FIRST_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') HIRE_DATE
FROM --안쪽의 서브쿼리는 일시적 테이블이다.(데이터를 보여주는 것이 아니라, 가져오는 작업이기에 TO_CHAR 불가)
(
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
ORDER BY HIRE_DATE DESC
)
WHERE ROWNUM <= 5;

----------------------------------





