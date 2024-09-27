USE employee;


-- 1.부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
SELECT *
  FROM employee
 WHERE DEPT_CODE = (SELECT DEPT_CODE
					  FROM employee
					 WHERE EMP_NAME = '노옹철'
				   );



-- 2.전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요
SELECT EMP_ID
	 , EMP_NAME
     , JOB_CODE
     , SALARY
  FROM employee
 WHERE SALARY >= (SELECT AVG(SALARY)
					FROM employee
				 );



-- 3.노옹철 사원의 급여보다 많이 받는 직원의
-- 사번, 이름, 부서, 직급, 급여를 조회하세요
-- 3700000
SELECT a.EMP_ID
	 , a.EMP_NAME
     , b.DEPT_TITLE
     , c.JOB_NAME
     , a.SALARY
  FROM employee a
  JOIN department b on a.DEPT_CODE = b.DEPT_ID
  JOIN job c on a.JOB_CODE = c.JOB_CODE
 WHERE a.SALARY > (SELECT SALARY
					 FROM employee
					WHERE EMP_NAME = '노옹철'
				  );



-- 4.가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급, 부서, 급여, 입사일을 조회하세요 (MIN)
-- 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY절에도 사용할 수 있다.
SELECT a.EMP_ID
	 , a.EMP_NAME
     , b.DEPT_TITLE
     , a.SALARY
     , a.HIRE_DATE
  FROM employee a
  JOIN department b on a.DEPT_CODE = b.DEPT_ID
 WHERE a.SALARY = (SELECT MIN(SALARY)
					 FROM employee
				  );



-- 5.부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
-- 힌트 : where 절에 subquery
   SELECT a.EMP_NAME
   	    , b.DEPT_TITLE
        , c.JOB_NAME
        , a.SALARY
     FROM employee a
LEFT JOIN department b on a.DEPT_CODE = b.DEPT_ID
     JOIN job c on a.JOB_CODE = c.JOB_CODE
    WHERE a.SALARY IN (  SELECT MAX(SALARY)
					       FROM employee
				       GROUP BY DEPT_CODE
				      );



-- 여기서부터 난이도 극상

select * from employee;
select * from department;
select * from job;
-- 6.관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 
-- 정보를 추출하여 조회
-- 사번, 이름, 부서명, 직급, '관리자' AS 구분 / '직원' AS 구분
-- 힌트 : is not null, union(혹은 then, else), distinct
SELECT a.EMP_ID
	 , a.EMP_NAME
     , b.DEPT_TITLE
     , c.JOB_NAME
     , a.MANAGER 관리자
     , a.etc 직원
  FROM employee a
  JOIN department b on a.DEPT_CODE = b.DEPT_ID
  JOIN job c using (JOB_CODE)
 WHERE 



-- 7.자기 직급의 평균 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요
-- 단, 급여와 급여 평균은 만원단위로 계산하세요
-- 힌트 : round(컬럼명, -5)

-- 8.퇴사한 여직원과 같은 부서, 같은 직급에 해당하는
-- 사원의 이름, 직급, 부서, 입사일을 조회


-- 9.급여 평균 3위 안에 드는 부서의 
-- 부서 코드와 부서명, 평균급여를 조회하세요
-- limit 사용


-- 10.직원 정보에서 급여를 가장 많이 받는 순으로 이름, 급여, 순위 조회
-- 힌트 : DENSE_RANK() OVER or RANK() OVER


-- 11.부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은
-- 부서의 부서명과, 부서별 급여 합계 조회
-- 힌트 : SUM(E2.SALARY) * 0.2