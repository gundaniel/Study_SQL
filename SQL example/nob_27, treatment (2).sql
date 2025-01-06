------------------------------------------------

--무결성 제약조건 
--NOT NULL 확인
DROP TABLE emp01 PURGE;

CREATE TABLE emp01 (
    empno  NUMBER(4) NOT NULL,
    ename  VARCHAR2(10) NOT NULL,
    job    VARCHAR2(9),
    deptno NUMBER(4)
);

--레코드 입력여부(NULL 불가)
INSERT INTO emp01 VALUES ( NULL,
                           NULL,
                           'SALESMAN',
                           30 );

INSERT INTO emp01 VALUES ( 7499,
                           'ALLEN',
                           'SALESMAN',
                           30 );

SELECT
    *
FROM
    emp01;

------------------------------------------------

--UNIQUE 확인

CREATE TABLE emp02 (
    empno  NUMBER(4) UNIQUE,
    ename  VARCHAR2(10) NOT NULL,
    job    VARCHAR2(9),
    deptno NUMBER(4)
);

INSERT INTO emp02 (
    empno,
    ename,
    job,
    deptno
) VALUES ( 7499,
           'ALLEN',
           'SALESMAN',
           30 );

--동일한 사번을 입력해 오류생성
INSERT INTO emp02 (
    empno,
    ename,
    job,
    deptno
) VALUES ( 7499,
           'ALLEN',
           'SALESMAN',
           30 );

--EMPNO NOT NULL 입력
ALTER TABLE emp02 MODIFY
    empno NOT NULL;

DESC EMP02;

--NULL 값을 삽입하여 오류 생성
--SQL 오류: ORA-01400: NULL을 ("HR"."EMP02"."EMPNO") 안에 삽입할 수 없습니다

INSERT INTO emp02 (
    empno,
    ename,
    job,
    deptno
) VALUES ( NULL,
           'JONES',
           'MANAGER',
           20 );

INSERT INTO emp02 (
    empno,
    ename,
    job,
    deptno
) VALUES ( 7500,
           'JONES',
           'MANAGER',
           20 );

--동일한 사번을 입력해 오류생성
--ORA-00001: 무결성 제약 조건(HR.SYS_C008407)에 위배됩니다

INSERT INTO emp02 (
    empno,
    ename,
    job,
    deptno
) VALUES ( 7500,
           'JONES',
           'MANAGER',
           20 );

SELECT
    *
FROM
    emp02;
------------------------------------------------
--HR 사용자가 가진 테이블 확인
SELECT
    table_name
FROM
    user_tables
ORDER BY
    table_name ASC;
------------------------------------------------
--제약 조건 확인 쿼리문
SELECT
    constraint_name,
    constraint_type,
    table_name,
    search_condition
FROM
    user_constraints
WHERE
    table_name = 'EMP02';

--제약조건 컬럼 확인 쿼리문
SELECT
    owner,
    constraint_name,
    table_name,
    column_name
FROM
    user_cons_columns
WHERE
    table_name = 'EMP02';
------------------------------------------------
--PRIMARY KEY 확인

CREATE TABLE emp03 (
    empno  NUMBER(4) PRIMARY KEY,
    ename  VARCHAR2(10) NOT NULL,
    job    VARCHAR2(9),
    deptno NUMBER(4)
);

INSERT INTO emp03 VALUES ( 7499,
                           'ALLEN',
                           'SALESMAN',
                           30 );

--결과?
--ORA-00001: 무결성 제약 조건(HR.SYS_C008410)에 위배됩니다

INSERT INTO emp03 VALUES ( 7499,
                           'JONES',
                           'MANAGER',
                           30 );

--결과?(NULL 값 삽입 불가)
--SQL 오류: ORA-01400: NULL을 ("HR"."EMP03"."EMPNO") 안에 삽입할 수 없습니다

INSERT INTO emp03 VALUES ( NULL,
                           'JONES',
                           'MANAGER',
                           30 );

INSERT INTO emp03 VALUES ( 7500,
                           'JONES',
                           'MANAGER',
                           50 );

SELECT
    constraint_name,
    constraint_type,
    table_name
FROM
    user_constraints
WHERE
    table_name = 'EMP03';

SELECT
    *
FROM
    emp03;

------------------------------------------------

--FOREIGN 확인 - 참조 무결성 테이블 사이의 주종관계에서 설정

--부모 테이블 생성
CREATE TABLE dept01 (
    deptno NUMBER(2) PRIMARY KEY,
    dname  VARCHAR2(14) NOT NULL,
    loc    VARCHAR2(13)
);

INSERT INTO dept01 (
    deptno,
    dname,
    loc
) VALUES ( 10,
           'ACCOUNTING',
           'NEWYORK' );

INSERT INTO dept01 (
    deptno,
    dname,
    loc
) VALUES ( 20,
           'RESEARCH',
           'DALLAS' );

INSERT INTO dept01 (
    deptno,
    dname,
    loc
) VALUES ( 30,
           'SALES',
           'CHICAGO' );

INSERT INTO dept01 (
    deptno,
    dname,
    loc
) VALUES ( 40,
           'OPERATIONS',
           'BOSTON' );

--자식 테이블 생성

CREATE TABLE emp04 (
    empno  NUMBER(2) PRIMARY KEY,
    dname  VARCHAR2(10) NOT NULL,
    job    VARCHAR2(9),
--REPERENCES = 자료형 일치
--외래키 제약조건 = 생성시 칼럼명과 자료형을 기술후에 REPERENCES 기술(DEPTNO를 참조하게 기술)
    deptno NUMBER(2)
        REFERENCES dept01 ( deptno )
);

SELECT
    *
FROM
    emp04;

--FOREIGN 제약걸지 않은 테이블에 입력시 오류 발생없음
INSERT INTO emp03 VALUES ( 7566,
                           'JONES',
                           'MANAGER',
                           50 );

--EMPNO 값을2 -> 4로 수정
ALTER TABLE emp04 MODIFY (
    empno NUMBER(4)
);


--FOREIGN에 일치하지 않는 값 입력시 오류 발생
--ORA-02291: 무결성 제약조건(HR.SYS_C008415)이 위배되었습니다- 부모 키가 없습니다

INSERT INTO emp04 VALUES ( 7566,
                           'JONES',
                           'MANAGER',
                           50 );

------------------------------------------------

--CHECK와 DEFAULT 확인

CREATE TABLE emp05 (
    empno   NUMBER(4) PRIMARY KEY,
    ename   VARCHAR2(10) NOT NULL,
    gender  CHAR(1) CHECK ( gender IN ( 'M', 'F' ) ), --GENDER 안의 값은 IN(값,값)만 사용가능
    regdate DATE DEFAULT sysdate -- 가입일은 오늘날짜로 DEFAULT를 잡아놔서 빼고도 입력이 가능함
);

--NOT NULL, CHECK, DEFAULT변경은 ALTER MODIFY

--데이터 삽입
INSERT INTO emp05 (
    empno,
    ename,
    gender
) VALUES ( 7566,
           'JONES',
           'M' );

INSERT INTO emp05 VALUES ( 7567,
                           'JONES',
                           'M',
                           sysdate );

INSERT INTO emp05 VALUES ( 7568,
                           'JONES',
                           'M',
                           default );


--GENDER 에 맞지 않는 값입력으로 오류생성
--ORA-02290: 체크 제약조건(HR.SYS_C008417)이 위배되었습니다
INSERT INTO emp05 (
    empno,
    ename,
    gender
) VALUES ( 7569,
           'JONES',
           'A' );

SELECT
    *
FROM
    emp05;

------------------------------------------------
--컬럼 레벨형식 (컬럼과 제약조건을 같이 선언)  -> 복잡하여 잘 쓰지않음

CREATE TABLE emp06 (
    empno  NUMBER(4)
        CONSTRAINT emp06_empno_pk PRIMARY KEY,
    ename  VARCHAR2(10)
        CONSTRAINT emp06_ename_nn NOT NULL,
    job    VARCHAR2(9)
        CONSTRAINT emp06_job_uk UNIQUE,
    deptno NUMBER(2)
        CONSTRAINT emp06_deptno_fk
            REFERENCES dept01 ( deptno )
);

SELECT
    *
FROM
    emp06;

INSERT INTO emp06 VALUES ( 7499,
                           'ALLEN',
                           'SALESMAN',
                           30 );

--ORA-00001: 무결성 제약 조건(HR.EMP06_EMPNO_PK)에 위배됩니다
INSERT INTO emp06 VALUES ( 7499,
                           'ALLEN',
                           'SALESMAN',
                           30 );

--SQL 오류: ORA-01400: NULL을 ("HR"."EMP06"."ENAME") 안에 삽입할 수 없습니다
INSERT INTO emp06 VALUES ( 7499,
                           NULL,
                           'SALESMAN',
                           50 );

--ORA-00001: 무결성 제약 조건(HR.EMP06_EMPNO_PK)에 위배됩니다
INSERT INTO emp06 VALUES ( 7499,
                           'ALLEN',
                           'SALESMAN',
                           50 );

--ORA-00001: 무결성 제약 조건(HR.EMP06_JOB_UK)에 위배됩니다
INSERT INTO emp06 VALUES ( 7500,
                           'ALLEN',
                           'SALESMAN',
                           50 );

--ORA-02291: 무결성 제약조건(HR.EMP06_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO emp06 VALUES ( 7500,
                           'ALLEN',
                           'MANAGER',
                           50 );

--레코드 삭제 구문
DELETE FROM emp06
WHERE
    empno = 7499;

------------------------------------------------
-- 테이블 레벨 방식 (NOT NULL ,CHECK,(DEFAULT 값)는 칼럼 옆에 기술)
--CONSTRAINT 테이블 컬럼 유형 풀네임(설정할 자식 칼럼) REPERENCE 부모테이블(부모 칼럼)


CREATE TABLE emp08 (
    empno  NUMBER(4),
    ename  VARCHAR2(10) NOT NULL,
    job    VARCHAR2(9),
    deptno NUMBER(2),
------------------제약조건--------------------
    PRIMARY KEY ( empno ), --EMPNO 기본키 설정
    UNIQUE ( job ), --JOB UNIQUE 설정
    FOREIGN KEY ( deptno )
        REFERENCES dept01 ( deptno )
--------------------------------------------
);

SELECT
    *
FROM
    emp08;

--제약조건 확인
--OWNER -- 제약의 소유자
-- constraint_name, -- 제약명
--constraint_type -- 제약종류
--table_name, -- 테이블명
--R_CONSTRAINT_NAME 참조하는 테이블의 UNIQUE KEY 제약조건의 정의명 (R = 참조)

SELECT
    constraint_name,
    constraint_type,
    table_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name = 'EMP08';
------------------------------------------------
--TABLE 생성(EMP09)
CREATE TABLE emp09 (
    empno  NUMBER(4),
    ename  VARCHAR2(10),
    job    VARCHAR2(9),
    deptno NUMBER(4)
);

--제약조건 확인
SELECT
    constraint_name,
    constraint_type,
    table_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name = 'EMP09';

SELECT
    *
FROM
    emp09; 

--제약조건을 명시하지 않고 기본키를 추가
ALTER TABLE emp09 ADD PRIMARY KEY ( empno );

--제약 조건 삭제 (이름을 반드시확인해야 함 //기본키 삭제)
ALTER TABLE emp09 DROP CONSTRAINT sys_c008427;

--제약조건 명시 후 기본키 추가
ALTER TABLE emp09 ADD CONSTRAINT emp09_empno_pk PRIMARY KEY ( empno );

--제약조건 명시 후 외래키 추가
ALTER TABLE emp09
    ADD CONSTRAINT emp09_deptno_fk FOREIGN KEY ( deptno )
        REFERENCES dept01 ( deptno );

INSERT INTO emp09 (
    empno,
    ename,
    job,
    deptno
) VALUES ( NULL,
           'JONES',
           'ACCOUNTING',
           10 );
           
------------------------------------------------          

--부모 테이블 생성           
CREATE TABLE DEPT02 (
    deptno NUMBER(2),
    dname  VARCHAR2(14),
    loc    VARCHAR2(13),
    CONSTRAINT dept02_deptno_pk PRIMARY KEY ( deptno )
);

DROP TABLE emp02;          
           
--자식 테이블 생성           
CREATE TABLE emp02 (
    empno  NUMBER(4),
    ename  VARCHAR2(10) NOT NULL,
    job    VARCHAR2(9),
    deptno NUMBER(2),
    CONSTRAINT emp02_empno_pk PRIMARY KEY ( empno ),
    CONSTRAINT emp02_deptno_fk FOREIGN KEY ( deptno )
        REFERENCES dept02 ( deptno )
);
--확인
SELECT
    constraint_name,
    constraint_type,
    table_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name = 'EMP02';

--테이블 명 변경
RENAME EMPT02 TO DEPT02;

-- 값 삽입(부모 테이블)
INSERT INTO DEPT02
VALUES (10,'ACCOUNTIONG','NEW YORK');
INSERT INTO DEPT02
VALUES (20,'RESEARCH','DALLAS');

SELECT * FROM DEPT02;

--값 삽입(자식 테이블)
INSERT INTO EMP02 VALUES(7499,'ALLEN','SALESMAN',10);
INSERT INTO EMP02 VALUES(7369,'SMITH','CLERK',20);
SELECT * FROM EMP02;

--삭제시 부모테이블을 참조하는지 확인
--ORA-02292: 무결성 제약조건(HR.EMP02_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM DEPT02 WHERE DEPTNO =10;


------------------------------------------------
--진료과목 테이블 생성(부모)

CREATE TABLE TREATMENT(
T_NO NUMBER(4) NOT NULL,
T_COURSE_ABBR VARCHAR2(3) NOT NULL,
T_COURSE VARCHAR2(30) NOT NULL,
T_TEL VARCHAR2(15) NOT NULL,
CONSTRAINT TREATMENT_NO_PK PRIMARY KEY(T_NO),
CONSTRAINT TREATMENT_NO_UK UNIQUE(T_COURSE_ABBR)
);

--데이터 삽입
INSERT ALL
INTO TREATMENT(T_NO,T_COURSE_ABBR,T_COURSE,T_TEL)
VALUES(1001,'NS','신경외과','02-3452-1009')
INTO TREATMENT
VALUES(1002,'OS','정형외과','02-3452-2009')
INTO TREATMENT
VALUES(1003,'C','순환기내과','20-3452-3009')
SELECT * FROM DUAL;

SELECT * FROM TREATMENT;

INSERT INTO TREATMENT
VALUES(1002,'OS','정형외과','02-3452-2009');

--DOCTOR 테이블 생성(자식)
CREATE TABLE DOCTOR(
D_NO NUMBER(4) NOT NULL,
D_NAME VARCHAR2(20) NOT NULL,
D_SSN CHAR(14) NOT NULL,
D_EMAIL VARCHAR2(80) NOT NULL,
D_MAJOR VARCHAR2(50) NOT NULL,
T_NO NUMBER(4),
CONSTRAINT DOCTOR_D_NO_PK PRIMARY KEY(D_NO)
);

--부모테이블 삭제시 자식테이블 삭제 (참조)
ALTER TABLE DOCTOR
ADD CONSTRAINT DOCTOR_T_NO FOREIGN KEY(T_NO) REFERENCES TREATMENT(T_NO)
ON DELETE CASCADE; 

INSERT ALL
INTO DOCTOR
VALUES(1,'홍길동','660606-1234561','javauser@naver.com','뇌졸중,뇌혈관외과',1001)
INTO DOCTOR
VALUES(2,'이재환','690724-1234561','jaehwan@naver.com','뇌졸중,뇌혈관외과',1003)
INTO DOCTOR
VALUES(3,'양익환','700129-1234561','sheep1209@naver.com','인공관절,관절염',1002)
INTO DOCTOR
VALUES(4,'김승현','720901-1234561','seunghyeon@naver.com','종양외과,외상전문',1002)

SELECT * FROM DUAL;

SELECT * FROM DOCTOR;

--부모 데이터를 삭제
DELETE FROM TREATMENT
WHERE T_NO =1002;

DROP TABLE TREATMENT;
DROP TABLE DOCTOR;

------------------------------------------------




