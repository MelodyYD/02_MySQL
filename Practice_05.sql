use chundb;

-- 춘대학 실습문제 level 1

-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오.
--    단, 출력 헤더는 "학과 명", "계열"으로 표시하도록 한다.
SELECT DEPARTMENT_NAME AS '학과 명'
	 , CATEGORY 계열
  FROM TB_DEPARTMENT;
  

-- 2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
SELECT CONCAT(DEPARTMENT_NAME, '의 정원은 ', CAPACITY, ' 명 입니다.') AS '학과별 정원'
  FROM TB_DEPARTMENT;
  
  
-- 3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이 들어왔다. 누구인가?
--    (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아내도록 하자)
SELECT a.STUDENT_NAME
  FROM TB_STUDENT a
  JOIN TB_DEPARTMENT b using (DEPARTMENT_NO)
 WHERE a.ABSENCE_YN = 'Y'
	   AND
       SUBSTRING(a.STUDENT_SSN, 8, 1) = 2
	   AND
       b.DEPARTMENT_NAME = '국어국문학과';


-- 4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다. 
--    그 대상자들의 학번이 다음과 같을 때 대상자들을 찾는  SQL 구문을 작성하시오.
--    A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME
  FROM TB_STUDENT
 WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');
 
 
-- 5. 입학정원이 20 명 이상 30 명 이하인 학과들의 학과 이름과 계열을 출력하시오.
SELECT DEPARTMENT_NAME AS '학과 이름'
	 , CATEGORY 	   as '학과 계열'
  FROM TB_DEPARTMENT
 WHERE CAPACITY BETWEEN 20 AND 30;
 
 
-- 6. 춘기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고있다.
--    그럼 춘기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
SELECT PROFESSOR_NAME
  FROM TB_PROFESSOR
 WHERE DEPARTMENT_NO IS NULL;
 
 
-- 7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.
--    어떠한 SQL 문장을 사용하면 될 것인지 작성하시오.
SELECT *
  FROM TB_STUDENT
 WHERE DEPARTMENT_NO IS NULL;


-- 8. 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데,
-- 	  선수과목이 존재하는 과목들은 어떤 과목인지 과목번호를 조회해보시오.
SELECT CLASS_NO
  FROM TB_CLASS
 WHERE PREATTENDING_CLASS_NO IS NOT NULL;


-- 9. 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.
  SELECT DISTINCT CATEGORY
    FROM TB_DEPARTMENT
ORDER BY CATEGORY ASC;


-- 10. 19 학번 전주 거주자들의 모임을 만들려고 한다.
-- 	   휴학한 사람들은 제외하고, 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
  SELECT STUDENT_NO
	   , STUDENT_NAME
       , STUDENT_SSN
--     , STUDENT_ADDRESS
--     , ABSENCE_YN
--     , ENTRANCE_DATE
    FROM TB_STUDENT
   WHERE ABSENCE_YN LIKE 'N'
	     AND
         YEAR(ENTRANCE_DATE) = '2019'
         AND
         LEFT(STUDENT_ADDRESS,2) LIKE '전주'
ORDER BY STUDENT_NAME ASC;



-- ==============================================================================



-- 춘대학 실습문제 level 2

-- 1. 영어영문학과(학과코드 `002`) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른순으로 표시하는 SQL 문장을 작성하시오.
--    (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
  SELECT STUDENT_NO 학번
  	   , STUDENT_NAME 이름
	   , YEAR(ENTRANCE_DATE) 입학년도
    FROM TB_STUDENT
   WHERE DEPARTMENT_NO = 002
ORDER BY YEAR(ENTRANCE_DATE) ASC;


-- 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 두 명 있다고 한다.
--    그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. 
SELECT PROFESSOR_NAME
	 , PROFESSOR_SSN
  FROM TB_PROFESSOR
 WHERE CHAR_LENGTH(TRIM(PROFESSOR_NAME)) != 3;
 
 
-- 3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오.
--    단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. 
--    (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 ‘만’으로 계산한다.)
-- 	  힌트 : floor, datediff, curdate, str_to_date, concat
--    주민번호에서 년도 추출, 19앞에 붙여서 ex) 1993 만들기
--    이후 현재 년도와 1993 간의 날짜 차이 구해서 365로 나누기

  SELECT PROFESSOR_NAME 교수이름
	   , (SELECT FLOOR(DATEDIFF(CURDATE(),STR_TO_DATE(CONCAT(19, LEFT(PROFESSOR_SSN,6)), '%Y%m%d'))/365) FROM TB_PROFESSOR) AS '나이(연)'
    FROM TB_PROFESSOR
   WHERE SUBSTRING(PROFESSOR_SSN, 8, 1) = 1
ORDER BY (SELECT LEFT(PROFESSOR_SSN, 2) FROM TB_PROFESSOR) ASC;

SELECT FLOOR(DATEDIFF(CURDATE(),STR_TO_DATE(CONCAT(19, LEFT(PROFESSOR_SSN,6)), '%Y%m%d'))/365) FROM TB_PROFESSOR;


-- ==============================================================================


select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE; -- 학점테이블