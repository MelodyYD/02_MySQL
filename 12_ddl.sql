use menudb;

-- DDL (Data Definition Language)
-- 데이터를 정의하는 언어
-- 데이터베이스의 스키마를 정의하거나 수정하는 데 사용되는 SQL의 부분이다. 

-- CREATE
-- 테이블을 생성하기 위한 구문
-- IF NOT EXISTS <- 만약 존재하지 않는다면
-- 위에 구문을 적용하게 되면 기존에 존재하는 테이블이 있더라도 에러가 발생하지 않는다.

-- 테이블의 컬럼 설정 표현식
-- column_name / data_type(hength) [NOT NULL] [DEFAULT VALUE] [AUTO_INCREMENT] ;
-- [] 안의 것들은 생략 가능하다. (column_constraint)

-- tb1 테이블 생성
create table if not exists tb1 (
								pk int primary key
							  , fk int
							  , col1 varchar(255)			-- 문자열 길이 지정
                              , check(col1 in ('Y', 'N'))	-- Y 혹은 N 만 가능하도록 설정
							   ) engine = innodb;		

-- engine = innodb
-- 해당하는 테이블을 innodb라는 스토리지 엔진으로 만든다는 의미를 지녔다.
-- MySQL에서 가장 많이 사용하는 엔진으로, 데이터의 무결성, 안정성, 동시성 제어를 하는 것에 적합하다.

-- 테이블 정보 확인
describe tb1;

-- 만든 테이블에 값 insert 테스트
-- insert into tb1 values (null, 10, 'Y');
-- pk 컬럼은 null을 허용하지 않음

-- insert into tb1 values (1, null, 'G');
-- col1 컬럼은 'Y'나 'N' 외에는 허용하지 않음

insert into tb1 values (1, 10, 'Y');

select * from tb1;


create table if not exists tb2 (
								pk int primary key auto_increment
							  , fk int
							  , col1 varchar(255)			-- 문자열 길이 지정
                              , check(col1 in ('Y', 'N'))	-- Y 혹은 N 만 가능하도록 설정
							   ) engine = innodb;	
                               
                               
                               
                               
-- 잘못 생성한 테이블 삭제하는 구문 drop
drop table tb2;

-- auto-increment
-- insert시 pk라고 하는 컬럼에 자동으로 번호를 발생시킨다.
-- 중복되지 않는 값을 발생시킨다.
insert into tb2 values (null, 10, 'Y');
insert into tb2 values (null, 20, 'Y');
select * from tb2;

-- alter
-- 테이블에 추가/변경/수정/삭제하는 모든 것은 alter 명령어를 사용해서 적용할 수 있다.

-- 열 추가 -> 컬럼을 추가 
alter table tb2
		add col2 int not null;

describe tb2;

-- 열 삭제 -> 컬럼 삭제
alter table tb2
	   drop column col2;
       
       
-- 열 이름 변경 및 데이터 타입 변경
-- alter table 변경할테이블 change column 기존컬럼명 바꿀컬럼명 컬럼정의(데이터타입, 제약조건)
-- tb2 의 fk 컬럼을 change_fk 로 변경, 제약 조건을 not null로 변경
-- column 명시 안해도 상관은 없으나 명시하는 것이 좋다.

alter table tb2 change column fk change_fk int not null;

-- alter table 테이블명 drop 제약조건
alter table tb2 drop primary key;

-- auto_increment가 걸려있는 컬럼은 primary key 제거가 되지 않는다.
-- 따라서 auto_increment 속성을 modify로 제거한다.
-- modify 는 컬럼의 정의를 바꾸는 것이다. 

alter table tb2 modify pk int;

-- auto increment 제거 후 rpimary key 삭제
alter table tb2 drop primary key;


-- tb3 생성
create table if not exists tb3 (
								pk int primary key auto_increment
							  , fk int
							  , col1 varchar(255)			-- 문자열 길이 지정
                              , check(col1 in ('Y', 'N'))	-- Y 혹은 N 만 가능하도록 설정
							   ) engine = innodb;	
select * from tb3;
describe tb3;

-- tb3 삭제
-- 만약 tb3이 존재하면!! 드랍
drop table if exists tb3;



-- tb4, tb5 생성
create table if not exists tb4 (
								pk int primary key auto_increment
							  , fk int
							  , col1 varchar(255)			-- 문자열 길이 지정
                              , check(col1 in ('Y', 'N'))	-- Y 혹은 N 만 가능하도록 설정
							   ) engine = innodb;	
                               
create table if not exists tb5 (
								pk int primary key auto_increment
							  , fk int
							  , col1 varchar(255)			-- 문자열 길이 지정
                              , check(col1 in ('Y', 'N'))	-- Y 혹은 N 만 가능하도록 설정
							   ) engine = innodb;	
                               
                               
-- 여러개 동시 삭제
drop table if exists tb4, tb5;
select * from tb4;



-- truncate // delete
-- delete 구문을 작성하면 where 조건절로 행을 삭제하고, 조건 없이 delete를 하면 전체 행이 삭제되었다.
-- truncate 구문은 행별이 아닌 테이블을 drop한 다음 재생성을 해주는 초기화의 개념을 가지고 있다. 


create table if not exists tb6 (
								pk int primary key auto_increment
							  , fk int
							  , col1 varchar(255)			-- 문자열 길이 지정
                              , check(col1 in ('Y', 'N'))	-- Y 혹은 N 만 가능하도록 설정
							   ) engine = innodb;	
                               
-- 초기화 확인용 더미 데이터
insert into tb6 values (null, 10, 'Y');
insert into tb6 values (null, 20, 'Y');
insert into tb6 values (null, 30, 'Y');
insert into tb6 values (null, 40, 'Y');
insert into tb6 values (null, 50, 'Y');
select * from tb6;
describe tb6;

truncate table tb6;

-- truncate가 데이터를 수정하는 dml이 아니냐라고 할 수 있는데,
-- 이 친구는 table drop하고 create하기 때문에 테이블 구조를 변경한 것이다.