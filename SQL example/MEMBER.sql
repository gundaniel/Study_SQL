--MEMBER 테이블 생성
CREATE TABLE member (
    menber_id NUMBER(20) NOT NULL PRIMARY KEY,
    name      VARCHAR2(20) NOT NULL,
    rengo     CHAR(8) NOT NULL,
    hp        VARCHAR2(13) NOT NULL,
    address   VARCHAR2(100) NOT NULL
);

DESC MEMBER;

--BOOK 테이블 생성
CREATE TABLE book (
    code    NUMBER(4) NOT NULL PRIMARY KEY,
    title   VARCHAR2(100) NOT NULL,
    count   NUMBER(6) NOT NULL,
    price   NUMBER(10) NOT NULL,
    publish VARCHAR2(50) NOT NULL
);

DESC BOOK;

--데이터 타입 수정
ALTER TABLE member (menber_id VARCHAR2(20));

--칼럼 이름 수정
ALTER TABLE member RENAME COLUMN menber_id TO member_id;

--BOOR_ORDER 테이블 생성
CREATE TABLE book_order (
    no      VARCHAR2(10) NOT NULL PRIMARY KEY,
    id      VARCHAR2(20) NOT NULL,
    code    NUMBER(4) NOT NULL,
    count   NUMBER(6) NOT NULL,
    or_date DATE NOT NULL
);

DESC BOOK_ORDER;

SELECT
    *
FROM
    tab;

--DEPT TABLE 생성
CREATE TABLE dept (
    deptno NUMBER(2),
    dname  VARCHAR2(14),
    loc    VARCHAR2(13)
);

-- NULL -> NOT NULL 수정
ALTER TABLE dept MODIFY
    dname NOT NULL
MODIFY
    loc NOT NULL;

--데이터 삽입(INSERT INTO VALUES)
INSERT INTO dept (
    deptno,
    dname,
    loc
) VALUES ( 10,
           'ACCOUNTING',
           'NEW YORK' );

INSERT INTO dept (
    deptno,
    dname,
    loc
) VALUES ( 15,
           'COUNTING',
           'PALIS' );

--컬럼과 값의 수를 맞추지않음(NOT NULL);
INSERT INTO dept (
    deptno,
    dname,
    loc
) VALUES ( 15,
           'COUNTING' );

DESC DEPT;

SELECT
    *
FROM
    dept;

--CREATE는 자동 COMMIT /INSERT는 메모리만 삽입되어있음 (CUMMIT X)

ROLLBACK; -- 데이터 삽입전으로 돌려짐
COMMIT; --데이터가 저장됨 //자바쪽에서 불러오기가 안될때 확인할 것

ALTER TABLE dept MODIFY
    loc null;

INSERT INTO dept (
    deptno,
    dname
) VALUES ( 30,
           'ACCOUNTING' );

DELETE FROM dept;

SELECT
    *
FROM
    dept;

--DEPT 테이블을 DEPARTMENT테이블과 동일하게 수정 (구조변경)
ALTER TABLE dept MODIFY (
    deptno NUMBER(4),
    dname VARCHAR2(30)
);
--DEPT 테이블에 DEPARTMENT 테이블안 데이터를 삽입
INSERT INTO dept
    SELECT
        department_id,
        department_name,
        location_id
    FROM
        departments;

INSERT INTO tb_customer (
    customer_cd,
    customer_nm,
    mw_flg,
    birth_day,
    phone_number,
    email,
    total_point,
    reg_dttm
) VALUES ( '2017042',
           '강원진',
           'M',
           '19810603',
           '010-8202-8790',
           'wjgang@navi.com',
           280300,
           20170123132432 );
----------------------------------------------------------------           
--하나씩 삽입
INSERT INTO tb_customer (
    customer_cd,
    customer_nm,
    mw_flg,
    birth_day,
    phone_number,
    email,
    total_point,
    reg_dttm
) VALUES ( '20170',
           '강원진',
           'M',
           '19810603',
           '010-8202-8790',
           'wjgang@navi.com',
           280300,
           20170123132432 );

INSERT INTO tb_customer (
    customer_cd,
    customer_nm,
    mw_flg,
    birth_day,
    phone_number,
    email,
    total_point,
    reg_dttm
) VALUES ( '2017053',
           '나경숙',
           'W',
           '19891225',
           '010-4509-0043',
           'ksna@boram.co.kr',
           4500,
           20170210180930 );

INSERT INTO tb_customer (
    customer_cd,
    customer_nm,
    mw_flg,
    birth_day,
    phone_number,
    email,
    total_point,
    reg_dttm
) VALUES ( '2017108',
           '박승대',
           'M',
           '19711430',
           'null',
           'sdpark@haso.com',
           23450,
           20170508203450 );

DELETE FROM tb_customer;

--INSERT ALL을 통한 INSERT 
INSERT ALL INTO tb_customer (
    customer_cd,
    customer_nm,
    mw_flg,
    birth_day,
    phone_number,
    email,
    total_point,
    reg_dttm
) VALUES ( '2017042',
           '강원진',
           'M',
           '19810603',
           '010-8202-8790',
           'wjgang@navi.com',
           280300,
           20170123132432 ) INTO tb_customer 
  VALUES ( '2017053',
        '나경숙',
        'W',
        '19891225',
        '010-4509-0043',
        'ksna@boram.co.kr',
        4500,
        20170210180930 ) 
        INTO tb_customer         
           
VALUES ( '2017103',
        '박승대',
        'M',
        '19711430',
        'null',
        'sdpark@haso.com',
        23450,
        20170508203450 ) 
SELECT *FROM dual;

DESC DUAL;

SELECT
    100 + 4
FROM
    dual;
    
SELECT * FROM TB_CUSTOMER;

----------------------------------------------------------------
CREATE TABLE emp_old
    AS
        SELECT
            employee_id,
            first_name,
            hire_date,
            salary
        FROM
            employees
        WHERE
            1 = 2;

CREATE TABLE emp_new
    AS
        SELECT
            employee_id,
            first_name,
            hire_date,
            salary
        FROM
            employees
        WHERE
            1 = 2;

--INSERT ALL을 통한 값 넣기 2006년 기준 이전, 이후로

INSERT ALL 
WHEN hire_date < '2006/01/01' THEN
        INTO emp_old values (
            employee_id,
            first_name,
            hire_date,
            salary
        )
        WHEN hire_date > '2006/01/01' THEN
            INTO emp_new values (
                employee_id,
                first_name,
                hire_date,
                salary
            )
SELECT
    employee_id,
    first_name,
    hire_date,
    salary
FROM
    employees;

-- 값 확인
SELECT * FROM  EMP_OLD
ORDER BY HIRE_DATE ASC;

SELECT * FROM  EMP_NEW
ORDER BY HIRE_DATE ASC;

CREATE TABLE EMP
AS
SELECT * FROM EMPLOYEES;

SELECT *FROM EMP
ORDER BY DEPARTMENT_ID ASC;

--테이블 안의 모든 부서번호를 30으로 변경
UPDATE EMP
SET DEPARTMENT_ID = 30;

--모든 사원의 급여를 10% 인상
UPDATE EMP
SET SALARY = SALARY *1.1;

DROP TABLE EMP;

CREATE TABLE EMP
AS
SELECT * FROM EMPLOYEES;

--부서가 10인 사원의 부서번호를 30번으로 수정 (특정 테이블 행만 변경)

UPDATE EMP --MMP테이블 안의
SET DEPARTMENT_ID = 30   --사원번호를 30으로 수정
WHERE DEPARTMENT_ID = 10; --누구를? 10번인 사람을 (JENNIFER)



SELECT FIRST_NAME, DEPARTMENT_ID 
FROM EMP
WHERE lower(FIRST_NAME) LIKE '%jennifer%'; //대소문자 구분없이
--WHERE FIRST_NAME\ LIKE '%a%'; --대소문자 구분

--3000천달러 이상의 사람들만 급여를 10% 인상
UPDATE EMP
SET SALARY = SALARY *1.1
WHERE SALARY >= 3000;

--3000천달러 이하의 사람들만 급여를 10% 인상
UPDATE EMP
SET SALARY = SALARY *1.1
WHERE SALARY <= 3000;

SELECT SALARY
FROM EMP
WHERE SALARY <= 2900;
----------------------------------------------------------------
--<문제> TB_CUSTOMER 테이블에서 박승대고객의 생년월일을 19711230인데 
--잘못입력하여 19711430을 입력하였다.
--생년월일을 수정해 주세요.

SELECT * FROM TB_CUSTOMER;

UPDATE TB_CUSTOMER -- 테이블 명
SET BIRTH_DAY='19711230' -- 바꾸고자 하는 값을 입력
WHERE CUSTOMER_CD = '2017103'; -- 기준점 조건문 (중복되지 않는 것을 선택) 
-- ★기본키를 가진 컬럼을 선택하는 것이 좋음★

----------------------------------------------------------------
SELECT * FROM DEPT;

/*데이터 삭제
DELETE FROM 테이블 명
WHERE 기본키 칼럼 = 값; */

DELETE FROM DEPT
WHERE DEPTNO = 30

--ROLLBACK;
----------------------------------------------------------------
/*데이터 입력
INSERT 테이블명(컬럼명, 컬럼명 ...)
VALUES ('문자',숫자,'날짜');

--데이터 수정
UPDATE 테이블명
SET 컬럼명 = '값' , 컬럼명 =값...
WHERE 조건문;
조건문 => 기본키컬럼 = 값;

--데이터 삭제
DELETE FROM 테이블명
WHERE 조건문;
조건문 = > 기본키컬럼 = 값

--데이터 조회
SELECT 컬럼명(1), 컬럼명(2) AS 별칭, 컬럼명 별칭(공백포함, 특수문자, 대소문자구분)= > ""
FROM 테이블명
WHERE 조건문 => 별칭X
ORDER BY 컬럼명 ASC/DESC, 순분(1,2..) ASC/DESC, 별칭 ASC/DESC

NULL WHERE 컬럼명 = NULL;
IS NULL
IS NOT NULL;
*/
----------------------------------------------------------------












