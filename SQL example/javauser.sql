--books 테이블 생성

create table books(
book_id number,
title varchar2(80) not null,
publisher varchar2(60) not null,
year varchar2(4) not null,
price number not null,
constraint book_id_pk primary key(book_id)
);
----------------------------------------------------------
--books_seq 시퀀스 생성

create sequence books_seq
start with 1
increment by 1
maxvalue 9999999
minvalue 1
nocycle
cache 2;

delete from books_seq;
----------------------------------------------------------
--데이터 삽입

insert into books
values(books_seq.nextval,'소년이온다','한강','2024',13500);
insert into books
values(books_seq.nextval,'채식주의자','한강','2022',13500);
insert into books
values(books_seq.nextval,'트렌드 코리아 2025','김난도','2024',18000);
insert into books
values(books_seq.nextval,'일의 감각','조수용','2024',19800);
insert into books
values(books_seq.nextval,'어른의 행복은 조용하다','태수','2024',16020);
----------------------------------------------------------

SELECT * FROM BOOKS;
DELETE from books;
DROP SEQUENCE BOOKS_SEQ;

update books
set book_id = 5
where book_id  = 11;

SELECT BOOKS_SEQ.CURRVAL
FROM DUAL;

COMMIT;

--시퀀스의 값을 다시 1로 초기화
--ALTER SEQUENCE 시퀀스명 INCREMENT BY 1;

----------------------------------------------------------

