-- 사용할 데이터베이스 지정
use sakila 

select * from customer;

-- first_name 이 MARIA 인 데이터 조회 
select * from customer c where c.first_name = 'MARIA';

-- first_name 열에서 데이터가 A,B,C순으로 'MARIA' 보다 앞에 위치한 데이터 조회 
select * from customer c where c.first_name < 'MARIA';

-- first_name 이 'M' ~ 'O'사이의 데이터가 아닌 데이터 조회 
select * from customer  where first_name not between 'M' and'O';

-- first_name 이 'MARIA' , 'LINDA' 인 데이터 조회 
select * from customer where first_name in ('MARIA','LINDA');

-- first_name 이 'A' 로 시작하는 데이터 조회 
select * from customer where first_name like 'A%';

-- first_name 이 'A' 로 시작하고 문자열 길이가 3인 데이터 조회 
select * from customer where first_name like 'A__';


-- first_name 이 'A' 로 시작하고 'A'로 끝나면서 문자열 길이가 4인 데이터 조회
select * from customer where first_name like 'A__A';

-- film 테이블
-- special_features 를 기준으로 그룹화 후 count()사용
select f.special_features  from film f group by f.special_features;

-- special_features 를 기준으로 그룹화 후 rating 이 G 인 데이터 조회
select f.special_features,f.rating   from film f group by f.special_features,f.rating having f.rating ='G';

-- adress 테이블 
-- adress_id 가 200 미만 데이터 조회 
select * from address a where a.address_id < 200;

-- adress_id 가 5~10 범위에 해당하는 데이터 조회 
select * from address a where a.address_id between 5 and 10;

-- adrees2 열 데이터가 널이 아닌 데이터 조회
select * from address a where a.address2 is not null;

-- CITY 테이블 
-- COUNTRY_ID 가 103 or 86 이면서 , CITY 열이 'Cheju','Sunnyvale','Dallas' 인 데이터 조회
select * from city c where c.country_id in(103,86)and c.city in('Cheju','Sunnyvale','Dallas');

-- PAYMENT 테이블
-- PAYMENT_DATE 가 2005-07-09 미만인 행 조회
select * from payment p where p.payment_date < '2005-07-09';

-- limit : 특정 조건에 해당하는 데이터 중에서 상위 n 개의 데이터 보기 / 범위 지정해서 보기 
-- customer 테이블에서 store_id 내림차순, first_name 오름차순으로 10개 데이터 보기 
select * from customer c order by c.store_id  desc, c.customer_id asc limit 10;

-- llimit N1,N2 : 상위 N1	 다음행부터 N2 개의 행 조회
-- 101번째부터 10 개 갖고와 
select * from customer c order by c.store_id  desc, c.customer_id asc limit 100,10;

-- limit ~ offset
-- 100개 건너뛰고 10개의 데이터를 가져와
select * from customer c order by c.customer_id asc limit 10 offset 100;

-- 데이터베이스 생성 
create database if not exists exam;

-- 이데이터베이스 이용할거야 
use exam;



-- 테이블생성
-- 데이터 유형 
-- 숫자형 : INT, TINYINT(1 Byte), SMALLINT(2), MEDIUMINT(3), INT(4), BIGINT(8)
-- 실수형 : 1. 고정소수점 방식
-- 		     DECIMAL / NUMERIC 
--        2. 부동소수점 방식 
-- 		     FLOAT , DOUBLE
-- 문자형 : CHAR(n) - 고정길이 문자열
-- 		  VARCHAR(n)

-- 날짜형 : TIME / DATE / DATETIME / TIMESTAR

create table table1(
	col1 int,
	col2 varchar(50),
	col3 datetime
);

create table table2(
	col1 int auto_increment primary KEY,
	col2 varchar(50),
	col3 datetime
);

insert into TABLE2(col2,col3) values('TEST','2025-10-29');
insert into TABLE2(col1,col2,col3) values(3,'TEST','2025-10-30');

select * from TABLE2;

-- 현재 auto_icrement 로 생성된 마지막 값 확인
select LAST_INSERT_ID();

-- auto_increment 시작값 변경 
alter table table2 auto_increment = 100;

-- auto_increment 증가값 변경 
-- set @@auto_increment_increment = 1;

create table exam_insert_select_from(
	col1 int,
	col2 varchar(10)
);

create table exam_insert_select_to(
	col1 int,
	col2 varchar(10)
);

insert into exam_insert_select_from(col1,col2) values(1,'Do');
insert into exam_insert_select_from(col1,col2) values(2,'It');
insert into exam_insert_select_from(col1,col2) values(3,'Mysql');

-- EXAM_INSERT_SELECT_FROM => EXAM_INSERT_SELECT_TO

insert into EXAM_INSERT_SELECT_TO select * from EXAM_INSERT_SELECT_FROM;
select * from EXAM_INSERT_SELECT_TO;

create table EXAM_SELECT_NEW as select * from EXAM_INSERT_SELECT_FROM;
select * from exam.EXAM_SELECT_NEW;

create table exam_date_table( 
	col1 DATE,COL2 TIME,COL3 DATETIME , COL4 TIMESTAMP
);

insert into EXAM.EXAM_DATE_TABLE VALUES(NOW(),NOW(),NOW(),NOW());
select * from EXAM.EXAM_DATE_TABLE EDT;

-- 사용자 생성

-- localhost : 내컴퓨터(로컬 접속만 가능)
-- '%' : 모든 IP에서 접속가능 외부 접속 허용
CREATE USER 'TEST1'@'localhost' IDENTIFIED BY '12345'; 

-- 권한부여 
-- grant 권한목록 on 데이터베이스.테이블 to '사용자이름'@'호스트'
-- grant select,insert,update on exam.table1 to 'test1'@'localhost';

grant all privileges on my exam.* to 'TEST1'@'localhost';
-- 변경사항 반영
flush privileges;

-- 사용자 삭제 
drop user 'test1'@'localhost';
