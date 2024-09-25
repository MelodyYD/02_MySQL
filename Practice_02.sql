USE employee;

select * from department;		-- 부서
select * from employee;			-- 사원 정보
select * from job;				-- 직급
select * from location;			-- 근무지역
select * from nation;			-- 국가명
select * from sal_grade;	 	-- 연봉

-- 1. 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- (조회시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.)
-- (사용 테이블 : job, department, location, employee)
-- employee a, job b, department c, location d
SELECT a.EMP_ID
	 , a.EMP_NAME
     , b.JOB_NAME
     , c.DEPT_TITLE
     , d.LOCAL_NAME
     , a.SALARY
  FROM employee a
	   JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
	   JOIN department c ON (a.DEPT_CODE = c.DEPT_ID)
       JOIN location d ON (c.LOCATION_ID = d.LOCAL_CODE)
 WHERE b.JOB_NAME = '대리'
	   AND
       d.LOCAL_NAME LIKE '%ASIA%';
       


-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
-- (사용 테이블 : employee, department, job)
-- employee a, department b, job c
SELECT a.EMP_NAME
	 , a.EMP_NO
	 , b.DEPT_TITLE
     , c.JOB_NAME
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN job c ON (a.JOB_CODE = c.JOB_CODE)
 WHERE a.EMP_NO LIKE '7%'
   AND a.EMP_NO LIKE '%-2%'
   AND a.EMP_NAME LIKE '전%';
       

-- 3. 이름에 '형'자가 들어가는 직원들의
-- 사번, 사원명, 직급명을 조회하시오.
-- (사용 테이블 : employee, job)
SELECT a.EMP_ID
	 , a.EMP_NAME
     , b.JOB_NAME
  FROM employee a
  JOIN job b USING (JOB_CODE)
 WHERE a.EMP_NAME LIKE '%형%';

-- 4. 해외영업팀에 근무하는 사원명, 
--    직급명, 부서코드, 부서명을 조회하시오.
-- (사용 테이블 : employee, department, job)
SELECT a.EMP_NAME
     , b.JOB_NAME
     , a.DEPT_CODE
     , c.DEPT_TITLE
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
  JOIN department c ON (a.DEPT_CODE = c.DEPT_ID)
 WHERE c.DEPT_TITLE LIKE '해외영업%';

-- 5. 보너스포인트를 받는 직원들의 사원명, 
--    보너스포인트, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, department, location)
SELECT a.EMP_NAME
     , a.BONUS
     , b.DEPT_TITLE
     , c.LOCAL_NAME
  FROM employee a
	   JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
       JOIN location c ON (b.LOCATION_ID = c.LOCAL_CODE)
 WHERE a.BONUS IS NOT NULL;


-- 6. 부서코드가 D2인 직원들의 사원명, 
--    직급명, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, job, department, location)
SELECT a.EMP_NAME
     , b.JOB_NAME
     , c.DEPT_TITLE
     , d.LOCAL_NAME
  FROM employee a
	   JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
	   JOIN department c ON (a.DEPT_CODE = c.DEPT_ID)
       JOIN location d ON (c.LOCATION_ID = d.LOCAL_CODE)
 WHERE a.DEPT_CODE = 'D2';


-- 7. 본인 급여 등급의 최소급여(MIN_SAL)를 초과하여 급여를 받는 직원들의
--    사원명, 직급명, 급여, 보너스포함 연봉을 조회하시오.
--    연봉에 보너스포인트를 적용하시오.
-- (사용 테이블 : employee, job, sal_grade)
-- IFNULL 사용법 : IFNULL(컬럼명,대체문자)
SELECT a.EMP_NAME
	 , b.JOB_NAME
     , a.SALARY
     , d.BONUSPLUS as '보너스 포함 연봉'
  FROM employee a
  JOIN job b on a.JOB_CODE = b.JOB_CODE
  JOIN sal_grade c on a.SAL_LEVEL = c.SAL_LEVEL
  JOIN (
		SELECT a.EMP_ID
			 , (a.SALARY * 12) + (a.SALARY * IFNULL(a.BONUS,0)) AS 'BONUSPLUS' 
		  FROM employee a
	   ) d ON a.EMP_ID = d.EMP_ID
 WHERE a.SALARY > C.MIN_SAL;

SELECT SALARY * 12 + (SALARY * IFNULL(BONUS,'0')) AS TEST FROM employee;


-- 8. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--    사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT a.EMP_NAME
	 , b.DEPT_TITLE
     , c.LOCAL_NAME
     , d.NATIONAL_NAME
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN location c ON (b.LOCATION_ID = c.LOCAL_CODE)
  JOIN nation d ON (c.NATIONAL_CODE = d.NATIONAL_CODE)
 WHERE d.NATIONAL_NAME = '한국' 
	OR d.NATIONAL_NAME = '일본';