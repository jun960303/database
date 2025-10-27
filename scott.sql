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