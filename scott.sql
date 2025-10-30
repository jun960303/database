--SQL
-- 1.데이터 정의언어
-- 2.데이터 조작언어
-- 3.데이터 제어 언어


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
-- 사원 이름의 AM 이 포함되지 않은 사람들의 정보 조회 
SELECT * FROM emp e WHERE e.ENAME NOT LIKE '%AM%'; 

-- null 값 
-- null 값은 비교 시 = or != 사용하지 않음 
-- SELECT * FROM emp WHERE comm = null;
SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;

-- 집합연산자
-- 합집합(UNION), 교집합(INTERSECT), 차집합(NINUS)

-- DEPTNO =10 UNION DEPTNO = 20 
SELECT
	empno,ename,sal 
FROM
	emp
WHERE
	deptno = 10
UNION 
SELECT
	*
FROM
	emp
WHERE
	deptno = 20;

-- union all 
SELECT
	empno,ename,sal 
FROM
	emp
WHERE
	deptno = 10
UNION all
SELECT
	empno,ename,sal
FROM
	emp
WHERE
	deptno = 10;
-- MINUS 
SELECT
	empno,ename,sal 
FROM
	emp
MINUS
SELECT
	empno,ename,sal
FROM
	emp
WHERE
	deptno = 10;


-- 교집합
SELECT
	empno,ename,sal 
FROM
	emp
INTERSECT
SELECT
	empno,ename,sal
FROM
	emp
WHERE
	deptno = 10;

--[실습]
-- 1. 사원 이름이 S로 끝나는 사원 데이터 조회 
SELECT * FROM emp e WHERE e.ENAME LIKE '$S';
-- 2. 30 번 부서에 근무하고 있는 사원 중에 job 이 salesman인 사원의 사원번호,이름,직책,급쳐,부서번호조회 
SELECT e.EMPNO ,e.JOB ,e.SAL ,e.DEPTNO  FROM  emp e WHERE e.deptno = 30 AND e.JOB = 'SALESMAN'
-- 3. 20,번 30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원을 다음 두 방식의 select 문을 사용하여 
-- 사원번호, 이름 ,직책 , 급여,부서, 번호를 출력 
-- 집합 연산자를 사용하는 방식 
 

SELECT e.deptno,e.ename,e.job,e.sal,e.DEPTNO  FROM emp e WHERE e.deptno  = 20 AND e.sal >2000
UNION 
SELECT e.deptno,e.ename,e.job,e.sal,e.DEPTNO  FROM emp e WHERE e.deptno = 30 AND e.sal >2000;

--------------------------------------------------------------------------------------------------------

SELECT e.deptno,e.ename,e.job,e.sal,e.DEPTNO  FROM emp e WHERE e.deptno = 20 AND e.sal >2000
MINUS 
SELECT e.deptno,e.ename,e.job,e.sal,e.DEPTNO  FROM emp e WHERE e.deptno = 10;
-- 집합 연산자를 사용하지 않는 방식

SELECT e.empno,e.ename, e.job,e.sal,e.DEPTNO  FROM emp e WHERE E.deptno = 20 OR e.deptno = 30 AND e.sal > 2000;

SELECT e.empno,e.ename,e.job,e.sal,e.deptno FROM emp e WHERE e.deptno IN (20,30) AND e.sal > 2000;

-- 4. not between a and b 연산자를 사용하지 않고 급여일이 2000 이상 3000 이하 범위 이외의 값을 가진 데이터 조회 
-- 원래정답 : SELECT * FROM emp e WHERE E.sal NOT BETWEEN 2000 AND 3000
SELECT * FROM emp e WHERE e.sal <2000 OR  e.sal > 3000 ;
-- 5. 사원 이름에  E가 포함된 30 번 부서의 사원 주 급여가 1000 ~ 2000 사이가 아닌 사원명,사번,급여,부서번호, 조회 
SELECT
	e.empno,
	e.ename,
	e.sal,
	e.deptno
FROM
	emp e
WHERE
	e.ename LIKE '%E%'
	AND e.deptno = 30
	AND e.sal NOT BETWEEN 1000 AND 2000;

-- 6. 추가 수당이 업고 상급자가 있고 직책이 MANAGER, CLERK인 사원 중에서 사원이름의 두번째 글자가 L이 아닌 
-- 사원의 정보를 조회 

SELECT
	*
FROM
	emp e
WHERE
	e.comm IS NULL
	AND e.mgr IS NOT NULL
	AND e.job IN('MANAGER', 'CLERK')
	AND E.ENAME NOT LIKE '_L%';


--함수
-- 1. 문자함수 
-- UPPER(문자열) : 대문자 변환
-- LOWER(문자열) : 소문자 변환
-- INITCAP : 첫글자는 대문자, 나머지 문자는 소문자
-- LENGTH(문자열) : 문자열 길이 
-- LENGTB(문자열) : 문자열의 바이트 길이 
-- SUBSTR(문자열데이터,시작위치,추출길이) : 문자열 부분 추출 
-- INSTR(대상문자열,위치를 찾으려는 문자, 위치 찾기시작위치,찾으려는 문자가 몇번째인지) : 문자열 데이터 안에서 특정 문자 위치 찾기
-- CONCAT(문자열, 찾는문자, 바꿀문자)
-- TRIM(삭제옵셥(선택),삭제할문자(선택 FORM 원본문자열)
-- 1) 삭제옵션 : LEADING OR TRAILING OR BOTH 
-- LTRIM(원본문자열,삭제할 문자열)
-- RTRIM(원본문자열,삭제할 문자열)


SELECT ename,upper(ename),lower(ename),initcap(ename) FROM  emp e;

SELECT ename,LENGTH(ename),LENGTHB(ename) FROM  emp e;

-- DUAL : 더미테이블
-- 임시연산이나 함수의 결과값 확인 용도
-- XE21 (한글 한자당 3Byte 사용 )
SELECT LENGTH('한글'),LENGTHB('한글') FROM  DUAL;

-- 사원명 길이가 5이상인 사원조회 
SELECT * FROM emp e WHERE length(e.ename) >= 5;
-- 직책명이 6자 이상인 사원 조회 
SELECT * FROM emp e WHERE length(e.job) >= 6;

SELECT job,substr(e.job,1,2),substr(e.job,3,2),substr(e.boj,5)
FROM emp e;

-- emp 테이블에서 사원명을 세번째 글자부터 끝까지 출력
SELECT e.ename ,substr(e.ename,3) FROM emp e;

SELECT job, substr(e.job,-LENGTH(e.job)),substr(e.job,-LENGTH(e.job),2),substr(e.job,-3)FROM  emp e;


-- 
SELECT instr('HELLO, ORACLE','L') AS 첫번째,instr('HELLO, ORACLE!','L',5) AS 두번째, Instr('HELLO,ORALCE!','L',2,2) AS 세번째 FROM dual;

-- 사원명에 문자s가 포함된 사원 조회 
-- 1) LIKE  2) INSTR()
SELECT * FROM emp e WHERE INSTR(e.ename,'S') > 0;

-- 010-4526-7858 => 010 4526 7858 or 01045267858
SELECT '010-4526-7858' AS BEFORE , REPLACE('010-4526-7858','-',' ') AS replace1, REPLACE('010-4526-7858','-') AS reokace2 
FROM dual;

-- concat() or || 
-- empno , ename 합치기 
SELECT concat(e.empno,e.ename),concat(e.empno,concat(':',e.ename)) FROM emp e;

-- TRIM()
SELECT
	'[' || TRIM ('__Oracle__')|| ']' AS trim,
	'[' || TRIM (LEADING from'__Oracle__')|| ']' AS TRIM_LEADING,
	'[' || TRIM (TRAILING FROM'__Oracle__')|| ']' AS TRIM_TRAILING,
	'[' || TRIM (BOTH FROM'__Oracle__')|| ']' AS TRIM_BOTH
FROM DUAL;	

SELECT
	'[' || TRIM ('__Oracle__')|| ']' AS trim,
	'[' || LTRIM ('__Oracle__')|| ']' AS LTRIM,
	'[' || LTRIM ('<_Oracle_>','_<')|| ']' AS LTRIM2,
	'[' || RTRIM ('_Oracle_')|| ']' AS RTRIM,
	'[' || RTRIM ('<__Oracle__>','>_')|| ']' AS RTRIM2
FROM 
 DUAL ;

-- 숫자함수
-- ROUND(숫자,반올림 위치) : 반올림
-- TRUNC(숫자,버릴위치) : 버릴 
-- CEIL(숫자,반올림위치) : 지정된 숫자보다 큰 정수 중 가장 작은 정수 반환 
-- flor (TNTWK) : 지정된 숫자보다 작은 정수 중 가장 큰 정수 반환 
-- mod(숫자,나눌숫자) : 지정된 숫자를 나눈 나머지 반환 

SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND0,
	ROUND(1234.5678, 1) AS ROUND1,
	ROUND(1234.5678, 2) AS ROUND2,
	ROUND(1234.5678, 3) AS ROUND3,
	ROUND(1234.5678,-1) AS ROUND4_MINUS1,
	ROUND(1234.5678,-2) AS ROUND5_MINUS2
FROM DUAL;

SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC0,
	TRUNC(1234.5678, 1) AS TRUNC1,
	TRUNC(1234.5678, 2) AS TRUNC2,
	TRUNC(1234.5678, 3) AS TRUNC3,
	TRUNC(1234.5678,-1) AS TRUNC4_MINUS1,
	TRUNC(1234.5678,-2) AS TRUNC5_MINUS2
FROM DUAL;

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14),FLOOR(-3.14)
FROM DUAL;

SELECT MOD(15,6) , MOD(10,2),MOD(11,2)
FROM DUAL;

-- 날짜 함수
-- 날짜 데이터 + 숫자 : 이후 날짜 반환
-- 날짜 데이터 - 숫자 : 이전 날짜 전환 
-- 날짜 데이터 - 날짜 데이터  : 두 날짜 데이터 간의 일수 차이 반호나 
-- 날짜 데이터 + 날짜 데이터 : 연산불가 
-- ADD_MONTHS(날짜데이터 , 더할개월 수 )
-- MONTHS_BETWEEN(날짜데이터1 , 날짜데이터2)
-- next_day(날짜데이터1, 요일문자)
-- LAST_DAY(날짜데이터)

-- 오라클에서 시스템 날짜 출력 ; SYSDATE(주로사용)
-- CURRENT_DATE

SELECT sysdate,sysdate + 1,sysdate - 1 FROM dual;

SELECT sysdate, ADD_MONTHS(sysdate, 3) FROM dual;


-- 입사 50주년이 되는 날짜 구하기 
SELECT e.HIREDATE , ADD_MONTHS(e.HIREDATE , 600) FROM emp e;

-- 입사한지 40년이 넘은 사원 조희
SELECT e.HIREDATE AS "입사한날짜" FROM emp e WHERE ADD_MONTHS(e.HIREDATE , 480) < sysdate ;

-- 
SELECT
	empno,
	HIREDATE ,
	sysdate,
	MONTHS_BETWEEN(HIREDATE,SYSDATE) AS month1,
	MONTHS_BETWEEN(SYSDATE,HIREDATE) AS month2,
	TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS month3
FROM emp e;

SELECT SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE,'월요일')
FROM DUAL;

-- 형변환 함수 
-- TO_CHAR() : 날짜,숫자 데이털르 문자로 변환 
-- TO_NUMBER() : 문자를 숫자로 변환 
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

SELECT sysdate,to_char(sysdate,'yyy/mm/dd') FROM dual;

SELECT
	sysdate,
	to_char(sysdate, 'MM'),
	to_char(sysdate, 'MON'),
	to_char(sysdate, 'MONTH'),
	to_char(sysdate, 'DD'),
	to_char(sysdate,'DAY')
FROM
	dual;
		
SELECT
	sysdate,
	to_char(sysdate, 'HH24:MI:SS'),
	to_char(sysdate, 'HH12:MI:SS AM'),
	to_char(sysdate, 'HH:MI:SS P.M.')
FROM
	dual;

SELECT
	e.empno,
	e.ename,
	e.empno + '500'
FROM
	emp e
WHERE
	e.ENAME = 'SMITH';

-- SELECT e.empno,e.ename,e.empno + 'ABCD' FROM emp e WHERE e.ENAME = 'SMITH';

SELECT
	e.SAL,
	TO_CHAR(e.SAL, '$999,999'),
	TO_CHAR(e.SAL, 'L999,999')
FROM
	EMP e ;

SELECT 1300 - '1500','1300' + 1500 FROM dual;

SELECT '1300' - '1500','1300' + 1500 FROM dual;

-- 수치가 부적합빈다. 
SELECT '1,300' - '1500','1300' + 1500 FROM dual;

SELECT TO_number('1,300','999,999') - TO_number('1500'),'1300' + 1500 
FROM dual;

SELECT
	to_date('20251027', 'yyyy-mm-dd'),
	to_date('20251027', 'yyyy/mm/dd')
	FROM dual;

SELECT to_date('2025-10-27') - to_date('2025-09-23') FROM dual;

-- null처리 함수
-- 1. NVL(널에 해당하는 열,반환할 데이터) : 널인 경우만 반환할 데이터로 돌아옴
-- 2. NVL2 (널에 해당하는 열,널이 아닐때 반환할 데이터, 반환할데이터)
-- NULL + NULL

SELECT EMPNO,ENAME,SAL,COMM,COMM + SAL FROM EMP;
SELECT EMPNO,ENAME,SAL,COMM,NVL(COMM,0) + SAL FROM EMP;
SELECT EMPNO,ENAME,SAL,COMM,NVL2(COMM,'0','X'),NVL2(COMM,SAL*12+COMM,SAL*12) + SAL FROM EMP;

-- 상황에 따라 다른 데이터를 반환하는 함수
-- 직책이 MANAGER 인 사원은 급여의 10%, SALESMAN인 사원은 급여의 5%, ANALYST인 사원은 그대로,나머지는 3%인 만큼 인상된 급여 구하기 
-- DECODE(검사 대상이 될 열 또는 데이터 , 
-- [조건1], [조건1과 일치할 때 반환할 결과]
-- [조건2], [조건2와 일치할 때 반환할 결과]
-- .... 
-- [위에 나열한 조건과 일치하지 않는 경우 반환할 결과]
--)

-- CASE 검사 대상이 될 열 또는 데이터
-- 		동등(=) 외에 다양한 조건 사용가능
-- WHEN [조건1] THEN [조건1과 일치할 때 반화할 결과]
-- WHEN [조건2] THEN [조건2와 일치할 때 반화할 결과]
-- WHEN [조건3] THEN [조건3과 일치할 때 반화할 결과]
-- ELSE [위에 나열한 조건과 일치하지 앟는 경우 반환할 결과]
-- END


SELECT
	e.empno,
	e.ename ,
	e.job,
	e.sal,
	DECODE(e.job, 'MANAGER', e.sal * 1.1, 'SALESMAN', E.SAL * 1.05, 'ANALYST', E.SAL, E.SAL * 1.03) AS 급여
FROM
	emp e;


SELECT
	e.empno,
	e.ename,
	e.job,
	e.sal,
	CASE
		e.job WHEN 'MANAGER' THEN E.SAL * 1.1
		WHEN 'SALESMAN' THEN E.SAL * 1.05
		WHEN 'ANALYST' THEN E.SAL
		ELSE E.SAL * 1.03
	END AS 급여
FROM
  emp e;

-- comm 이 null 인 경우에는 해당없늠 , 0 인 경우에는 수당없음 , 0 보다 큰 경우에는 수당 : 800 
SELECT
 e.empno,e.ename,e.comm,
 CASE 
 	WHEN e.comm IS NULL THEN '해당없음'
 	WHEN 
 END
 
FROM EMP e;

-- EMP 테이블에서 사원의 월 평균 근무일수는 21.5일이다.
-- 하루근무시간을 8 시간으로 보았을 때 사원의 하루급여(DAY_PAY), 시급(TIME_PAY)를 계산하여 결과를 출력
-- 하루 급여는 소수 셋째 자리에서 버리고,시급은 소수 둘쨰 자리에서 반올림



-- EMP 테이블에서 사원은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 사원이 정직우너이 되는 날짜(R_JOB)을
-- yyyy-mm-dd 형식으로 출력. 단 , 추가수당이 없는 사원의 추가 수당은 N/A로 출력
-- EMPNO,ENAME,HIREDATE, R_JOB,COMM출력

SELECT
	E.EMPNO ,
	E.ENAME ,
	E.HIREDATE ,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(E.HIREDATE , 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	CASE
		WHEN E.COMM IS NULL THEN 'N/A'
		WHEN E.COMM IS NOT NULL THEN TO_CHAR(E.COMM)
	END AS COMM
FROM
	EMP E;

-- EMP테이블으,ㅣ 모든 사원을 대상으로 직속 상관의 사원번호(mgr)을 아래의 조건을 기준으로 변환해서 chg_mgr 열에 출력 
-- 조건 
-- 직속 상관의 번호가 없는경우 0000 
-- 직속 상관의 사원번호 앞 두자리가 75 일대 5555
-- 직속 상관의 사원번호 앞 두자리가 76 일대 6666
-- 직속 상관의 사원번호 앞 두자리가 77 일대 7777
-- 직속 상관의 사원번호 앞 두자리가 78 일대 8888
-- 그 외 직송상관 사원 번호일 때 : 본래 직속상관의 사원번호 그대로 출력

SELECT
	e.empno,
	e.ename,
	e.HIREDATE ,
	CASE
		substr(TO_char(nvl(e.mgr,0)), 1, 2) 
		WHEN '0' THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE to_char(e.mgr)
	END AS CHG_MGR
		FROM
		emp e;

SELECT
	e.empno,
	e.ename,
	e.HIREDATE ,
	E.MGR,
	decode(substr(TO_char(e.mgr), 1, 2),
	NULL , '0000',
	'75', '5555',
	'76', '6666',
	'77', '7777',
	'78', '8888',
	substr(TO_char(e.mgr), 1))
AS CHG_MGR
FROM
		emp e;

-- 다중행 함수
-- SUM(), AVG(), COUNT() , MAX(), MIN()

SELECT SUM(e.sal), avg(e.sal),max(e.sal),min(e.sal),count(e.sal)
FROM emp e; 

-- 단일 그룹의 그룹 함수가 아닙니다. 
--SELECT sum(e.sal),e.email FROM emp e;
-- 20번 부서의 제일 오래된 입사일 구하기 
SELECT 
MIN(e.HIREDATE )
FROM emp e WHERE e.DEPTNO = 20;

--10번의 부서의 급여총계, 평균구하기 
SELECT 
	SUM(e.SAL),
	AVG(e.SAL)
FROM
	emp e
	WHEre e.DEPTNO = 10;

-- 20번 부서의 제일 최신 이삽일 구하기 
SELECT 
MAX(e.HIREDATE )
FROM emp e WHERE e.DEPTNO = 20;

-- group by 
-- 부서별 급여평균 조회
-- 다중행 함수 옆에 올 수 있는 컬럼은 GROUP BY 쓴것만 가능
SELECT AVG(e.sal)FROM emp e GROUP BY e.deptno;

-- 부서별 , 직무별 급여 평균 
SELECT e.DEPTNO , AVG(E.SAL)FROM emp e GROUP BY e.deptno,e.job ORDER BY E.DEPTNO,E.JOB ;


-- 부서별 , 추가수당 평균 조회 
SELECT e.DEPTNO ,AVG(nvl(E.COMM,0)) FROM emp e GROUP BY e.DEPTNO ;

-- GROUP BY 열이름 HAVING 출력그룹제한
-- 부서별, 직무별 급여 평균 조회(단, 평균이 2000이상 그룹 조회 )
--SELECT
--	e.DEPTNO ,
--	e.job,
--	avg(e.sal)
--FROM
--	emp e
--WHERE
--	avg(e.sal) >= 2000 그룹 함수는 허가되지 않습니다
--GROUP BY
--	e.deptno,
--	e.job
--ORDER BY
--	e.deptno,
--	e.job;

SELECT
	e.DEPTNO ,
	e.job,
	avg(e.sal)
	FROM emp e
GROUP BY
	e.deptno,
	e.job
HAVING
	avg(e.sal) >= 2000
ORDER BY
	e.deptno,
	e.job;

-- emp 테이블을 이용하여 부서번호 , 평균급여(avg_sal) , 최고급여(max_sal), 최저급여(min_sal) , 사원수(cnt) 조회
-- 단, 평균급여 출력 시 소수점을 제외하고 각 부서번호별로 출력
SELECT
	e.deptno,
	floor(avg(e.sal)) AS avg_sal,
	max(e.sal) AS max_sal,
	min(e.sal) AS min_sal ,
	count(*) AS cnt
FROM
	emp e
GROUP BY
	e.deptno
ORDER BY
	e.DEPTNO ;


-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력 

-- 사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력 
-- 1981-09-28 
SELECT
	e.deptno,
	to_char(e.hiredate, 'yyyy'),
	count(*) AS cnt
FROM
	EMP e
GROUP BY
	tO_char(e.hiredate, 'yyyy'),
	e.deptno;

-- 조회 : join / subquery
-- join : 여러 테이블을 하나의 테이블처럼 사용
-- 1. 내부조인(INNER JOIN)
-- 2. 외부조인(OUTER JOIN)
-- (1) RIGHT OUTER JOIN 
-- (2) LEFT OUTER JOIN 
-- (3) FULL OUTER JOIN : left join union right join < 사용구문

-- 사원정보 + 부서정보 조회 
SELECT
	e.empno,
	e.ename,
	e.job,
	e.DEPTNO ,
	d.dname
FROM
	emp e
INNER JOIN dept d ON
	e.deptno = d.deptno;

-- 열의 정의가 애매합니다(DEPTNO)
SELECT
	e.empno,
	e.ename,
	e.job,
	E.DEPTNO ,
	d.dname
FROM
	emp e
   dept d 
WHERE 
	e.deptno = d.deptno AND e.sal >= 2000;

-- 비등가 조인 + 내부조인 
SELECT
	*
FROM
	emp e
JOIN SALGRADE S ON
	e.sal BETWEEN s.losal AND s.HISAL;

-- 셀프조인
SELECT
	e1.empno,
	e1.ename,
	e1.mgr,
	e2.ename AS 매니저명
FROM
	emp e1
JOIN emp e2 ON
	e1.MGR = E2.EMPNO;


-- 외부조인 
SELECT e1.empno,e1.ename,e1.mgr,e2.ename AS 매니저명 FROM emp e1 LEFT JOIN emp e2 ON e1.mgr = e2.empno;

SELECT
	e.deptno,
	floor(avg(e.sal)) AS avg_sal,
	max(e.sal) AS max_sal,
	min(e.sal) AS min_sal ,
	count(*) AS cnt
FROM
	emp e
GROUP BY
	e.deptno
ORDER BY
	e.DEPTNO ;

-- 부서명 조회
--GROUP BY 표현식이 아닙니다.
SELECT
	e.deptno, d.dname,
	floor(avg(e.sal)) AS avg_sal,
	max(e.sal) AS max_sal,
	min(e.sal) AS min_sal ,
	count(*) AS cnt
FROM
	emp e
	JOIN dept d ON e.deptno = d.deptno
GROUP BY
	e.deptno,d.dname
ORDER BY
	e.DEPTNO ;

-- table 3개 연동
-- 부서번호,부서명 ,사번,사원명,매니저번호,급여,급여등급 
-- 부서명 : dept 
-- 사번,사원명,매니저번호,급여,부서번호 : emp 
-- 급여등급 : salgrade 

SELECT
	e.deptno,
	d.dname,
	e.empno,
	e.ename,
	e.mgr,
	e.sal,
	s.GRADE
FROM
	emp e
JOIN dept d ON
	e.deptno = d.deptno
JOIN SALGRADE s ON
	e.sal BETWEEN s.LOSAL AND s.HISAL;

-- 서브쿼리 : 메인쿼리 외에 select 구문이 여러개 존재
			-- 괄호안에 작성 
-- 1) 단일행 서브쿼리 : 
--     ㄴ 연산자 종류 : >, <, >= , <=, <> , != , ^=
-- 2) 다중행 서브커리 : 서브쿼리 실행 결과가 여러 행 
--     ㄴ 연산자 종류 : IN, ANY(=SONE), ALL, EXIST
--     in : 서브쿼리 결과 중 하나라도 일치한 데이터가 있다면 true 반환 
--     any , some : 서브쿼리 결과가 하나 이상이면 true 반환
--     all : 서브쿼리 결과가 모두 만족하면 true 반환 
--    exists : 서브쿼리 결과가 하나라도 존재하면 true 반환

--SELECT e.ename, (SELECT * FROM emp e2)
--FROM emp e JOIN (SELECT * FROM emp e2)
--WHERE e.DEPTNO =(SELECT )

-- jones의 급여보다 높은 급여를 받는 사원 데이터 조회
SELECT
	*
FROM
	emp e
WHERE
	e.sal > (
	SELECT
		*
	FROM
		emp e2
	WHERE
		e2.ENAME = 'JONES');

-- 
SELECT
	*
FROM
	emp e
WHERE
	e.sal > (
	SELECT
		*
	FROM
		emp e2
	WHERE
		e2.job  = 'MANAGER');

-- WARD 사원보다 빨리 입사한 사원들 조회
SELECT
	*
FROM
	emp e
WHERE
	e.sal > (
	SELECT
		E2.ENAME 
	FROM
		emp e2
	WHERE
		e2.ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원 조회
-- 부서정보 추가로 조회

SELECT
	e.EMPNO ,
	e.ename,
	e.job ,
	d.deptno ,
	d.dname ,
	d.LOC
FROM
	EmP E
JOIN DEPT D ON
	e.deptno = d.DEPTNO
	WHERE e.DEPTNO = 20 AND e.sal > (SELECT avg(e2.sal) FROM emp e2);


SELECT * FROM emp e WHERE e.sal IN (SELECT max(E2.sal) FROM emp e2 GROUP BY e2.DEPTNO );
-- = any(some) => in 사용 
SELECT * FROM emp e WHERE e.sal = any (SELECT max(E2.sal) FROM emp e2 GROUP BY e2.DEPTNO );
SELECT * FROM emp e WHERE e.sal = some (SELECT max(E2.sal) FROM emp e2 GROUP BY e2.DEPTNO );

-- 30번 부서의 급여보다 작은 급여를 받는 사원 조회
-- < any
SELECT * FROM emp e WHERE e.sal < any(SELECT sal FROM emp e2 WHERE e2.DEPTNO = 30);


-- 30번 부서의 최소 급여보다 많은 급여를 받는 사원 조회 
SELECT * FROM emp e WHERE e.sal > ANY (SELECT sal FROM emp e2 WHERE e2.DEPTNO = 30);


-- 30 번 부서의 최소 급여보다 더 적은 급여를 받는 사원 조회
SELECT * FROM emp e WHERE e.sal < all (SELECT sal FROM emp e2 WHERE e2.DEPTNO = 30);

-- 30 번 부서의 최대 급여보다 더 적은 급여를 받는 사원 조회
SELECT * FROM emp e WHERE e.sal > all (SELECT sal FROM emp e2 WHERE e2.DEPTNO = 30);

-- 서브쿼리 결과가 하나이상 나오면 true 반환
SELECT * FROM emp e WHERE EXISTS (SELECT dname FROM dept d WHERE d.DEPTNO = 70);

-- 다중열 서브쿼리 
SELECT * FROM emp e WHERE (e.DEPTNO ,e.sal) in (SELECT e2.deptno,max(e2.sal)FROM emp e2 GROUP BY e2.DEPTNO );  

-- from 절 서브쿼리(=인라인 뷰)
SELECT e10.*,d.*
FROM (SELECT * FROM emp e WHERE e.deptno = 10) e10, (SELECT * FROM dept)d 
WHERE e10.deptno = d.DEPTNO;

-- select 절 서브쿼리 (= 스칼라 서브쿼리)
SELECT
	e.ename,
	e.ename,
	e.job,
	(
	SELECT
	s.GRADE 
	FROM
		SALGRADE s
	WHERE
		e.sal BETWEEN s.LOSAL AND s.HISAL ) AS salgrade,
	e.deptno,
	( SELECT d.dname FROM dept d WHERE e.deptno = d.DEPTNO ) AS dname
FROM
	emp e;

-- 전체 사원 중 ALLEN 과 같은 직책인 사원들의 사원정보, 부서정보 조회 
-- 사원정보 : 사번, 이름 , 직무, 직책 ,급여 , 부서번호, 부서명 
SELECT e.empno, e.ename, e.job, e.sal, d.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.DEPTNO 
WHERE e.job = (SELECT E2.JOB  FROM emp e2 WHERE e2.ename = 'ALLEN');
-- 자신의 부서 내에서 최고 연봉과 동일한 급여를 받는 사원 조회
SELECT * FROM emp e WHERE (e.DEPTNO ,e.sal) in (SELECT e2.deptno,max(e2.sal)FROM emp e2 GROUP BY e2.DEPTNO );

-- 10번 부서에 근무하는 사원 중 30번 부서에 없는 직책인 사원의 사번,일므,직무,부서번호,부서명,부서위치 조회
SELECT e.empno, e.ENAME , e.JOB , d.deptno , d.DNAME , d.loc
FROM emp e JOIN dept d ON e.deptno = d.DEPTNO 
WHERE e.DEPTNO = 10 AND e.JOB  NOT IN (SELECT e2.JOB FROM emp e2 WHERE e2.deptno = 30);

-- insert : 테이블에 데이터 추가 
--INSERT INTO 테이블명(열이름1,열이름2) VALUES(값1,값2....)

-- 연습용 테이블 생성 
CREATE TABLE dept_temp AS SELECT * FROM dept;
CREATE TABLE emp_temp AS SELECT * FROM emp WHERE 1<>1; -- 구조만 복사


SELECT * FROM dept_temp;

-- 50, DATABASE, SEOUL 삽입 
INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC) VALUES (50,'DATABASE','SEOUL');

INSERT INTO DEPT_TEMP VALUES (60, 'NETWORK','BUSAN');

-- 값의 수가 충분하지 않습니다. 
-- INSERT INTO DEPT_TEMP VALUES (60, 'NETWORK');

-- 값으로 NULL 명시적으로 삽입이 가능 
INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC) VALUES (70,'WEB',NULL);
INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC) VALUES (70,'WEB','');
-- NULL 암시적 처리
INSERT INTO DEPT_TEMP(DEPTNO,DNAME) VALUES (90,'OS');

SELECT * FROM emp_temp;
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, SAL,comm, deptno) 
VALUES(1111,'성춘향','MANAGER',9999,'2010-10-25',4000,NULL,20); 

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, SAL,comm, deptno) 
VALUES(9999,'홍길동','PRESIDENT',NULL,'2000-01-25',8000,1000,10); 

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, SAL,comm, deptno) 
VALUES(2222,'김수호','MANAGER',NULL,SYSDATE,4000,NULL,30); 

-- EMP 테이블에서 SALGRADE 가 1인 사원만 emp_temp 삽입
INSERT
	INTO
	emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT
	e.empno ,
	e.ename ,
	e.job ,
	e.mgr ,
	e.HIREDATE ,
	e.sal ,
	e.COMM ,
	e.DEPTNO
FROM
	emp e
JOIN salgrade s ON
	e.sal BETWEEN s.LOSAL AND s.HISAL
	AND s.GRADE = 1; 

-- update
-- UPDATE 테이블명 
-- SET 열이름 = 수정할값 , 열이름2 = 수정할값 
-- WHERE 수정할조건
SELECT * FROM dept_temp dt ;

-- 10번 부서의 위치 SEOUL 변경 
UPDATE DEPT_TEMP dt 
SET dt.loc = 'SEOUL'
WHERE DT.DEPTNO = 10; 

-- emp_temp 테이블의 사원 중에서 sal 이 2500 이하인 사원만 추가수당을 50으로 수정
UPDATE emp_temp et
SET et.comm = 50
WHERE et.sal <= 2500;

SELECT * FROM emp_temp;

-- dept 테이블의 40 번 부서의 dname, loc 정보를 가져와서 dept_temp 40번 부서의 내용으로 변경

UPDATE dept_temp dt
SET (dt.dname ,dt.loc) = (SELECT d.dname , d.loc FROM dept d WHERE d.deptno = 40)
WHERE dt.deptno = 40; 

SELECT * FROM dept_temp;

UPDATE dept_temp dt 
SET loc = 'BUSAN';

-- DELETE : 데이터 삭제
-- delete from 테이블명 where 삭제할조건
-- DELETE 테이블명 where 삭제할 조건

CREATE TABLE emp_temp2 AS SELECT * FROM emp;

SELECT * FROM emp_temp2 et;

-- 7902 사원 삭제 
DELETE FROM emp_temp2 WHERE empno = 7902;

DELETE emp_temp2 WHERE empno = 7844;
SELECT * FROM emp_temp2;

-- 데이터 전체 삭제
DELETE FROM emp_temp2;

-- EMP 테이블을 복사하여 exam_emp 테이블 생성 
CREATE TABLE exam_emp AS SELECT * FROM emp;
SELECT * FROM exam_emp;
-- DEPT 테이블을 복사하여 exam_DEPT 테이블 생성 
CREATE TABLE exam_dept AS SELECT * FROM dept;
SELECT * FROM dept ;
-- SALGRADE 테이블을 복사하여 exam_SALGRADE 테이블 생성 
CREATE TABLE exam_salgrade AS SELECT * FROM salgrade;
SELECT * FROM exam_salgrade;

-- EXAM_DEPT 테이블에 50,60,70,80번 부서를 등록하는 sql 구문 작성
-- 50, ORACLE, BUSAN
-- 60, SQL ILSAN
-- 70, SELECT, INCHEON 
-- 80, DML, BUNDANG
INSERT INTO exam_dept(deptno,dname,loc) VALUES (50,'ORALCE','BUSAN');
INSERT INTO exam_dept(deptno,dname,loc) VALUES (60,'SQL','ILSAN');
INSERT INTO exam_dept(deptno,dname,loc) VALUES (70,'SELECT','INCHEON'); 
INSERT INTO exam_dept(deptno,dname,loc) VALUES (80,'DML','BUNDANG');
SELECT * FROM exam_dept;
-- EXAM_EMP 테이블에 8명의 사원정보를 등록하는 SQL구문 작성 
-- 8명은 임의 값 (부서번호는 50 ~ 80번 사이로 지정) 

SELECT * FROM exam_emp;

INSERT INTO exam_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES (8000,'김하나','SALESMAN',5000,SYSDATE,3000,NULL,50);
INSERT INTO exam_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES (5400,'김둘','CLERK',5000,SYSDATE,3000,NULL,50);
INSERT INTO exam_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES (6600,'김셋','CLERK',4000,SYSDATE,5000,NULL,60);
INSERT INTO exam_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES (7300,'김넷','CLERK',4000,SYSDATE,5000,NULL,60);
INSERT INTO exam_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES (8500,'김다섯','SALESMAN',2000,SYSDATE,8000,NULL,50);
INSERT INTO exam_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES (9000,'김여섯','SALESMAN',2000,SYSDATE,8000,NULL,50);
INSERT INTO exam_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES (7000,'김일곱','CLERK',7000,SYSDATE,2000,NULL,80);
INSERT INTO exam_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES (6000,'김여덟','SALESMAN',7000,SYSDATE,2000,NULL,80);
-- EXAM_EMP 에서 50번 부서에 근무하는 사원의 평균 급여보다 많이 받는 사원을 70 번 부서로 옮기는 SQL 구문 작성
UPDATE exam_emp ep
SET ep.deptno = 70
WHERE ep.sal > (SELECT avg(ep.sal)FROM exam_emp WHERE ep.deptno = 50);

-- EXAM_EMP 에 속한 사원 중 입사일이 가장 빠른 60번 부서 사원보다 늦게 입사한 사원의 급여를 10% 인상하고 
-- 80번 부서로 옮기는 SQL 구문 작성 

UPDATE exam_emp ep
SET ep.sal = ep.sal * 1.1, ep.deptno = 80
WHERE ep.hiredate > (SELECT MIN(ep2.hiredate) FROM exam_emp ep2 WHERE ep2.deptno = 60);

-- EXAM_EMP 에 속한 사원 중 급여 등급이 5인 사원을 삭제하는 SQL 구문 작성
-- 조인 시 EXAM_SALGRADE 테이블 사용

DELETE
FROM
	exam_emp
WHERE
	empno IN (
	SELECT
		ep.empno
	FROM
		exam_emp ep
	JOIN exam_salgrade es ON
		ep.sal BETWEEN es.losal AND es.hisal
		AND es.grade = 5);

-- DML : insert , update , delete => 데이터 변경이 일어나는 작업 
-- 트랜잭션 : 하나의 단위로 데이터 처리
-- ROLLBACK : 되돌리기 
-- COMMIT : 데이터베이스 반영

CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
SELECT * FROM DEPT_TCL;

-- 
INSERT INTO DEPT_TCL VALUES(50,'DATABASE','SEOUL');

UPDATE DEPT_TCL DT SET LOC = 'BUSAN' WHERE DEPTNO = 40; 

DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
-- 트랜잭션 종료

SELECT * FROM DEPT_TCL;

ROLLBACK;

COMMIT;

--xm
SELECT * FROM dept_tcl;

DELETE FROM dept_tcl WHERE deptno =50;

UPDATE dept_tcl dt SET loc = 'SEOUL' WHERE DEPTNO = 30;

SELECT * FROM DEPT_TCL;

COMMIT;

 -- 데이터 정의어(DDL)
 -- 객체를 생성(CREATE) , 변경(ALTER), 삭제(DROP) 하는 명령어

-- 1) 테이블 생성 

--CREATE TABLE dept_tcl AS SELECT * FROM dept ;
--CREATE TABLE dept_tcl AS SELECT * FROM dept WHERE 1<>1;
--
--CREATE TABLE 테이블명(
--열이름1 타입(20),
--열이름2 타입(20),
--)

--타입
--문자 : CHAR / NCHAR / VARCHAR2 / NVARCHAR2
--		char(10) : abc => 10자리를 그대로 사용 
--		varchar2(10) : abc => 3 자리를 사용 
--		varchar2(10) : 안녕하세요 입력불가 
--		nvarchar2(10) : 안녕하세요 입력가능 
		
--숫자 : number(7,2) : 소수 둘쨰 자리를 포함해서 총 7자리 숫자 지정가능 
--날짜 : date  
-- 테이블명 : 문자로 



-- 2. 자료형을 정의하여 새 테이블 생성 
CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2)
);

SELECT * FROM EMP_DDL;
-- 테이블 변경 : ALTER 
-- 1. 열 추가 : ADD 
-- 2. 열 이름 변경 : RENAME 
-- 3. 열 자료형 변경 : MODIFY 
-- 4. 열 삭제 : DROP COLUMN

ALTER TABLE emp_ddl ADD hp varchar2(20);

-- HP => TEL 이름변경 
ALTER TABLE EMP_DDL RENAME COLUMN HP TO TEL;


-- EMPNO(4) => 5 변경 
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

-- TEL 컬럼 제거 
ALTER TABLE emp_ddl DROP COLUMN TEL;

SELECT * FROM emp_ddl ed;

-- 테이블 이름 변경 
RENAME EMP_DDL TO EMP_RENAME;

-- 테이블삭제 
-- DROP

DROP TABLE EMP_RENAME;

-- MEMBER 테이블 생성 
CREATE TABLE MEMBER (
ID VARCHAR2(15),
PASSWORD VARCHAR2(20),
NAME VARCHAR2(10),
TEL VARCHAR2(15),
EMAIL VARCHAR2(20),
AGE NUMBER(4)
);
SELECT * FROM MEMBER;

-- BIGO 열 추가 (가변형 문자열 10)
ALTER TABLE MEMBER ADD BIGO varchar2(10);

-- BIGO 열 크리 변경 30 
ALTER TABLE MEMBER MODIFY BIGO VARCHAR2(30);

-- BIGO 열 이름을 REMARK로 변경
ALTER TABLE MEMBER RENAME COLUMN bigo TO REMARK;

-- 인덱스 : 테이블 검색 성능 향상 
-- 인덱스 사용 여부 
-- 1) 테이블 풀 스캔 : 처음부터 끝까지 검색 
-- 2) 인덱스 스캔 : 인덱스 사용한 검색 
SELECT * FROM emp WHERE empno = 7844;

-- 인덱스 생성
--CREATE INDEX 인덱스명 ON 테이블명 (컬럼명)
CREATE INDEX idx_emp_sal ON emp(sal);

-- 인덱스 삭제 
-- DROP index 인덱스명 : 
DROP INDEX IDX_EMP_SAL;

-- 뷰 : 가상테이블 
--    하나 이상의 테이블을 조회하는 select 문을 저장한 객체

-- create view 뷰이름(열이름1, 열이름2....) as (저장할 select문 ) WITH CHECK option 제약조건 WITH READ ONLY 제약조건
CREATE VIEW VW_EMP20 AS (SELECT EMPNO,ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO = 20);
CREATE VIEW VW_EMP_READ AS SELECT EMPNO,ENAME,JOB,DEPTNO FROM EMP WITH READ ONLY;

-- DROP VIEW 뷰이름; 
INSERT INTO VW_EMP20 VALUES(7777,'홍길동','SALESMAN',10);
SELECT * FROM VW_EMP20 VE ;
SELECT * FROM EMP;

-- USER : 현재 데이터베이스에 접속한 사용자가 소유한 객체 정보 
SELECT * FROM USER_TABLES;

SELECT * FROM USER_UPDATABLE_COLUMNS WHERE TABLE_NAME ='VM_EMP20';

--SQL Error [42399] [99999]: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
INSERT INTO  VW_EMP_READ VALUES(7777,'홍길동','SALESMAN',10);

DROP VIEW VW_EMP20;
DROP VIEW VW_EMP_READ;

-- 시퀀스 MySQL limit 
-- 오라클데이터베이스에서 특정 규칙에 따른 연속 숫자를 생성하는 객체

-- create sequence 시퀀스명 ;

-- create sequence 시퀀스명 
-- INCREMENT BY N 
-- START WITH N 
-- MAXVALUE N || NOMAXVALUE
-- MINVALUE N || NOMINVALUE
-- CYCLE | NOCYCLE
-- CHCHE N : NOCACHE

CREATE SEQUENCE SEQ_DEPT_SEQUENCE;

CREATE SEQUENCE seq_dept_sequence
INCREMENT BY 10
START WITH 10 
MAXVALUE 90 
MINVALUE 0 
NOCYCLE 
CACHE 2;

DROP SEQUENCE seq_dept_sequence;

ALTER SEQUENCE SEQ_DEPT_SEQUENCE 
INCREMENT BY 3 
MAXVALUE 99 
CYCLE;

CREATE TABLE DEPT_SEQUENCE AS SELECT * FROM DEPT WHERE 1<>1 ;

INSERT INTO DEPT_SEQUENCE VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL,'DATABASE','SEOUL');
INSERT INTO DEPT_SEQUENCE VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL,'NETWORK','BUSAN');


SELECT * FROM DEPT_SEQUENCE;
DELETE FROM dept_sequence;

-- seq_dept_sequence.currval : 현재 시퀀스 값 조회

SELECT seq_dept_sequence.currval FROM dual;

-- 동의어 : synonym (별칭)
-- 테이블 , 뷰, 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름 부여 

 CREATE synonym e FOR emp ;

 -- 제약조건( 데이터 무결성 유지)
 -- 1. 빈 값을 허용하지 앟는 NDT NULL
 -- 2. 중복값을 허용하지 않는 UNIQUE
 -- 3. 유일하게 하나만 존재하는 PRIMARY KEY
 -- 4. 다른 테이블과 관계를 맺는 FOREIGN KEY 
 -- 5. 설정한 조건식을 만족하는 데이터 확인 CHECK 
 -- 6. 기본값을 지정하는 DEFAULT
 
 -- 데이터 무결성 : 데이터 정확성과 일관성 보장 
 
 -- NOT NULL 
 -- 1. 테이블 생성 시 
 CREATE TABLE TABLE_NOTNULL( 
 	LOGIN_ID VARCHAR2(20) NOT NULL,
 	LOGIN_PWD VARCHAR2(20) NOT NULL,
 	TEL VARCHAR2(20)
 );
 
 -- DML작업
 -- INSERT 
 INSERT INTO TABLE_NOTNULL VALUES('TEST01','TEST01','010-1234-5678');
 
 -- NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
  INSERT INTO TABLE_NOTNULL VALUES('TEST01',NULL,'010-1234-5678');
 
 -- NULL로 ("SCOTT"."TABLE_NOTNULL"."LOGIN_ID")을 업데이트할 수 없습니다
 UPDATE TABLE_NOTNULL SET LOGIN_ID = NULL WHERE TEL = '010-1234-5678';
 
 DELETE FROM TABLE_NOTNULL WHERE LOGIN_ID = 'TEST01';
 
 DROP TABLE TABLE_NOTNULL;
 
 CREATE TABLE TABLE_NOTNULL(
 	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNM_LGNIE_NN NOT NULL,
 	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN_LGNPWD_NN NOT NULL,
 	TEL VARCHAR2(20)
 );
 
 -- TEL 제약조건 추가 
 ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL);
 
 ALTER TABLE table_notnull modify(tel CONSTRAINT tblnn_tel_nn NOT null);
 
 -- 제약조건 이름 변경 
ALTER TABLE table_notnull RENAME CONSTRAINT SYS_C009390 TO TBLNN_TEL_NN;

-- 제약조건 삭제 
ALTER TABLE TALBE_NOTNULL DROP CONSTRAINT TBLNN_TEL_NN;


-- 2. UNIQUE
CREATE TABLE TABLE_UNIQUE(
	LOGIN_ID VARCHAR2(20) UNIQUE,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_UNIQUE VALUES('TEST01','TEST01','010-1234-5678');
-- 무결성 제약 조건(SCOTT.SYS_C008372)에 위배됩니다
INSERT INTO TABLE_UNIQUE VALUES('TEST01','TEST01','010-1234-5678');

INSERT INTO TABLE_UNIQUE VALUES(NULL,'TEST02','010-1234-5678');
INSERT INTO TABLE_UNIQUE VALUES('TEST02','TEST02','010-1234-7869');
UPDATE TABLE_UNIQUE TU SET TU.LOGIN_ID = 'TEST01';

DROP TABLE TABLE_UNIQUE;

CREATE TABLE TABLE_UNIQUE(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBL_LGID_UNQ UNIQUE ,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBL_LGNPWD_UNQ NOT NULL,
	TEL VARCHAR2(20)
);


-- TEL UNIQUE 제약조건 추가
ALTER TABLE TABLE_UNIQUE MODIFY(TEL CONSTRAINT TBL_TEL_UNQ UNIQUE);


-- 3. PRIMARY KEY(기본키)
-- UNIQUE + NOT NULL
CREATE TABLE TABLE_PK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) NOT NULL, 
	TEL VARCHAR2(20)
);
-- SQL Error [1] [23000]: ORA-00001: 무결성 제약 조건(SCOTT.SYS_C008377)에 위배됩니다
INSERT INTO TABLE_PK VALUES('TEST01','TEST01','010-1234-7869');
-- NULL을 ("SCOTT"."TABLE_PK"."LOGIN_ID") 안에 삽입할 수 없습니다
INSERT INTO TABLE_PK VALUES(NULL,'TEST01','010-1234-7869');

-- WHERE PK컬럼 = 1;

-- 4. FOREIGN KEY(외래키)
-- 다른 테이블과 관계를 맺을 때



CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);

CREATE TABLE EMP_FK(
 EMPNO NUMBER(4),
 ENAME VARCHAR2(10),
 JOB VARCHAR2(9),
 MGR NUMBER(4),
 HIREDATE DATE,
 SAL NUMBER(7,2),
 COMM NUMBER(7,2),
 DEPTNO NUMBER(2) REFERENCES DEPT_FK(DEPTNO)
);

-- 무결성 제약조건(SCOTT.SYS_C008380)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO EMP_FK(empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (8000,'김하나','SALESMAN',5000,SYSDATE,3000,NULL,50);

-- 입력 시 부모 테이블 데이터 먼저 입력 후 자식 테이블 데이터 입력
INSERT INTO DEPT_FK VALUES(10,'DATABASE','SEOUL');
INSERT INTO EMP_FK(empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (8000,'김하나','SALESMAN',5000,SYSDATE,3000,NULL,50);

-- 수정 시 
UPDATE EMP_FK
SET DEPTNO = 20 
WHERE EMPNO = 7201;


-- 삭제 시 
-- 자식 레코드 존재시 부모 삭제 불가 
-- 1) 자식 레코드 먼저 삭제 
-- 2) 부모 레코드 삭제 
DELETE FROM dept_fk WHERE deptno = 10;

DELETE FROM emp_fk WHERE empno = 7201;
DELETE FROM dept_fk WHERE deptno = 10;

DROP TABLE dept_fk;
DROP TABLE emp_fk;

-- 제약 조건명 + 부모 데이터 삭제 시 자식 데이터 처리 방법 지정
-- 1) on delete cascade : 부모 데이터 삭제 시 참조하는 데이터도 함께 삭제 
-- 2) on delete(set null) : 부모 데이터 삭제 시 참조하는 데이터에 NULL 설정
CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2)CONSTRAINT deptfk_deptno_pk PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);

CREATE TABLE EMP_FK(
 EMPNO NUMBER(4) CONSTRAINT empfk_empno_pk PRIMARY KEY ,
 ENAME VARCHAR2(10),
 JOB VARCHAR2(9),
 MGR NUMBER(4),
 HIREDATE DATE,
 SAL NUMBER(7,2),
 COMM NUMBER(7,2),
 DEPTNO NUMBER(2) CONSTRAINT empfk_deptno_fk REFERENCES dept_fk(deptno) ON DELETE SET null 
);

INSERT INTO DEPT_FK VALUES(10,'DATABASE','SEOUL');
INSERT INTO EMP_FK(empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (8000,'김하나','SALESMAN',5000,SYSDATE,3000,NULL,50);


ALTER TABLE EMP_FK ADD FOREIGN KEY (DEPTNO) REFERENCES DEPT_FK(DEPTNO);

DROP TABLE EMP_FK;
DROP TABLE DEPT_FK;

DELETE FROM dept_fk WHERE deptno = 10;

-- 5. CHECK 

CREATE TABLE TABLE_CHECK(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD) > 3),
	AGE NUMBER(3) CONSTRAINT TBLCK_AGE_CK CHECK (AGE BETWEEN 10 AND 18),
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_CHECK VALUES('TEST01','TEST',12,'010-1234-7869');

------------------------------
-- 제약조건을 따로 지정

DROP TABLE dept_fk;
DROP TABLE emp_fk;

-- 6. DEFAULT 

CREATE TABLE TABLE_DEFAULT(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT(LOGIN_ID,TEL) VALUES('TEST01','010-1234-7869');
INSERT INTO TABLE_DEFAULT VALUES('TEST02',NULL,'010-1234-7869');

SELECT * FROM TABLE_DEFAULT;

------- 
-- 사용자 생성 