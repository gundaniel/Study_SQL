
-- 고객 테이블
CREATE TABLE CUSTOMER (
   CUSTOMER_NO CHAR(5) PRIMARY KEY,    --고객번호
   COMPANY_NAME VARCHAR2(30) NOT NULL, --고객회사명
   CONTACT_NAME VARCHAR2(20),          --담당자명
   CONTACT_POSITION VARCHAR2(20),      --담당자직위
   ADDRESS VARCHAR2(50),               --주소
   CITY VARCHAR2(20),                  -- 도시
   REGION VARCHAR2(20),                -- 지역
   PHONE_NUMBER VARCHAR2(20),          -- 전화번호
   MILEAGE NUMBER                      -- 마일리지
);
COMMENT ON COLUMN CUSTOMER.CUSTOMER_NO IS '고객번호';
COMMENT ON COLUMN CUSTOMER.COMPANY_NAME IS '고객회사명';
COMMENT ON COLUMN CUSTOMER.CONTACT_NAME IS '담당자명';
COMMENT ON COLUMN CUSTOMER.CONTACT_POSITION IS '담당자직위';
COMMENT ON COLUMN CUSTOMER.ADDRESS IS '주소';
COMMENT ON COLUMN CUSTOMER.CITY IS '도시';
COMMENT ON COLUMN CUSTOMER.REGION IS '지역';
COMMENT ON COLUMN CUSTOMER.PHONE_NUMBER IS '전화번호';
COMMENT ON COLUMN CUSTOMER.MILEAGE IS '마일리지';

SELECT * FROM CUSTOMER;
----------------------------------------------------------------------------------
-- 도시가 '광역시'이면서 고객번호 두 번째 글자 또는 세 번째 글자가 'C'인 고객의 모든 정보를 보이시오.

SELECT * FROM CUSTOMER
WHERE CITY LIKE('%광역시%') AND (CUSTOMER_NO LIKE '__C%' OR CUSTOMER_NO LIKE '_C%');

----------------------------------------------------------------------------------
-- 서울에 사는 고객 중에 마일리지가 15,000점이상 20,000점 이하인 고객이 모든 정보를 출력한다.
SELECT * FROM CUSTOMER
WHERE CITY LIKE '서울%' AND MILEAGE BETWEEN 15000 AND 20000;
----------------------------------------------------------------------------------
-- 고객들은 어느 지역, 어느 도시에 사는지 지역과 도시를 한 번씩만 출력한다.
-- 이때 결과를 지역 순으로 나타내고, 동일 지역에 대해서는 도시 순으로 나타내봅시다.

SELECT DISTINCT REGION, CITY
FROM CUSTOMER
ORDER BY 1,2;
----------------------------------------------------------------------------------
-- 춘천시나 과천시 또는 광명시에 사는 고객 중에서 담당자 직위에 이사 또는 사원이 들어가는 고객의 모든 정보를 출력한다
SELECT * FROM CUSTOMER 
WHERE CITY IN('춘천시','과천시','광명시')
AND (CONTACT_POSITION LIKE '%이사%' OR CONTACT_POSITION LIKE '%사원%');
----------------------------------------------------------------------------------
-- 지역에 값이 들어있는 고객 중에서 담당자직위가 대표이사인 고객을 빼고 출력한다.`
SELECT * FROM CUSTOMER
WHERE REGION IS NOT NULL -- IS NOT NULL = 널이 아닌 값을 출력
AND CONTACT_POSITION <> '대표이사';   -- <> 같지 않다
----------------------------------------------------------------------------------
-- 고객 테이블의 마일리지 컬럼에 대하여 마일리지 합과 평균 마일리지, 최소 마일리지와 최대 마일리지를 조회하시오.

SELECT SUM(MILEAGE) AS "합", FLOOR(AVG(MILEAGE)) AS "평균", MIN(MILEAGE) AS"최소", MAX(MILEAGE) AS "최대"
FROM CUSTOMER;

-- 위 예제에서 수정.
-- 고객 테이블에서 '서울특별시' 고객에 대해 마일리지합, 평균마일리지, 최소마일리지, 최대마일리지를 조회하시오.
SELECT CITY, SUM(MILEAGE) AS "합", FLOOR(AVG(MILEAGE)) AS "평균", MIN(MILEAGE) AS"최소", MAX(MILEAGE) AS "최대"
FROM CUSTOMER
GROUP BY CITY
HAVING CITY LIKE('%서울특별시%');

-- 고객 테이블에서 도시별 고객의 수와 해당 도시 고객들의 평균마일리지를 조회하시오.

SELECT CITY,COUNT(*) AS 고객수, AVG(MILEAGE) AS 평균마일리지
FROM CUSTOMER
GROUP BY CITY
ORDER BY CITY;


-- 담당자직위별로 묶고, 같은 담당자직위에 대해서는 도시별로 묶어서 집계한 결과(고객수와 평균마일리지)를 보이시오. 

SELECT CONTACT_POSITION , CITY
FROM CUSTOMER
WHERE  



-- (이때 담당자직위 순, 도시 순으로 정렬하기)

--고객 테이블에서 도시별로 그룹을 묶어서 고객수와 평균마일리지를 구하고, 이 중에서 고객수가 10명 이상인 레코드만 걸러내시오.


















