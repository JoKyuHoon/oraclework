/*
    * TCL(TRANSACTION CONTROL LANGUAGE) : 트랜잭션 제어언어
    
    * 트랜잭션
    - 데이터베이스의 논리적 연산단위
    - 데이터의 변경사항(DML)들을 하나의 트랜잭션에 묶어서 처리
      DML문 한개를 수행할 때 트랜잭션 존재하면 해당 트랜잭션에 같이 묶어서 처리
      DML문 한개를 수행할 때 트랜잭션이 존재하지 않으면 트랜잭션을 만들어서 묶어서 처리
      COMMIT 하기 전까지의 변경사항들을 하나의 트랜잭션에 담는다
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE 
    
    COMMIT (트랜잭션 종료 처리 후 확정)
    - 한 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영 시킴(트랜잭션 없어짐)
    ROLLBACK(트랜잭션 취소)
    - 트랜잭션에 담겨있는 변경사항들을 삭제(취소) 한 후 마지막 COMMIT시점으로 돌아감
    SAVEPOINT (임시저장)
    - 현재 이 시점에 해당포인트명으로 임시저장점을 정의해둠
      ROLLBACK 진행시 변경사항들을 다 삭제하는게 아니라 일부만 삭제가능
*/

SELECT * FROM EMP_01;

-- 사번 301인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 301;

-- 사번 210번인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 210;

ROLLBACK; -- 지웠던 301, 210번이 돌아옴

------------------------------------------------------------------------------------------------------
-- 사번 201번인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 201;

SELECT * FROM EMP_01;

INSERT INTO EMP_01 
    VALUES (302, '방생환', 'B4');

COMMIT;

ROLLBACK; -- COMMIT을 했기 때문에 ROLLBACK 안됨

-----------------------------------------------------------------------------------------------------
DELETE FROM EMP_01
WHERE EMP_ID IN(210, 217, 214);

SAVEPOINT SP;

-- 218 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID IN(218);

-- 임시저장소 SP까지만 롤백
ROLLBACK TO SP;

-- 사원 추가
INSERT INTO EMP_01
VALUES(108, '조호구', 'D2');

----------------------------------------------------------------------------------------------------
/*
    * 자동으로 COMMIT이 되는 경우
    - 정상 종료
    - DCL / DDL 명령문이 수행된 경우 (CREATE, ALTER, ...)
    * 자동으로 ROLLBACK이 되는 경우
    - 비정상 종료(프로그램 멈춤, 컴퓨터 강제 종료, ...)
*/

-- 사번 302, 303 지우기
DELETE FROM EMP_01
WHERE EMP_ID IN (302, 301);

-- 사번 205 지우기
DELETE FROM EMP_01
WHERE EMP_ID IN (205);

-- DDL문(테이블 생성) >> 기존의 트랜잭션에 있던 변경사항들을 무조건 COMMIT 해줌

CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK; -- ROLLBACK안됨

SELECT * FROM EMP_01;



