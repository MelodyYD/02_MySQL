-- set 연산자는 두 개 이상의 select 문 결과 집합을 결합하는 데 사용한다.
-- 주의해야 할 점은, 결합하는 결과 집합의 컬럼이 일치해야 한다.

-- union
-- 두 개 이상의 select 문의 결과를 결합하여 중복된 레코드는 제거한 후 반환한다.

-- 1 번째 쿼리
select *
  from tbl_menu
 where category_code = 10
union
-- 2 번째 쿼리
select *
  from tbl_menu
 where menu_price < 9000;

-- union all
-- 두 개 이상의 select 문의 결과를 결합하며 중복된 레코드는 제거하지 않고 반환하는 sql 연산자이다. 

-- 1 번째 쿼리
select *
  from tbl_menu
 where category_code = 10
union all
-- 2 번째 쿼리
select *
  from tbl_menu
 where menu_price < 9000;


-- intersect
-- 두 쿼리문의 결과 중 공통되는 레코드만 반환하는 연산자이다.
-- 하지만 mySQL에서는 제공하지 않는다.
-- inner join 또는 in 연산자를 통해서 intersect를 대체할 수 있다.

select *
  from tbl_menu a 
	   inner join (
					select * 
					  from tbl_menu 
					 where menu_price < 9000
			       ) b
    on (a.menu_code = b.menu_code)
 where a.category_code = 10;
 
 
-- in 연산자를 이용한 intersect
select
	   *
  from
	   tbl_menu
 where
	   category_code = 10
       and
       menu_code in (
					  select
							 menu_code
						from
							 tbl_menu
					   where
							 menu_price < 9000
					);


-- MINUS
-- 첫 번째 select 문의 결과에서 두 번째 select 문의  결과가 포함된 레코드를 제외한 레코드를 반환하는 연산자 = 차집합
-- 하지만 MySQL에서는 MINUS를 지원하지 않는다.
-- 그렇기에 left join을 이용하여 구현해야 한다.
   select *
	 from tbl_menu a
left join (
		   select * 
             from tbl_menu 
			where menu_price < 9000
		  ) b
	   on (a.menu_code = b.menu_code)
	where a.category_code = 10
		  and
          b.menu_code is null;