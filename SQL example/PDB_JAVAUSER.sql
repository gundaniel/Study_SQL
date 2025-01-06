
-----------------------------------------------
--학과 테이블 생성

CREATE TABLE SUBJECT(
NO NUMBER(2) NOT NULL,
S_NUM NUMBER(2) NOT NULL,
S_NAME VARCHAR2(50) NOT NULL,
CONSTRAINT SUBJECT_NO_PN PRIMARY KEY(NO)
 );
 
 --유일키가 아닌 컬럼은 외래키를 잡을 수 없음
 
SELECT * FROM SUBJECT;

DESC SUBJECT;

--학과번호를 유일키로 설정
ALTER TABLE SUBJECT
MODIFY(S_NUM UNIQUE); 


--제약 조건 삭제 (이름을 반드시확인해야 함 //기본키 삭제)
ALTER TABLE SUBJECT DROP CONSTRAINT SYS_C008225; 


--제약조건 확인
SELECT
    constraint_name,
    constraint_type,
    table_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name = 'SUBJECT';

--시퀀스
CREATE SEQUENCE SUBJECY START WITH 1  --1부터 시작
INCREMENT BY 1 --1개 증가
MINVALUE 1 --최솟값 1
MAXVALUE 999999 --최댓값
NOCYCLE --반복없음
CACHE 2; --2 저장

INSERT INTO SUBJECT
VALUES(SUBJECY.NEXTVAL,'01','컴퓨터학과');
INSERT INTO SUBJECT
VALUES(SUBJECY.NEXTVAL,'02','교육학과');
INSERT INTO SUBJECT
VALUES(SUBJECY.NEXTVAL,'03','신문방송학과');
INSERT INTO SUBJECT
VALUES(SUBJECY.NEXTVAL,'04','인터넷비지니스학과');
INSERT INTO SUBJECT
VALUES(SUBJECY.NEXTVAL,'05','기술경영과');
-----------------------------------------------
--학생 테이블 생성

DROP TABLE STUDENT;

CREATE TABLE STUDENT(
NO NUMBER(2) NOT NULL,
SD_NUM NVARCHAR2(8) NOT NULL,
SD_ID VARCHAR2(30) NOT NULL,
SD_NAME VARCHAR2(20) NOT NULL,
SD_PASSWD VARCHAR2(30) NOT NULL,
S_NUM NVARCHAR2(2) NOT NULL,
SD_BIRTH DATE NOT NULL,
SD_PHONE VARCHAR2(30) NOT NULL,
SD_ADDRESS VARCHAR2(50) NOT NULL,
SD_DATE DATE NOT NULL,
CONSTRAINT STUDENT_NO_PK PRIMARY KEY(NO),
CONSTRAINT STUDENT_SDNUM_UK UNIQUE(SD_NUM),
CONSTRAINT STUDENT_SD_UK UNIQUE(SD_ID),
CONSTRAINT STUDENT_SNUM_FK FOREIGN KEY(S_NUM) REFERENCES SUBJECT(S_NUM)
);

--SD_DATE를 고정 문자데이터로 변경
ALTER TABLE STUDENT
MODIFY(SD_DATE CHAR(8));

--SD_DATE에서 현재날짜를 DEFAULT로 설정
ALTER TABLE STUDENT
MODIFY(SD_DATE DEFAULT SYSDATE);

--SD_ADDRESS 데이터 용량 변경
ALTER TABLE STUDENT
MODIFY(SD_ADDRESS VARCHAR2(100));


SELECT * FROM STUDENT;
--기존 칼럼을 삭제
DELETE FROM STUDENT
WHERE S_NUM ='02';

--학생테이블에서 학번이 8자리로 들어오게 수정
--ALTER TABLE STUDENT
--MODIFY(SD_NUM CHECK(SD_NUM IN (TO_CHAR(TO_DATE(YY)+S_NUM('99'),'99999999'))));

-----------------------------------------------
--시퀸스 설정
CREATE SEQUENCE STUDENT_SEQ START WITH 1  --1부터 시작
INCREMENT BY 1 --1개 증가
MINVALUE 1 --최솟값 1
MAXVALUE 999999 --최댓값
NOCYCLE --반복없음
CACHE 2; --2 저장

--시퀀스 삭제
DROP SEQUENCE STUDENT_SEQ;
-----------------------------------------------
--학생 데이터 입력

INSERT INTO STUDENT
VALUES(STUDENT_SEQ.NEXTVAL,'06010001','김정수','javajsp','12345678','01','19940209','010-1234-5678','(03727) 서울특별시 서대문구 성산로 450-2',DEFAULT);
INSERT INTO STUDENT
VALUES(STUDENT_SEQ.NEXTVAL,'95010002','김수현','jdbcmania','12345678','01','19950422','010-1234-5678','(06774) 서울 특별시 서초구 강남대로 27',DEFAULT);
INSERT INTO STUDENT
VALUES(STUDENT_SEQ.NEXTVAL,'98040001','공지영','gonji','12345678','04','19980603','010-1234-5678','(48000)부산광역시 해운대구 반송로 816',DEFAULT);
INSERT INTO STUDENT
VALUES(STUDENT_SEQ.NEXTVAL,'02050001','조수영','water','12345678','05','20020501','010-1234-5678','(34626)대전광역시 동구 중앙로 215',DEFAULT);
INSERT INTO STUDENT
VALUES(STUDENT_SEQ.NEXTVAL,'94040002','최경란','novel','12345678','04','19940504','010-1234-5678','(16210)경기도 수원시 장안구 서부로 2287-55',DEFAULT);
INSERT INTO STUDENT
VALUES(STUDENT_SEQ.NEXTVAL,'08020001','안익태','korea','12345678','02','20080201','010-1234-5678','(08707)조선 민주주의공화국 58',DEFAULT);
--레코드 수정
UPDATE STUDENT
SET SD_NUM = '06010001'
WHERE SD_NUM ='6010001';

UPDATE STUDENT
SET NO = 1
WHERE N0 = 15;


--레코드 삭제
DELETE FROM STUDENT
WHERE NO =2;

SELECT *FROM COURSE;
-----------------------------------------------
--과목 시퀀스 생성
CREATE SEQUENCE COURSE_SEQ START WITH 1  --1부터 시작
INCREMENT BY 1 --1개 증가
MINVALUE 1 --최솟값 1
MAXVALUE 999999 --최댓값
NOCYCLE --반복없음
CACHE 2; --2 저장




--과목 테이블 생성

CREATE TABLE COURSE(
NO NUMBER(2)NOT NULL,
C_NUM NVARCHAR2(7) NOT NULL,
C_NAME NVARCHAR2(20) NOT NULL,
C_CREDIT NUMBER(2) NOT NULL,
C_SECTION NVARCHAR2(2) NOT NULL,
CONSTRAINT COURSE_NO_PK PRIMARY KEY(NO),
CONSTRAINT COURSE_CREDIT_CK CHECK(C_CREDIT  >= 2 AND C_CREDIT <=4) --학점이 2부터 4까지만 수용되도록 수정
);

--ADD TABLE COURSE

--테이블수정
--ALTER TABLE COURSE
--MODIFY(C_CREDIT CHECK(C_CREDIT >= 2 AND C_CREDIT <= 4));

--과목구분이 교양,일반, 전공만들어오게 수정
ALTER TABLE COURSE
MODIFY(C_SECTION CHECK(C_SECTION IN('교양','일반','전공')));
select no, c_num, c_name, c_credit, c_section from course ;

SELECT * FROM COURSE;
--DROP TABLE COURSE;

--ALTER TABLE COURSE
--DROP COLUMN C_CREDIT;

--ALTER TABLE COURSE
--ADD(C_CREDIT NUMBER(2)NOT NULL);

--데이터 삽입
INSERT INTO COURSE VALUES(1,'UA04001','대학영어',2,'교양');
INSERT INTO COURSE VALUES(2,'UA05001','소프트웨어와 창의적 사고',4,'교양');
INSERT INTO COURSE VALUES(3,'UBB0001','독서와 토론',3,'교양');
INSERT INTO COURSE VALUES(4,'UGG0010','한국의 이해',3,'일반');
INSERT INTO COURSE VALUES(5,'UGG0031','내 아이디어로 창업하기',4,'일반');
INSERT INTO COURSE VALUES(6,'UCR0001','데이터베이스 설계와 구축',4,'전공');
-----------------------------------------------
--수강테이블 생성
CREATE TABLE ENROLLMENT(
NO NUMBER(2) NOT NULL,
E_YEAR DATE NOT NULL,
E_SEMESTER VARCHAR2(20) NOT NULL,
SD_NUM NVARCHAR2(2) NOT NULL,
C_NUM NVARCHAR2(7) NOT NULL,
E_GRADE NUMBER(2,1) NOT NULL,
E_DATE DATE NOT NULL,
CONSTRAINT ENROLLMENT_NO_PK PRIMARY KEY(NO),
CONSTRAINT ENROLLMENT_E_GRADE_CK CHECK(E_GRADE >= 0 AND E_GRADE <= 4.5) -- 성적이 0부터 4.5까지만 들어오게 수정
);
ALTER TABLE ENROLLMENT
MODIFY(E_GRADE NUMBER(3,2));

--수강학기가 4가지만 들어오게 수정
ALTER TABLE ENROLLMENT
MODIFY(E_SEMESTER CHECK (E_SEMESTER IN('1학기','2학기','여름학기','겨울학기')));

SELECT * FROM ENROLLMENT;
--DROP TABLE ENROLLMENT;

--데이터 삽입
INSERT INTO ENROLLMENT
VALUES(1,TO_DATE(2004,'YYYY'),'1학기','06010001','UA05001',TO_CHAR(4,'0.0'),SYSDATE);

DELETE FROM ENROLLMENT
WHERE NO=1;

INSERT INTO ENROLLMENT
VALUES(2,TO_DATE(2004,'YYYY'),'1학기','06010001','UA05001',4.0,SYSDATE);
INSERT INTO ENROLLMENT
VALUES(3,TO_DATE(2004,'YYYY'),'1학기','06010001','UA05001',4.0,SYSDATE);
INSERT INTO ENROLLMENT
VALUES(4,TO_DATE(2004,'YYYY'),'1학기','06010001','UA05001',4.0,SYSDATE);




