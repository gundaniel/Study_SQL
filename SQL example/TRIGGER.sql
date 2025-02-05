-----------------------------------------------------------
--테이블 생성
CREATE TABLE PRODUCTLOGS(
LOG_NO NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
ACTION VARCHAR2(10),
CONTENT VARCHAR2(100),
ACTIONDATE DATE DEFAULT SYSDATE
);
-----------------------------------------------------------
--코멘트 작성
COMMENT ON COLUMN PRODUCTLOGS.LOG_NO IS '제품로그 번호';
COMMENT ON COLUMN PRODUCTLOGS.ACTION IS '처리[INSERT|UPDATE|DELETE]';
COMMENT ON COLUMN PRODUCTLOGS.CONTENT IS '내용';
COMMENT ON COLUMN PRODUCTLOGS.ACTIONDATE IS '처리일';
-----------------------------------------------------------
SELECT * FROM PRODUCTLOGS;
-----------------------------------------------------------
--제품을 추가할때 마다 로그테이블에 정보를 남기는 트리거 작성

CREATE OR REPLACE TRIGGER TRI_PRODUCTLOG_INSERT
AFTER INSERT ON PRODUCT
FOR EACH ROW
BEGIN
INSERT INTO PRODUCTLOGS(ACTION,CONTENT)
VALUES('INSERT','제품번호:' || :NEW.PRODUCT_NO || '제품명'|| :NEW.PRODUCT_NAME);
END;
/
-----------------------------------------------------------
--제품을 추가
INSERT INTO PRODUCT(PRODUCT_NO,PRODUCT_NAME,UNIT_PRICE,STOCK)
VALUES(99,'레몬캔디',2000,10);

SELECT * FROM PRODUCT;
-----------------------------------------------------------
--추가된 제품에 대한 로그 확인
SELECT * FROM PRODUCTLOGS;

-----------------------------------------------------------
--단가나 재고가 변경되면 변경된 사항을 제품 테이블에 저장하는 트리거를 작성

CREATE OR REPLACE TRIGGER TRI_PRODUCTLOG_UPDATE
AFTER UPDATE ON PRODUCT
FOR EACH ROW -- 행레벨 트리거 작성
BEGIN 
IF(:NEW.UNIT_PRICE <> :OLD.UNIT_PRICE) THEN
INSERT INTO PRODUCTLOGS(ACTION,CONTENT)
VALUES('UPDATE','제품번호:' ||:OLD.PRODUCT_NO || '단가' || :OLD.UNIT_PRICE || '->' || :NEW.UNIT_PRICE);
END IF;

IF(:NEW.STOCK <> :OLD.STOCK) THEN --재고가 기존과 다르다면
INSERT INTO PRODUCTLOGS(ACTION, CONTENT)
VALUES ('UPDATE','제품번호:' ||:OLD.PRODUCT_NO || '재고:' || :OLD.STOCK || '->' || :NEW.STOCK);
END IF;
END;
/
-----------------------------------------------------------
--재고 변경
UPDATE PRODUCT
SET STOCK = 23
WHERE PRODUCT_NO = 99;

--단가변경
UPDATE PRODUCT
SET UNIT_PRICE = 2500
WHERE PRODUCT_NO = 99;

--확인
SELECT * FROM PRODUCT
WHERE PRODUCT_NO = 99;

SELECT * FROM PRODUCTLOGS;
-----------------------------------------------------------
--테이블에서 제품정보를 삭제하면 삭제된 레코드의 정보를 제품로그 테이블에 저장하는 트리거 생성
-- DROP TRIGGER TRI_PRODUCT_DELETE;

CREATE OR REPLACE TRIGGER TRI_PRODUCTLOG_DELETE
AFTER DELETE ON PRODUCT
FOR EACH ROW
BEGIN
INSERT INTO PRODUCTLOGS(ACTION, CONTENT)
VALUES('DELETE','제품번호:' || :OLD.PRODUCT_NO ||  '제품명:' || :OLD.PRODUCT_NAME);
END;
/

COMMIT;

DELETE FROM PRODUCT
WHERE PRODUCT_NO = 99;
