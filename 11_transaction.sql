-- transaction
-- 데이터베이스에서 한번에 수행되는 작업의 단위이다.
-- 시작, 진행, 종료 단계를 거치게 되면서 만약 주간에 예기치 못한 값 or 에러 발생할 시 rollback(시작하기 이전 단계로 돌아감)을 진행한다.
-- MySQL은 default 설정이 auto-commit(자동 저장)이기 때문에 우리가 수행한 쿼리문을 돌릴 수 없다.

-- java 복습
-- boolean 기본값은 false, false 가 정수로는 0이다.

-- autocommit 활성화
set autocommit = 1;

-- 비활성화
set autocommit = 0;
