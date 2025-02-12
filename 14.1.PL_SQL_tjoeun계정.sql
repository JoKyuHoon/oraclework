/*
    * PL / SQL
      오라클 자체에 내장되어 있는 절차적 언어
      SQL 문장 내에서 변수 저의, 조건 처리(IF), 반복문(LOOP, FOR WHILE)등을 지원함
      
      * PL / SQL 구조
       - [선언부 (DECLARE SECTION)] : DECLARE로 시작, 변수나 상수정의 및 초기화하는 부분
       - 실행부 (EXECUTABLE SECTION) : BEGIN으로 시작, SQL문 또는 제어문(조건문, 반복문) 등의 로직을 기술하는 부분
       - [예외처리부 (EXCEPTION SECTION] : 예외처리 부분
*/
-- 화면에 출력문을 보려면 아래 구문을 반드시 실행
SET SERVEROUTPUT ON;

-- 출력문 : HELLO ORACLE
BEGIN 
-- system.out.println("HELLO ORACLE"); > 자바
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
/*
    1. DECLARE 선언부
    변수 및 상수 선언하는 공간(선언과 동시에 초기화도 가능)
    일반타입변수, 레퍼런스 스타일 변수, ROW타입 변수
    
        1.1 일반타입변수 선언 및 초기화
             변수명 [CONSTRANT] 자료형 [:= 값]
        
*/
DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := 800;
    ENAME := '배정남';
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
    
END;
/

-- 1.2) 레퍼런스 스타일 변수 선언 및 초기화(테이블의 컬럼의 데이터타입을 참조하여 그 타입으로 지정)
-- 변수명 테이블명.컬럼명%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    EID := 200;
    ENAME := '유재석';
    SAL := 2500000;
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    
END;
/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    
BEGIN
/*
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL                -- 변수에 SELECT한 결과를 넣어줌 (순서 맞춰줘야함)
    FROM EMPLOYEE
    WHERE EMP_ID = 200;
*/
--사용자로부터 EMP_ID받기
SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL                -- 변수에 SELECT한 결과를 넣어줌 (순서 맞춰줘야함)
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    
   
END;
/

--------------------------------------------------실습문제-------------------------------------------------------------
/*
    레퍼런스 타입변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고
    각 자료형을 참조하여 넣기
    
    사용자가 입력한 사번의 사원을 변수에 담겨있는 값 출력
    
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE                -- 변수에 SELECT한 결과를 넣어줌 (순서 맞춰줘야함)
    FROM EMPLOYEE
    
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
   
END;
/

-- 1.3) ROW타입 변수
--      : 테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
--      변수명 테이블명%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *          --  무조건 * 을 사용해야함.
        INTO E
        FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' ||NVL(E.BONUS, 0)); -- BONUS가 NULL인 사원들은 0으로 표시

END;
/

-----------------------------------------------------------------------------------------------
/*
    * BEGIN
    <조건문>
    1) IF 무조건식 THEN 실행내용 END IF;  (단일 IF문)
*/

-- 사번 입력받은 후 그 사원의 사번, 사원명, 급여, 보너스율(%) 출력
-- 단, BONUS를 받지 않는 사원은 보너스율을 출력전 '보너스를 받지 않는사원입니다' 출력

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    
    IF BONUS = 0
    THEN DBMS_OUTPUT.PUT_LINE ('보너스를 받지 않는 사원입니다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS*100 || '%');
END;
/

--  2) IF 조건식 THEN 실행내용 ELSE 실행내용 END IF; (IF ELSE문)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    
    IF BONUS = 0
    THEN DBMS_OUTPUT.PUT_LINE ('보너스를 받지 않는 사원입니다.');
        ELSE DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS*100 || '%');

    END IF;
END;
/

--------------------------------------------------실습문제-------------------------------------------------------------
/*
    레퍼런스 변수 : EID, ENAME, DTITLE, NCODE
    참조 변수 : EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    일반 변수 : TEAM(소속)
    
    실행 : 사용자가 입력한 사번, 이름, 부서명, 근무국가코드를 변수에 대입
            단, NCODE값이 KO일 때 TEAM변수에 '국내팀'
                                 KO가 아닐때 TEAM변수에 '해외팀'
    출력 : 사번, 이름, 부서명, 소속
*/


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE NATIONAL.NATIONAL_CODE%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN NATIONAL USING(NATIONAL_CODE)

    WHERE EMP_ID = &사번 
    AND EMP_NAME = &이름  
    AND DEPT_TITLE = &부서명 
    AND NATIONAL_CODE = &근무국가코드;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('근무국가코드 : ' || NCODE);
    
    IF NCODE = 'KO'
    THEN DBMS_OUTPUT.PUT_LINE ('국내팀');
        ELSE DBMS_OUTPUT.PUT_LINE('해외팀');

    END IF;
END;

/




DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(20);

BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &사번;
    
    IF NCODE = 'KO' 
      THEN 
        TEAM := '국내팀';
    ELSE 
        TEAM := '해외팀';   
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
    
END;
/


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(20);

BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &사번;
    
    IF NCODE = 'KO' 
      THEN 
        TEAM := '국내팀';
    ELSE 
        TEAM := '해외팀';   
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
    
END;
/







