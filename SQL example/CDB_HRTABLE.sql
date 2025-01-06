CREATE TABLE emp01 (
    empno NUMBER(4),
    ename VARCHAR2(20),
    sal   NUMBER(7, 2)
);
--HR 사용자가 가진 객체(테이블, 뷰) 확인
SELECT
    *
FROM
    tab;   

--테이블 구조확인
DESC EMP01;

--기존 테이블을 복사
CREATE TABLE employees02
    AS
        SELECT
            *
        FROM
            employees;

SELECT
    *
FROM
    tab;

--복사된 테이블 확인
SELECT
    *
FROM
    employees02;

--ALTER TABLE 구조변경 (ADD 추가)
ALTER TABLE emp01 ADD (
    job VARCHAR2(9)
);

SELECT
    *
FROM
    emp01;  

--ALTER TABLE 구조변경 (DATE 생성)
ALTER TABLE emp01 ADD (
    credate DATE
);


--ALTER TABLE TABLE_NAME
--MODIFY(COLUMN_NAME DATA_TYPE EXPR,...);

ALTER TABLE emp01 MODIFY (
    job VARCHAR2(30)
);

ALTER TABLE emp01 MODIFY (
    job VARCHAR2(30) NOT NULL
); --필수로 수정

--DROP TABLE TABLE_NAME; -- 테이블 삭제 = 복원이 불가하므로 신중히삭제할 것
DROP TABLE emp01;

--RECYCLEBIN 휴지통 구조확인
--SELECT * FROM RECYCLEBIN 휴지통 보기
--PURGE RECYCLEBIN 휴지통 비우기
--FLASHBACK TABLE EMP01 TO BEFORE DROP; 휴지통 복원

-- *삭제 종류*
--DELETE = 데이터만 지움 공간은 그대로 있음
--TRUNCATE = 모든 데이터를 삭제 디스크 공산 줄어듬 (데이터를 지우기때문에 살릴수 없음)
--DROP = 데이터 + 테이블 전체를 삭제 
DESC RECYCLEBIN;

FLASHBACK TABLE emp01 TO BEFORE DROP;

CREATE TABLE tb_customer (
    customer_cd  CHAR(7) NOT NULL PRIMARY KEY,  -- 고객코드
    customer_nim VARCHAR2(15) NOT NULL,         -- 고객명 
    mw_flg       CHAR(1) NOT NULL,              -- 성별구분
    birth_day    CHAR(8) NOT NULL,              -- 생일
    phone_number VARCHAR2(16),                  -- 전화번호
    email        VARCHAR2(50),                  -- EMAMIL
    total_point  NUMBER(10),                    -- 누적포인트
    reg_dttm     CHAR(14)                       -- 등록일
);

SELECT
    *
FROM
    tb_customer;

DESC TB_CUSTOMER;

--기존 칼럼명을 수정
ALTER TABLE tb_customer RENAME COLUMN customer_nim TO customer_nm;

SELECT
    24 * 60 * 60
FROM
    dual; -- 가상 컬럼의 값을 1번만 입력하고 싶을 때 사용하는 함수

SELECT
    department_id,
    salary
FROM
    employees
WHERE
    department_id = 30;

--IF문과 비슷한 함수 =  DECODE / 스위치와 비슷한 함수 =  CASE;