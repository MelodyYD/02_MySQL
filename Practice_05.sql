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
	   , FLOOR(DATEDIFF(CURDATE(),STR_TO_DATE(CONCAT(19, LEFT(PROFESSOR_SSN,6)), '%Y%m%d'))/365) 나이
    FROM TB_PROFESSOR
   WHERE SUBSTRING(PROFESSOR_SSN, 8, 1) = 1
ORDER BY 나이 ASC;

-- SELECT DATEDIFF(CURDATE(),STR_TO_DATE(CONCAT(19, LEFT(PROFESSOR_SSN,6)), '%Y%m%d'))/365 A FROM TB_PROFESSOR ORDER BY A ASC;


-- 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 
--    출력 헤더는’이름’ 이 찍히도록 핚다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
SELECT SUBSTRING(PROFESSOR_NAME, 2) 이름
  FROM TB_PROFESSOR;
  
  
-- 5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가? 
--    이때, 만 19살이 되는 해에 입학하면 재수를 하지 않은 것으로 간주한다.
SELECT STUDENT_NO
	 , STUDENT_NAME
  FROM TB_STUDENT
 WHERE DATEDIFF(ENTRANCE_DATE,ADDDATE(STR_TO_DATE(LEFT(STUDENT_SSN,6), '%y%m%d'), INTERVAL 19 YEAR)) >= 60;


-- 6. 2020년 크리스마스는 무슨 요일이었는가?
SELECT DAYOFWEEK('2020-12-25');


-- 7. `*STR_TO_DATE*('99/10/11', '%y/%m/%d')` `*STR_TO_DATE*('49/10/11', '%y/%m/%d')`은 각각 몇 년 몇 월 몇 일을 의미할까? 
--    또 `*STR_TO_DATE*('70/10/11', '%y/%m/%d')` `*STR_TO_DATE*('69/10/11', '%y/%m/%d')` 은 각각 몇 년 몇 월 몇 일을 의미할까?

-- 1999-10-11	2049-10-11	1970-10-11	2069-10-11
SELECT STR_TO_DATE('99/10/11', '%y/%m/%d')
	 , STR_TO_DATE('49/10/11', '%y/%m/%d')
	 , STR_TO_DATE('70/9/28', '%y/%m/%d')
     , STR_TO_DATE('69/9/28', '%y/%m/%d');


-- 8. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오.
--    단, 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE
WHERE STUDENT_NO LIKE 'A517178';


-- 9. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.
  SELECT DEPARTMENT_NO 학과번호
	   , COUNT(*) AS '학생수(명)'
    FROM TB_STUDENT
GROUP BY DEPARTMENT_NO;


-- 10. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을 작성하시오.
SELECT COUNT(*)
  FROM TB_STUDENT
 WHERE COACH_PROFESSOR_NO IS NULL;
 

-- 11. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오.
--     단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
  select LEFT(TERM_NO, 4) 년도
	   , ROUND(AVG(POINT), 1) 평점
    from TB_GRADE 
   WHERE STUDENT_NO LIKE 'A112113'
GROUP BY 년도;


-- 12. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오.
  SELECT DEPARTMENT_NO 학과번호
	   , COUNT(CASE WHEN ABSENCE_YN = 'Y' THEN 1 ELSE NULL END) 휴학생수
    FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;


-- 13. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다. 어떤 SQL 문장을 사용하면 가능하겠는가?
  SELECT STUDENT_NAME 동일이름
  	   , COUNT(*) 동명인수
    FROM TB_STUDENT
GROUP BY STUDENT_NAME
  HAVING COUNT(*) > 1
ORDER BY 동일이름 ASC;


-- 14. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총평점을 구하는 SQL 문을 작성하시오. 
--     (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.
  SELECT LEFT(TERM_NO, 4) AS '년도'
	   , RIGHT(TERM_NO, 2) AS '학기'
       , ROUND(AVG(POINT), 1) AS '평점'
    FROM TB_GRADE
   WHERE STUDENT_NO = 'A112113'
GROUP BY 년도
	   , 학기
WITH ROLLUP;



-- ==============================================================================


-- 춘대학 실습문제 level3

-- 1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
  SELECT STUDENT_NAME AS '학생 이름'
	   , STUDENT_ADDRESS AS '주소지'
    FROM TB_STUDENT
ORDER BY STUDENT_NAME ASC;


-- 2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
  SELECT STUDENT_NAME
	   , STUDENT_SSN
    FROM TB_STUDENT
   WHERE ABSENCE_YN LIKE 'Y'
ORDER BY STR_TO_DATE(LEFT(STUDENT_SSN, 6), '%y%m%d') DESC;


-- 3. 주소지가 강원도나 경기도인 학생들 중 2020년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오. 
--    단, 출력헤더에는 "학생이름","학번", "거주지 주소" 가 출력되도록 한다.
  SELECT STUDENT_NAME AS '학생 이름'
	   , STUDENT_NO AS '학번'
       , STUDENT_ADDRESS AS '거주지 주소'
    FROM TB_STUDENT
   WHERE LEFT(STUDENT_ADDRESS, 2) IN ('경기', '강원')
		 AND
         YEAR(ENTRANCE_DATE) >= 2020
ORDER BY STUDENT_NAME ASC;


-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오. 
--    (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)  005
  SELECT a.PROFESSOR_NAME
	   , a.PROFESSOR_SSN
	FROM TB_PROFESSOR a
    JOIN TB_DEPARTMENT b USING (DEPARTMENT_NO)
   WHERE b.DEPARTMENT_NAME LIKE '법학과'
ORDER BY DATEDIFF(CURDATE(),STR_TO_DATE(CONCAT('19',LEFT(a.PROFESSOR_SSN, 6)), '%Y%m%d')) DESC;


-- 5. 2022 년 2학기에 C3118100 과목을 수강한 학생들의 학점을 조회하려고 한다. 
-- 	  학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
  SELECT STUDENT_NO
	   , POINT
    FROM TB_GRADE
   WHERE CLASS_NO LIKE 'C3118100'
		 AND
         TERM_NO LIKE '202202'
ORDER BY POINT DESC
	   , STUDENT_NO ASC;


-- 6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성하시오.
  SELECT a.STUDENT_NO
	   , a.STUDENT_NAME
       , b.DEPARTMENT_NAME
	FROM TB_STUDENT a
    JOIN TB_DEPARTMENT b USING (DEPARTMENT_NO)
ORDER BY a.STUDENT_NAME ASC;


-- 7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
  SELECT a.CLASS_NAME
	   , b.DEPARTMENT_NAME
    FROM TB_CLASS a
    JOIN TB_DEPARTMENT b USING (DEPARTMENT_NO)
ORDER BY b.DEPARTMENT_NAME ASC
	   , A.CLASS_NAME ASC;
       
       
-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
  SELECT a.CLASS_NAME
	   , b.PROFESSOR_NAME
	FROM TB_CLASS a
    JOIN TB_CLASS_PROFESSOR c ON c.CLASS_NO = a.CLASS_NO
    JOIN TB_PROFESSOR b ON b.PROFESSOR_NO = c.PROFESSOR_NO
ORDER BY a.CLASS_NAME ASC;
       

-- 9. 8 번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다. 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
SELECT a.CLASS_NAME
	 , b.PROFESSOR_NAME
  FROM TB_CLASS a
  JOIN TB_CLASS_PROFESSOR c ON c.CLASS_NO = a.CLASS_NO
  JOIN TB_PROFESSOR b ON b.PROFESSOR_NO = c.PROFESSOR_NO
  JOIN TB_DEPARTMENT d ON d.DEPARTMENT_NO = b.DEPARTMENT_NO
 WHERE d.CATEGORY LIKE '인문사회';
 

-- 10. ‘음악학과’ 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오. 
--     (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)
  SELECT a.STUDENT_NO AS '학번'
	   , a.STUDENT_NAME AS '학생 이름'
       , ROUND(AVG(c.POINT), 1) AS '전체 평점'
    FROM TB_STUDENT a
    JOIN TB_DEPARTMENT b ON a.DEPARTMENT_NO = b.DEPARTMENT_NO
    JOIN TB_GRADE c ON a.STUDENT_NO = c.STUDENT_NO
   WHERE b.DEPARTMENT_NAME LIKE '음악학과'
GROUP BY 학번
ORDER BY ROUND(AVG(c.POINT), 1) DESC;


-- 11. 학번이 `A313047` 인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용할 SQL 문을 작성하시오. 
--     단, 출력헤더는 ‚’학과이름‛, ‚학생이름‛, ‚지도교수이름‛으로 출력되도록 한다.
SELECT b.DEPARTMENT_NAME AS '학과이름'
	 , a.STUDENT_NAME AS '학생이름'
     , c.PROFESSOR_NAME AS '지도교수이름'
  FROM TB_STUDENT a
  JOIN TB_DEPARTMENT b ON a.DEPARTMENT_NO = b.DEPARTMENT_NO
  JOIN TB_PROFESSOR c ON a.COACH_PROFESSOR_NO = c.PROFESSOR_NO
 WHERE a.STUDENT_NO LIKE 'A313047';
 
 
-- 12. 2022년도에 인간관계론 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.
SELECT a.STUDENT_NAME
	 , b.TERM_NO
  FROM TB_STUDENT a
  JOIN TB_GRADE b ON a.STUDENT_NO = b.STUDENT_NO
  JOIN TB_CLASS c ON b.CLASS_NO = c.CLASS_NO
 WHERE c.CLASS_NAME LIKE '%인간관계론%'
	   AND
       b.TERM_NO LIKE '2022%';


-- 13. 예체능 계열 과목 중 과목 담당교수를 한명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
-- 학과 테이블의 CATEGORY = 예체능 : 미술학과 무용학과 공연예술학과 음악학과 도예학과 산업디자인학과 디자인학과 체육학과


SELECT * FROM TB_CLASS_PROFESSOR WHERE CLASS_NO LIKE 'C0027000';

select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE; -- 학점테이블