-- board 게시판 테이블 (사용자: javauser)
create table board(
   num number(4)          not null,
   author varchar2(20)    not null,
   title  varchar2(500)   not null,
   content varchar2(4000) not null,
   writeday date  default sysdate,
   readcnt  number(4) default 0,
   reproot  number(4),
   repstep  number(4),
   repindent number(4),
   passwd varchar2(12)    not null,
   constraint board_pk primary key(num)
 );
 
-- 답변형 게시판을 위한 컬럼  
-- reproot, repstep,  repindent 

-- drop table board;
comment on table  board is '게시판 테이블';
comment on column board.num is '게시판 번호';
comment on column board.author is '게시판 작성자';
comment on column board.title is '게시판 제목';    
comment on column board.content is '게시판 내용';
comment on column board.writeday is '게시판 등록일';     
comment on column board.readcnt is '게시판 조회수';     
comment on column board.reproot is '게시판 답변글(원래글의 번호 참조 - 그룹번호)';
comment on column board.repstep is '게시판 답변글(답변글의 위치번호 지정)';
comment on column board.repindent is '게시판 답변글(답변글의 계층번호 지정)';
comment on column board.passwd is '게시판 비밀번호';

-- board 게시판 테이블에 저장할 글번호 시퀀스 (증가값: 시퀀스명.nextval / 현재값: 시퀀스명.currval)
create sequence board_seq start with 1
increment by 1
minvalue 1
nocycle
cache 2;

--drop sequence board_seq; 

-- 일반 게시글 입력 시 reproot: num의 값. repstep/repindent : 0으로 입력한다.
select * from board;

insert into board( num, author, title, content, reproot, repstep, repindent, passwd )
values ( board_seq.nextval , '홍길동', '노력에 관련된 명언' , 
'중요한 것은 목표를 이루는 것이 아니라 그 과정에서 무엇을 배우며 얼마나 성장했느냐이다 - 앤드류 매튜스' ,
board_seq.currval, 0,0, '1234' );

insert into board( num, author, title, content, reproot, repstep, repindent, passwd )
values ( board_seq.nextval ,'한강', '채식주의자' , '육식을 끊고 채식을 함', board_seq.currval, 0,0, '1234' );


commit;


regexp_like() 함수
regexp_like는 SQL에서 주어진 문자열이 특정 정규 표현식 패턴과 일치하는지 확인하는 함수.
형식: REGEXP_LIKE(컬럼명, '패턴')


