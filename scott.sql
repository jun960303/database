-- sql 구문은 대소문자를 구별하지 않는다 
-- 단 , 비밀번호는 구별함 

--조회(select)
-- select 컬럼명 -- 5 
-- from 테이블명 -- 1
-- where 조건절 -- 2
-- group by -- 3
-- having -- 4
-- order by 컬럼명 desc or desc -- 6

-- emp(사원) 테이블
-- empno(사번) : number(4,0) => 숫자, 4자리, 소수점 아래 자릿수는 0 
-- ename(이름) : varchar2 
-- job(직무) : varchar2
-- mgr(매니저) 
-- hiredate(입사일)
-- sal(급여) : nuber(7,2)
-- comm(수당)
-- deptno(부서번호)

--dept(부서) 테이블 
--deptno(부서번호)
--dname(부서명)
--loc(부서위치)	

-- 조회 기본 구문 
--SELECT 보고싶은 열이름 ... FROM 테이블명;
--SELECT 보고싶은 열이름 ... FROM 테이블명 WHERE 조건 나열;

-- 1) 전체사원 조회 시 모든 정보 추출
select * FROM EMP e;

-- 2) 전체 사원 조회 시 사원 이름만 추출 
SELECT ename FROM emp e;

-- 3) 전체 사원 조회 시 사번,사원명,부서번호만 추출
SELECT empno,ename,deptno FROM emp e; 

-- 4) 전체 사원 조회 시 부서번호만 추출  
SELECT deptno FROM emp e;

-- 5) 전체 사원 조회 시 부서번호만 추출 + 중복된 데이터 제거 후 추출
SELECT distinct deptno FROM  emp e;

-- 6) alais(별칭)
--SELECT ename "사원명" FROM emp e;
--SELECT ename 사원명 FROM emp e;
SELECT ename AS 사원명 FROM emp e;

-- 연봉구하기 (sal * 12 + comm)
SELECT empno AS 사번 , sal * 12 + comm AS 연봉 FROM emp e; 

--SQL Error [923] [42000]: ORA-00923: FROM 키워드가 필요한 위치에 없습니다.
--SELECT ename AS 사원 이름 FROM emp e;

SELECT ename AS "사원 이름" FROM emp e;

-- 오름차순 , 내림차순 정렬 : ORDER BY 정렬 기준 열 이름.....오름차순 ASC or 내림차순 DESC

-- 급여의 오름차순 정렬 
SELECT * FROM emp ORDER BY sal ASC;
-- 급여의 내림차순 정렬
SELECT * FROM emp ORDER BY sal DESC;

-- 급여의 내림차순 , 이름의 오름차순 
SELECT * FROM emp ORDER BY sal DESC,ename ASC;

-- [실습]
-- empno : employee_no,
-- ename : employee_name
-- mgr : manager 
-- sal : salary
-- comm : commission 
-- deptno : department_no 
-- 별칭 지정, 부서번호를 기준으로 내림차순 정렬, 단 부서번호가 같다면 이름 오름차순 
SELECT
	e.empno AS "employee_no",
	e.ename AS "employee_name",
	e.mgr AS "manager",
	e.sal AS salary,
	e.comm AS commision,
	e.deptno AS "department_no"
FROM
	emp e
ORDER BY
	e.deptno DESC,
	e.ename ASC;

-- =(같다)  / 문자 ' ' / and
-- 부서번호가 30번인 사원정보 조회
SELECT * FROM emp WHERE deptno =30;

-- 사번이 7688인 사원정보 조회
SELECT *FROM emp WHERE empno = 7698;

-- 부서번호가 30번이고 사원직책이 salesman 인 사언정보 조회 
SELECT * FROM emp WHERE deptno = 30 AND job='SALESMAN';

-- 부서번호가 30번이거나 사원직책이 analyst 인 사원 정보 조회
SELECT * FROM emp WHERE deptno = 30 OR job='ANALYST';

-- 연산자 
-- +,-,*,/ ,=,>,<,>=,<= ,and , or , 같지않다 => != , <> , ^=
-- in, between A and B( ~ 이상 ~ 이하)
-- like 

-- 연봉이 36000 인 사원 조회 
SELECT * FROM emp e WHERE  sal * 12 = 36000;

-- 급여가 3000 초과인 사원 조회
SELECT * FROM emp e WHERE sal > 3000;

-- 이름이 'F' 이후의 문자로 시작하는 사원 조회 
SELECT * FROM emp e WHERE e.ENAME >= 'F';

-- 직무가 manager , salesman,clerk 인 사원조회
SELECT * FROM emp e WHERE e.JOB = 'SALESMAN' OR e.JOB 'CLERK'; 

-- sal 이 3000 이 아닌 사원 조회 
SELECT * FROM emp e WHERE e.SAL != 3000;
SELECT * FROM emp e WHERE e.SAL <> 3000;
SELECT * FROM emp e WHERE e.SAL ^= 3000;

-- 직무가 manager, salesman,clerk 인 사원 조 회 + in 
SELECT * FROM emp e WHERE e.JOB IN ('SALEMAN','SALESMAN','CLERK');

-- 직무가 MANAGER , SALESMAN ,CLERK 가 아닌 사원 조회 + NOT IN
SELECT * FROM EMP E WHERE e.JOB NOT in('SALESMAN','SALESMAN','CLERK'); 

-- 부서번호가 10,20 번인 사원 조회
SELECT * FROM emp e WHERE e.DEPTNO = 10 OR e.DEPTNO = 20;
SELECT * FROM emp e WHERE e.DEPTNO  IN (10,20);

-- between a and b 
-- 급여가 2000 이상 3000이하 
SELECT
	*
FROM
	emp e WHERE e.sal >= 2000 AND e.sal <= 3000;

SELECT * FROM emp e WHERE e.sal BETWEEN 2000 AND 3000;

-- 급여가 2000 이상 3000 이하가 아닌 사원 조회
SELECT * FROM emp e WHERE e.sal NOT BETWEEN 2000 AND 3000;

-- LIKE + 와일드카드(%,_)
-- 사원명이 S로 시작하는 사원들의 정보 조회 
SELECT * FROM emp e WHERE e.ename LIKE 'S%';
-- 사원명의 두번째 글자가 L인 사원들의 정보 조회
SELECT * FROM emp e WHERE e.ENAME like '_L%'; 
-- 사원 이름의 AM 이 포함된 사원들의 정보 조회 
SELECT * FROM emp e WHERE e.ename LIKE '%AM%';
-- 사원 이름의 AM 이 포함되지 않은 사람드
SELECT * FROM emp e WHERE e.ENAME NOT LIKE '%AM%'; 

-- null 값 
-- null 값은 비교 시 = or != 사용하지 않음 
-- SELECT * FROM emp WHERE comm = null;
SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;
