-- 3번 권한 부여받은 후 가능
CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(20)
);
-- 4번 권한 부여받은 후 가능
INSERT INTO TEST VALUES(1,'HI');

-- 5번 권한 부여받은 후 가능
SELECT *
FROM TJOEUN.EMPLOYEE;

-- 6번 권한 부여받은 후 가능
INSERT INTO TJOEUN.EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE) 
    VALUES(302, '홍길동', '210324-7894567', 'J2');
    
    COMMIT;
    
    