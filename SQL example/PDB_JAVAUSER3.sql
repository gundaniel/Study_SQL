
--1. 학번, 학생명, 학과번호, 학과명 출력 쿼리문
SELECT SD_NUM 학번, SD_NAME 학생명 , S.S_NUM 학과번호, S_NAME 학과명
FROM STUDENT S INNER JOIN SUBJECT J 
ON S.S_NUM = J.S_NUM;

--위 예제를 서브 쿼리로 변환 
-------------------------------------------------------
--학교 학과명, 학과 소속 학생, 아이디 출력
SELECT S_NAME 학과명, SD_NAME 소속학생, SD_ID 아이디
FROM STUDENT S INNER JOIN SUBJECT D 
ON D.S_NUM = S.S_NUM;


SELECT S_NAME 학과명, SD_NAME 소속학생, SD_ID 아이디
FROM STUDENT S RIGHT OUTER JOIN SUBJECT D 
ON D.S_NUM = S.S_NUM
ORDER BY D.S_NUM;
-------------------------------------------------------
--SELECT SD_NAME, 
SELECT * FROM ENROLLMENT;
SELECT * FROM STUDENT;

UPDATE STUDENT
SET S_NUM  = '02'
WHERE NO = 6;

------------------------------------------------------------
--3. 학과에 소속된 학생 수를 출력하도록 쿼리문 작성해 주세요.

--<1> 학과와 학생수를 출력
SELECT S_NUM, COUNT (SD_NUM)
FROM STUDENT
GROUP BY S_NUM
ORDER BY 1;

--<2> 학과명과 학생수를 출력
SELECT S_NAME 학과명, COUNT(SD_NUM) 학생수
FROM SUBJECT SB INNER JOIN STUDENT ST
ON SB.S_NUM = ST.S_NUM
GROUP BY S_NAME, SB.S_NUM
ORDER BY SB.S_NUM;

--<2-1> OUTER JOIN을 이용한 전체 학과 출력
SELECT S_NAME 학과명, COUNT(SD_NUM) 학생수
FROM SUBJECT SB LEFT OUTER JOIN STUDENT ST
ON SB.S_NUM = ST.S_NUM
GROUP BY S_NAME, SB.S_NUM
ORDER BY SB.S_NUM;

------------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_STUDENT
AS
SELECT SD_NUN, SD_NAME, S_NAME
FROM STUDENT S INNER JOIN SUBJECT J
ON S.S_NUM = J.S_NUM;


SELECT * FROM BOOKS;

DELETE FROM BOOKS;

-- 학과번호를 자동으로 구하는 쿼리문을 작성해 주세요.
SELECT * FROM SUBJECT;
SELECT * FROM STUDENT;

------------------------------------------------------------
--학번, 학생명, 학과번호, 학과명을 서브쿼리로 출력 (SELECT 문내 서브쿼리는 단일행으로 출력)
SELECT SD_NUM AS 학번, SD_NAME AS 학생명 ,S_NUM AS 학과번호,(SELECT S_NAME FROM SUBJECT WHERE ST.S_NUM = S_NUM) AS 학과명
FROM STUDENT ST;

SELECT * FROM ENROLLMENT;
SELECT * FROM STUDENT;
SELECT * FROM COURSE;

SELECT SD_NAME AS 학생명, C.C_NAME AS 과목명, TO_CHAR(E_DATE,'YYYY-MM-DD') AS 수강신청일
FROM ENROLLMENT E INNER JOIN STUDENT S ON E.SD_NUM = S.SD_NUM
                    INNER JOIN COURSE C ON E.C_NUM = C.C_NUM;
                  
SELECT TO_CHAR(E_DATE,'YYYY-MM-DD') AS 수강신청일, C_NAME AS 과목명
FROM ENROLLMENT E INNER JOIN COURSE C ON E.C_NUM = C.C_NUM;  
                        
DESC COURSE;
DESC ENROLLMENT;
DESC STUDENT;

ALTER TABLE ENROLLMENT
MODIFY (SD_NUM VARCHAR2(15));
                          
UPDATE  COURSE
SET C_NUM ='UA05001'
WHERE C_NUM = 'UA050001';

------------------------------------------------------------

select * from subject order by no; 
--자동으로 학과를 부여하는 쿼리문 작성
select nvl(lpad(max(to_number(LTRIM(s_num,'0'))) + 1,2, '0'), '01')
as subjectNum from subject;

SELECT nvl(to_char(max(s_num)+1, 'FM00'),'01')
as subjectNum FROM subject;

                    


