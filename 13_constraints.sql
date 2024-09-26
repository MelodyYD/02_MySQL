-- constraints (제약 조건)
-- 테이블에 데이터가 입력되거나 
-- 데이터의 무결성!!

-- not null
-- null 값 즉 비어있는 값을 허용하지 않는다.라는 제약 조건이다. 
drop table if exists user_notnull;
create table if not exists user_notnull(
										   user_no int         not null
									   ,   user_id varchar(30) not null
                                       ,  user_pwd varchar(40) not null
                                       , user_name varchar(30) not null
                                       ,    gender varchar(3)
                                       ,     phone varchar(30) not null
                                       ,     email varchar(50)
                                       ) engine = innodb;

select * from user_notnull;
describe user_notnull;

insert into user_notnull 
	 values (1, 'user01', 'pass01', '윤이정', '여', '010-1234-5678', 'test1@gmail.com')
		  , (2, 'user02', 'pass02', '윤여정', '여', '010-9012-3456', 'test2@gmail.com');
          
-- UNIQUE 제약 조건
-- 

drop table if exists user_unique;
create table if not exists user_unique(
										   user_no int         not null unique		-- null 허용 안하면서 유일한 값
									   ,   user_id varchar(30) not null
                                       ,  user_pwd varchar(40) not null
                                       , user_name varchar(30) not null
                                       ,    gender varchar(3)
                                       ,     phone varchar(30) not null
                                       ,     email varchar(50)
                                       , 		   unique(phone)		-- 이런 식으로도 제약조건 설정할 수 있다. ,로 둘 이상 적용은 뭔가 잘 안 된다.
                                       ) engine = innodb;
select * from user_unique;
describe user_unique;

-- not null + unique => primary key?

-- email, phone, user_no -> unique
insert into user_unique 
	 values (1, 'user01', 'pass01', '윤이정', '여', '010-1234-5678', 'test1@gmail.com')
		  , (2, 'user02', 'pass02', '윤여정', '여', '010-1234-5678', 'test2@gmail.com');
-- unique 제약조건 에러 발생 (전화번호 중복됨)

-- primary key **
-- 테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미한다. (매우 중요!!!!!!!!!!!!!!!!) 
-- 테이블에 대한 식별자 역할 -> 한 행을 식별할 수 있는 값을 의미한다.
-- unique + not null -> primary key
-- 한 테이블 당 한 개만 설정할 수 있다.
-- 한 개 컬럼에 설정할 수 있고, 여러 개의 컬럼을 묶어서 설정할 수 있다.
-- 복합키 (여러 개의 pk)

drop table if exists user_pk;
create table if not exists user_pk(
										   user_no int		   primary key
									   ,   user_id varchar(30) not null
                                       ,  user_pwd varchar(40) not null
                                       , user_name varchar(30) not null
                                       ,    gender varchar(3)
                                       ,     phone varchar(30) not null
                                       ,     email varchar(50)
                                    --   , 		   primary key(user_id)
                                       ) engine = innodb;
                                       
select * from user_unique;
describe user_unique;

-- foreign key (외래키)
-- 참조(연관)된 다른 테이블에서 제공하는 값만 사용할 수 있음
-- foreign key 제약조건에 의해

-- 부모테이블, 자식테이블 
drop table if exists user_grade;
create table if not exists user_grade (
										grade_code int primary key
									  , grade_name varchar(30) not null
									  ) engine = innodb;
insert into user_grade values (10, '일반회원')
							, (20, '우수회원')
							, (30, '특별회원');
                            
select * from user_grade;


drop table if exists user_fk1;
create table if not exists user_fk1
		(
			user_no int		    primary key
		,   user_id varchar(30) not null
		,  user_pwd varchar(40) not null
		, user_name varchar(30) not null
		,    gender varchar(3)
		,     phone varchar(30) not null
		,     email varchar(50)
        ,  grade_no int
        , foreign key(grade_no) references user_grade (grade_code)
		) engine = innodb;
                                       
describe user_fk1;

insert into user_fk1
	 values (1, 'user01', 'pass01', '윤이정', '여', '010-1234-5678', 'test1@gmail.com', 10)
		  , (2, 'user02', 'pass02', '윤여정', '여', '010-1234-5679', 'test2@gmail.com', 20);
          
-- 참조하고 있는 테이블(부모 테이블)에는 존재하지 않는 값을 집어넣을 때 에러가 발생한다. (에러 1062)
-- foreign key 제약조건 위반 
insert into user_fk1
	 values (3, 'user01', 'pass01', '윤이정', '여', '010-1234-5678', 'test1@gmail.com', 25);

select * from user_fk1;



-- check 제약조건
-- 조건을 위반할 시 허용하지 않는 제약조건

drop table if exists user_check;

-- 술을 파는 사이트, 미성년자 들어오면 안된다
-- 성별은 2가지 값만 받을 것이다.
create table if not exists user_check
		(
			  user_no int		    primary key auto_increment
		,   user_name varchar(30) 	not null
		,      gender varchar(3)	check(gender in ('남', '여'))
        , 		  age int 			check(age >=19)
		) engine = innodb;
        
describe user_check;

insert into user_check
	 values (null, '홍길동', '남', 25)
		  , (null, '하츄핑', '여', 7);
          
-- default
-- nullable한 컬럼에 비어있는 값 대신 우리가 설정한 기본값 적용

drop table if exists tbl_country;
create table if not exists tbl_country
		(
		  countru_code int		    primary key auto_increment
		, countru_name varchar(255)	default '한국'
		,   population varchar(255)	default '0명'
        ,     add_time datetime		default(current_time())
        , 	   add_day date			default(current_date())
		) engine = innodb;

insert into tbl_country
	 values (null, default, default, default, default);
     
select * from tbl_country;