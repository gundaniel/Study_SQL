--사용자 계정

--사용자 만들기
create user javauser identified by java1234;

--사용자의 권한 생성
grant create session to javauser;

--구문 : grant 롤 to 사용자명;
grant connect, resource to javauser;

--resource: 사용자 계정으로 테이블등을 생성 이용할 수 있는 권한
--connect 사용자가 db에 접속할 수 있는 권한

select * from dba_tablespaces;
select * from dba_data_files;

alter user javauser
default tablespace users quota unlimited on users;

--connect 롤에 포함 된 권한 - create session 권한이 없으면 해당 유저로 접속이 되지 않음
select * from role_sys_privs
where role = 'CONNECT';

--resource 롤에 포함된 권한
select * from role_sys_privs
where role='resource';
--create 트리거, 시퀸스, 타입, 프로시저, 테이블 등 8가지 권한이 부여되어 있음

--먼저 javauser에게 부여된 롤 확인
select * from dba_role_privs
where grantee = 'javauser';