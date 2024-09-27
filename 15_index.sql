create table phone
		   (
			  phone_code int 			primary key
		   ,  phone_name varchar(100)
           , phone_price decimal(10, 2)
           )
engine = innodb;

-- decimal : sql에서 숫자 값을 정밀하게 저장하기 위해서 사용한다.
-- 소숫점을 다룰 때 유용하다.
-- 1번째 인자 : 정밀도. 전체 숫자의 최대 자릿수를 의미. 소숫점 앞뒤 포함
-- 2번째 인자 : 소숫점 아래 올 수 있는 최대 자리수를 의미

insert into phone
values
(1, '갤럭시s24울트라', 1200000),
(2, '갤럭시z폴드6', 2250000),
(3, '갤럭시z플립6', 1400000);

select * from phone;

-- explain (설명)
-- 우리가 작성한 쿼리문의 실행 계힉을 출력해준다.
explain select * from phone where phone_name = '갤럭시s24울트라';

-- 인덱스가 없는 컬럼을 where 절의 조건으로 실생한 결과

-- index 생성
create index idx_name;