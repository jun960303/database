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
