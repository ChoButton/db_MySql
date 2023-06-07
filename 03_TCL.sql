-- 트랜잭션은 2개이상의 각종 쿼리문의 실행을 되돌리거나 영구히 반영할때 사용합니다.
-- 연습 테이블 생성
CREATE TABLE bank_account(
	act_num INT(5) AUTO_INCREMENT PRIMARY KEY,
	act_owner VARCHAR(10) NOT NULL,
    balance INT(10) DEFAULT 0 NOT NULL
    );

-- 계좌 데이터 2개를 집어넣어 보겠습니다.
INSERT INTO bank_account VALUE
					(NULL, '나구매', 50000),
                    (NULL, '가판매', 0);
                    
SELECT * FROM bank_account;

-- 트랜잭션 시작(시작점, ROLLBACK; 수행시 이 지점 이후의 내용을 전부 취소합니다)
-- ctrl + enter 로 실행해줘야함
START TRANSACTION;

-- 나구매의 돈 30000원 차감
UPDATE bank_account SET balance = (balance - 30000) WHERE act_owner = '나구매';
-- 가판매의 돈 30000원 증가
UPDATE bank_account SET balance = (balance + 30000) WHERE act_owner = '가판매';
set sql_safe_updates=0;

ROLLBACK;
SELECT * FROM bank_account;

-- 25000원 으로 다시 차감 및 증가하는 코드를 작성해 주시고, 커밋도 해주세요
START TRANSACTION;

UPDATE bank_account SET balance = (balance - 25000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 25000) WHERE act_owner = '가판매';

COMMIT;
ROLLBACK; -- 커밋한 이후에는 롤백을 실행해도 돌아갈 지점이 사라짐.
SELECT * FROM bank_account;


-- SAVEPOINT는 ROLLBACK 해당 지점 전까지는 반영, 해당지점 이후는 반영 안하는 경우 사용합니다.
START TRANSACTION;
-- 돈 3000원 거래
UPDATE bank_account SET balance = (balance - 3000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 3000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;
SAVEPOINT first_tx; -- first_tx 라는 저장지점 생성
-- 돈 5000원 거래
UPDATE bank_account SET balance = (balance - 5000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 5000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;

ROLLBACK; -- 전체 반영 취소
ROLLBACK TO first_tx; -- first_tx 저장시점 까지만 반영
COMMIT; -- 전체 반영;

