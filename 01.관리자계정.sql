-- 한줄 주석(단축키 : ctrl + /)
/*
    여러줄 주석
    주석
    alt + shift + c
*/

-- 나의 계정
SHOW USER;

-- 사용자 계정 조회
SELECT * FROM DBA_USERS;

SELECT USERNAME, ACCOUNT_STATUS FROM DBA_USERS;

-- 사용자 만들기
-- 오라클 12버전부터 일반사용자는 c##으로 시작하는 이름을 가져야한다.

CREATE USER c##user1 IDENTIFIED BY 1234;

-- c##을 회피하는 방법
ALTER SESSION SET "_oracle_script" = true;

CREATE USER user1 IDENTIFIED BY 1234;

--사용할 계정 만들기
--계정명은 대소문자 상관없음
--비밀번호는 대소문자 가림
CREATE USER tjoeun IDENTIFIED BY 1234;

--접근할 수 있는 권한 생성
--[표현법] GRANT 권한1,권한2, ... TO 계정명;
GRANT CONNECT TO tjoeun;
GRANT RESOURCE TO tjoeun;

--insert 시 테이블 스페이스 users에 대한 권한이 없습니다. 라는 오류가 뜰 시
ALTER USER tjoeun QUOTA UNLIMITED ON USERS;
--ALTER USER tjoeun quota default tablespace users quota unlimited on user;
--ALTER USER tjoeun quota 50M on user;

-- workbook사용자 만들기
ALTER SESSION SET "_oracle_script" = true;
CREATE USER workbook IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO workbook;
ALTER USER workbook default tablespace users quota unlimited on users;

ALTER USER scott ACCOUNT UNLOCK;
ALTER USER scott IDENTIFIED BY 1234;
-- scott사용자 만들기

ALTER SESSION SET "_oracle_script" = TRUE; -- (12c 이상에서 필요)
CREATE USER scott IDENTIFIED BY 1234; -- 비밀번호는 원하는 값으로 변경
GRANT CONNECT, RESOURCE TO scott;
ALTER USER scott DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;


