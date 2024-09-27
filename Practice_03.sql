USE employee;

-- EMPLOYEE 테이블에서 직원들의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단, 컬럼의 별칭은 사원명, 생년, 생월, 생일로 한다.
SELECT EMP_NAME 사원명
	 , SUBSTRING(EMP_NO, 1, 2) 생년
	 , SUBSTRING(EMP_NO, 3, 2) 생월
     , SUBSTRING(EMP_NO, 5, 2) 생일
  from employee a;     


-- 날짜 데이터에서 사용할 수 있다.
-- 직원들의 입사일에도 입사년도, 입사월, 입사날짜를 분리 조회
SELECT EMP_NAME 사원명
	 , YEAR(HIRE_DATE) 입사년도
     , MONTH(HIRE_DATE) 입사월
     , DAYOFMONTH(HIRE_DATE) 입사날짜
 --    , HIRE_DATE 년월일 
  FROM employee;


-- WHERE 절에서 함수 사용도 가능하다.
-- 여직원들의 모든 컬럼 정보를 조회
SELECT *
  FROM employee
 WHERE SUBSTRING(EMP_NO, 8, 1) LIKE 2;


-- 함수 중첩 사용 가능 : 함수안에서 함수를 사용할 수 있음
-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고, '-'다음의 값은
-- '*'로 바꿔서 출력
SELECT EMP_NAME 사원명
	 , INSERT(EMP_NO, 8, 14, REPEAT('*',7)) 주민번호
  FROM employee;



-- EMPLOYEE 테이블에서 사원명, 이메일,
-- @이후를 제외한 아이디 조회
SELECT EMP_NAME 사원명
	 , EMAIL 이메일
     , SUBSTRING_INDEX(EMAIL, '@', 1) 아이디
  FROM employee;



-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사후 6개월이
-- 되는 날짜를 조회
SELECT EMP_NAME 사원명
	 , HIRE_DATE 입사일
     , ADDDATE(HIRE_DATE, INTERVAL 6 MONTH) AS '입사 후 6개월차'
  FROM employee;



-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회
SELECT *
  FROM employee
 WHERE DATEDIFF(NOW(),HIRE_DATE) >= 365*20;



-- EMPLOYEE 테이블에서 사원명, 입사일, 
-- 입사한 월의 근무일수를 조회하세요
SELECT EMP_NAME 사원명
	 , HIRE_DATE 입사일
     , DATEDIFF(LAST_DAY(HIRE_DATE), HIRE_DATE) +1  AS '입사월 근무일수'
  FROM employee;


select ABS(DATEDIFF('2019-10-25', '2019-10-28')) + 1
	 - ABS(DATEDIFF
					(ADDDATE('2019-10-25', INTERVAL 1 - DAYOFWEEK('2019-10-25') DAY)
				   , ADDDATE('2019-10-28', INTERVAL 1 - DAYOFWEEK('2019-10-28') DAY)
                    )
		  ) / 7 * 2
	 - (DAYOFWEEK(IF('2019-10-28' < '2019-10-25', '2019-10-28', '2019-10-25')) = 1)
	 - (DAYOFWEEK(IF('2019-10-28' > '2019-10-25', '2019-10-28', '2019-10-25')) = 7);
     
CREATE FUNCTION F_TOTAL_WEEKDAYS(date1 DATE, date2 DATE)
RETURNS INT
RETURN ABS(DATEDIFF(date2, date1)) + 1
        - ABS(DATEDIFF(ADDDATE(date2, INTERVAL 1 - DAYOFWEEK(date2) DAY),
                       ADDDATE(date1, INTERVAL 1 - DAYOFWEEK(date1) DAY))) / 7 * 2
        - (DAYOFWEEK(IF(date1 < date2, date1, date2)) = 1)
        - (DAYOFWEEK(IF(date1 > date2, date1, date2)) = 7);

SELECT F_TOTAL_WEEKEND('2020-01-01','2020-02-01')



SELECT * FROM employee;
-- EMPLOYEE 테이블에서 직원의 이름, 입사일, 근무년수를 조회
-- 단, 근무년수는 현재년도 - 입사년도로 조회
SELECT EMP_NAME 사원명
	 , HIRE_DATE 입사일
     , LEFT(CURDATE() - HIRE_DATE, 2) 근무년수
  FROM employee;


SELECT * FROM employee;
-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회 (mod)
SELECT *
  FROM employee
 WHERE EMP_ID % 2 != 0;