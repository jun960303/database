-- C##  을 사용안하도록 설정 
-- 오라클버전이 업데이트되면서 사용자 설정할 때 아이디 앞에 C##을 붙이도록 설정되어 있음 
-- hr 사용자 생성 => c##hr
ALTER SESSION SET "_oracle_script"=TRUE;

--@C:\Users\rhkdd\Downloads\db-sample-schemas-main\db-sample-schemas-main\human_resources\hr_install.sql
--@C:\app\rhkdd\product\21c\dbhomeXE\rdbms\admin\scott.sql
--sys AS ysdba

-- 권한부여 : GRANT
GRANT CREATE VIEW TO SCOTT;

GRANT CREATE PUBLIC SYNONYM TO SCOTT;
GRANT CREATE synonym TO scott;


-- 사용자생성
-- 데이터베이스에 접속하여 데이터 관리하는 계정

-- 오라클 데이터베이스 
-- 테이블 , 뷰, 인덱스, 시컨스 .... => 업무별 사용자 생성 후 객체 생성할 수 있는 권한 부여

-- CREATE USER 사용자 이름 INDENTIFIED BY 비밀번호 ; 

-- 
DROP USER TEST1;

CREATE USER TEST1 IDENTIFIED BY 12345;

ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER TEST2 IDENTIFIED BY 12345;


--ORA-01045: 사용자 TEST2는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다
GRANT CREATE SESSION TO test2;

-- 개별권한 묶어서 관리 => 를 
GRANT CONNECT , resource TO test2;

--테이블스페이스 'USERS'에 대한 권한이 없습니다.
ALTER USER TEST2 DEFAULT TABLESPACE USERS QUOTA 2M ON USERS;

CREATE USER TEST3 IDENTIFIED BY 12345 
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE temp
QUOTA 2M ON USERS;


GRANT CONNECT , resource TO test3;

-- 사용자 삭제 
-- 'TEST2'(을)를 삭제하려면 CASCADE를 지정하여야 합니다
DROP USER TEST3 CASCADE;

-- 권한 취소 
--REVOKE 취소할권한이름 FROM 사용자명
REVOKE CREATE SESSION FROM test2;

-- 비밀번호변경 
ALTER USER test3 IDENTIFIED BY 변경할비밀번호;