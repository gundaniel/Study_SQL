--테이블 생성
CREATE TABLE test (
    no NUMBER NOT NULL PRIMARY KEY
);
--테이블 생성(2)
CREATE TABLE test (
    NO NUMBER NOT NULL,
    NAME NVARCHAR2(5) NOT NULL,  -- N - 유니코드로 보기때문에 글자수로 확인 (모든 글자를 2바이트로)
    EMAIL VARCHAR2(50) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE,
    PRIMARY KEY(NO)
);


SELECT * FROM TEST;
--DROP TABLE TEST;
------------------------------------------------
--시퀀스 생성
--시퀸스는 PRIMARY KEY에 일련번호를 자동부여함 (유일값을 생성해주는 오라클 객체(순차적으로 생성)
CREATE SEQUENCE test_seq START WITH 1  --1부터 시작
INCREMENT BY 1 --1개 증가
MINVALUE 1 --최솟값 1
MAXVALUE 999999 --최댓값
NOCYCLE --반복없음
CACHE 2; --2 저장

------------------------------------------------
--시퀀스 삭제
DROP SEQUENCE TEST_SEQ;


--시퀀스 사용
INSERT INTO TEST VALUES(test_seq.NEXTVAL); --NEXTVAL 다음값을 가져와라

--시퀀스를 사용하지 않았을 경우 자동증가하는 값으로설정하기 위한 쿼리문 = 시퀀스 값에 보이지 않음(시퀀스로 적용x)
INSERT INTO TEST VALUES( (SELECT MAX(NO) +1 FROM TEST) );

------------------------------------------------
--현재의 시퀀스 값을 반환
SELECT TEST_SEQ.CURRVAL 
FROM DUAL;
--현재값에서 증가한 값(+1)을 반환
SELECT TEST_SEQ.NEXTVAL FROM DUAL;



--칼럼을 삭제
DELETE FROM TEST
WHERE NO = 2;

INSERT INTO TEST
VALUES(TEST_SEQ.NEXTVAL,'홍길동','javauser@naver.com',DEFAULT);
------------------------------------------------
--함수

--문자형으로 변환하는 TO_CHAR 함수
SELECT SYSDATE AS"날짜 변환X" , TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "날짜 변환" ,TO_CHAR(SYSDATE,'DL') AS "날짜 + 요일"
FROM DUAL;


--함수를 사용시 별칭을 줄때는 기본적으로 "컬럼명"을 사용함
--한글은 함수표현시 ""로 묶어줘야 함
SELECT DEPARTMENT_ID AS "번호" , TO_CHAR(HIRE_DATE,'YYYY"년 "MM"월 "DD"일 "DAY') AS "입사일 (년/월/일/N요일)"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;

SELECT TO_CHAR(HIRE_DATE, 'YYYY/MON/DD DY') AS "년/N월/일/요일"
FROM EMPLOYEES
WHERE DEPARTMENT_ID =30;

-- 날짜 표시 함수
SELECT TO_CHAR(SYSDATE, 'DDD')AS "365일 기준 현재일수" 
      ,TO_CHAR(SYSDATE, 'WW')AS "1년 기준 현재 주" 
      ,TO_CHAR(SYSDATE, 'Q') AS "1년 기준 현재 분기" 
FROM DUAL;

--시간 표시 함수
SELECT TO_CHAR(SYSDATE, 'PM') AS "현재 오전/오후"
      ,TO_CHAR(SYSDATE, 'PM HH:MI:SS') AS "현재 오전/오후 /시/분/초"
      ,TO_CHAR(SYSDATE, 'HH24"시" MI"분" SS"초"')  AS "현재 /시/분/초"
FROM DUAL;

--날짜 + 시간
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS "날짜 / 시간"
FROM DUAL;

--출력 예시
SELECT NO, NAME, EMAIL, TO_CHAR(SYSDATE , 'YYYY-MM-DD HH:MI:SS') REGDATE
FROM TEST;
------------------------------------------------
--숫자를 문자로 변환하기(TO_CHAR)

--9는 자릿수를 표현하나 값이 없으면 표현하지 않음
SELECT TO_CHAR(1234,'9,999') AS "1,234"
,TO_CHAR(123456, 'FM999,999') AS "123,456"
,TO_CHAR(123456789, 'FM999,999,999') AS "123,456,789"
,TO_CHAR(123456, 'FML999,999') AS "\123,456"
FROM DUAL;

--0는 자릿수를 표현하고 값이 없으면 0으로 그 자릿수만큼 값을 체움
--FM은 문자 앞의 공백을제거한다.
SELECT TO_CHAR(1,'0.0') AS "001"
,TO_CHAR(1,'FM00') AS "FM = 공백제거"
FROM DUAL;

------------------------------------------------
--숫자 -> 문자변환으로 급여 출력하기

SELECT FIRST_NAME||' ' ||LAST_NAME AS FULL_NAME, SALARY, TO_CHAR(SALARY, '$999,999') SALARYFORMAT
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;

------------------------------------------------
--날짜표현 예제

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = '05/12/24';

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = TO_DATE('20051224','YYYYMMDD');

--날짜형식을 문자형식으로 표현
--ORA-01481: 숫자 형식 모델이 부적합합니다
SELECT TO_CHAR('210505','YYYY"년"MM"월"DD"일"') AS "날짜"
FROM DUAL;

--해결
SELECT TO_CHAR(TO_DATE('210505','YYMMDD'),'YYYY"년"MM"월"DD"일"')AS 날짜
FROM DUAL;

--0을 없애고싶을때 FM입력
SELECT TO_CHAR(TO_DATE('210505','YYMMDD'),'YYYY"년"FMMM"월"DD"일"')AS 날짜
FROM DUAL;

--<날짜 계산> 현재일 - 계산하고자 하는 일
--TRUNC = 소수점 절삭
SELECT TRUNC(SYSDATE - TO_DATE('2024/09/26')) AS 기간
FROM DUAL;
------------------------------------------------
--수치 형태의 문자 값의 차 구하기
--ORA-01722: 수치가 부적합합니다
SELECT '10,000' + '20,000'
FROM DUAL;

-->해결 (출력값 = 30000)
SELECT TO_NUMBER('10,000','999,999') + TO_NUMBER('20,000','999,999') AS "결과"
FROM DUAL;

--> 출력이 30,000으로 표현이 되지 않아 수정 (문자 > 숫자 연산 > 문자 변경)
SELECT TO_CHAR(TO_NUMBER('10,000','999,999') + TO_NUMBER('20,000','999,999'),'999,999') AS "결과"
FROM DUAL;
------------------------------------------------
--NVL 함수

-- NVL (값,값) = 첫번째 인자값이 NULL일시 두번째 인자값으로변경해주는 함수

--기존 테이블 출력 (COMMISSTION 값 = NULL)
SELECT FIRST_NAME, SALARY,COMMISSION_PCT,JOB_ID
FROM EMPLOYEES
ORDER BY JOB_ID;

--COMMISSTION의 널값을 NVL을 이용해 NULL = 0으로 출력
SELECT FIRST_NAME, SALARY,NVL(COMMISSION_PCT,0),JOB_ID
FROM EMPLOYEES
ORDER BY JOB_ID;
 
--TOTAL SALARY 계산하기 (NVL을 이용해 NULL = 0으로 출력)
SELECT FIRST_NAME, SALARY,COMMISSION_PCT,
SALARY * COMMISSION_PCT AS COMMISSION,
SALARY + NVL(SALARY * COMMISSION_PCT,0) AS TOTAL , JOB_ID
FROM EMPLOYEES
ORDER BY JOB_ID;

------------------------------------------------
--NVL2 함수 (컬럼 OR 표현식, A, B)
--값이 NULL이면 A, NULL이 아니면 B를 출력

--<예> 커미션이 NULL이 아니면, 급여 + 커미션을 NULL이면 급여만 출력
--※아닐때가 먼저 나옴

SELECT FIRST_NAME, SALARY,COMMISSION_PCT,
NVL2(COMMISSION_PCT, --컬럼 OR 표현식이
SALARY + (SALARY *COMMISSION_PCT) --NULL이 아닐때 출력
,SALARY) AS "TOTAL_SAL" --NULL일때 출력
FROM EMPLOYEES
ORDER BY COMMISSION_PCT DESC;

--NVL2를 사용하여 상관이 존재하지 않을때 사장, 존재하면 직원을 출력
SELECT FIRST_NAME || ' ' || LAST_NAME AS "NAME", MANAGER_ID, NVL2(MANAGER_ID,'직원','사장')
FROM EMPLOYEES
ORDER BY MANAGER_ID DESC;

------------------------------------------------
-- <문제>모든 직원은 자신의 상관(MANAGER_ID)이 존재한다.
-- 하지만 EMPLOYEES 테이블에 유일하게 상관이 없는 로우가 있는데 그 사원의 MANAGER_ID 칼럼 값이 NULL이다. 
-- 상관이 없는 대표이사만 출력하되 MANAGER_ID 칼럼 값 NULL 대신 CEO로 출력한다.

SELECT FIRST_NAME, NVL(TO_CHAR(MANAGER_ID),'CEO') AS MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- <문제>커미션 정보가 없는 직원들도 있는데 커미션이 없는 직원 그룹은 ‘<커미션 없음>’이 출력되게 한다.
SELECT FIRST_NAME, NVL(TO_CHAR(COMMISSION_PCT),'<커미션 없음>') AS COMMISSION
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;
------------------------------------------------
--DECODE 함수(IF와 비슷)
(표현식, 조건1, 결과1, 조건2, 결과2...)

SELECT EMPLOYEE_ID, FIRST_NAME,
DEPARTMENT_ID ,DECODE(DEPARTMENT_ID, 
10, 'Administration',
20, 'Marketing',
30, 'Purchasing',
40, 'Human resources',
50, 'Shipping',
60, 'It')
AS DEPARTMENTS
FROM EMPLOYEES
WHERE DEPARTMENT_ID BETWEEN 10 AND 60
ORDER BY DEPARTMENT_ID;
------------------------------------------------
--CASE 함수 (SWITCH와 비슷)

SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID,
CASE DEPARTMENT_ID WHEN 10 THEN 'Administration'
                   WHEN 20 THEN 'Marketing'
                   WHEN 30 THEN 'Purchasing'
                   WHEN 40 THEN 'Human resources'
                   WHEN 50 THEN 'Shipping'
                   WHEN 60 THEN 'It'
                   END DEPARTMENT_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID BETWEEN 10 AND 60
ORDER BY DEPARTMENT_ID;

------------------------------------------------      

-- <문제> 부서별에 따라 급여를 인상하도록 하자. (직원번호, 직원명, 직급, 급여)
-- 부서명이 'Marketing'인 직원은 5%, 'Purchasing'인 사원은 10%, 'Human Resources'인 사원은 15%, 
-- 'IT'인 직원은 20%인 인상한다.
-- 위 문제를 해결하기 위해서는 사원테이블과 부서테이블이 연결되어야 가능하기 때문에 
--지금은 부서번호로 조건 부여(부서테이블에 부서명에 해당하는 부서번호로 조건)하여 구한다.

SELECT FIRST_NAME,JOB_ID,SALARY,DEPARTMENT_ID,
DECODE(DEPARTMENT_ID, 
20, SALARY * 1.05,
30, SALARY * 1.1,
40, SALARY * 1.15,
60, SALARY * 1.2, SALARY) 
AS "TOTAL SALARY"
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID;
------------------------------------------------
DESC EMPLOYEES;
SELECT * FROM EMPLOYEES;



