select *
  from tbl_menu
 where category_code = (select category_code from tbl_menu where menu_name = '민트미역국');


-- 가장 많은 메뉴가 포함된 카테고리 조회
-- 1. 서브쿼리 작성
select count(*) as 'count'
from tbl_menu
group by category_code;

-- max() 함수 : 최대값 / min() 함수 : 최솟값
-- from 절에 사용하는 서브쿼리를 파생 테이블(derived table)이라 부르며, 파생테이블은 반드시 별칭을 가지고 있어야 한다.
select max(count)
from (select count(*) count from tbl_menu group by category_code) as `count menu`;

-- 상관 서브쿼리
-- 메인쿼리문이 서브쿼리의 결과에 영향을 주느 ㄴ경우를 상관 서브쿼리라고 한다.

-- 카테고리 별 평균 가격보다 높은 가격의 메뉴 조회하기
select a.menu_code, a.menu_name, a.menu_price
from tbl_menu a
where menu_price > (select avg(menu_price) from tbl_menu where category_code = a.category_code);


-- CTE (Common Table Expression)
-- 파생 테이블과 비슷한 개념이며, 코드의 가독성과 재사용성을 위해 파생 테이블 대신 사용하게 된다.
-- from 절에서만 사용이 된다. (join일 시 join 구문에서도 사용 가능)

with menucte as (select a.menu_name '메뉴명', b.category_name '분류' from tbl_menu a join tbl_category b on a.category_code = b.category_code)
select * from menucte order by 메뉴명;