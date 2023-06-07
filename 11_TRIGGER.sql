/* <트리거>
특정 테이블에 명령이 내려지면 자동으로 연동된 명령을 수행하도록 구문을 걸어줌
예) 회원 탈퇴시 탈퇴한 회원을 DB에서 바로 삭제하지 하지 않고 탈퇴보류 테이블에 INSERT를 하거나
	수정이 일어나면 수정 전 내역을 따로 다른 테이블에 저장하거나
	특정 테이블 대상으로 실행되는 구문 이전이나 이후에 추가로 실행할 명령어를 지정 
문법은 프로시저와 유사(달러자리에 슬래시로 입력)
DELIMITER //
CREATE TRIGGER 트리거명
	실행시점(BEFORE / AFTER) 실행로직(어떤 구문이 들어오면 실행할지 작성)
	ON 트리거적용테이블
	FOR EACH ROW
BEGIN
	트리거 실행시 작동코드
END //
DELIMITER ;
*/

# 트리거를 적용할 테이블 생성
CREATE TABLE game_list(
	id INT AUTO_INCREMENT PRIMARY KEY,
    game_name VARCHAR(10)
);

INSERT INTO game_list VALUES
	(1, '바람의나라'),
    (2, '리그오브레전드'),
    (3, '스타크래프트'),
    (4, '리니지');
    
-- 삭제할때마다 게임이 삭제되었다는 메세지를 추가하기
DELIMITER //
CREATE TRIGGER testTrg
	AFTER DELETE # 삭제 후에
    ON game_list # game_list 테이블의 자료가
    FOR EACH ROW
BEGIN
	# OLD. 컬럼명 을 적으면 해당 삭제 row의 데이터를 조회할 수 있습니다.
	SET @msg = CONCAT(OLD.game_name, '게임이 삭제되었습니다');
END //
DELIMITER ;
-- 데이터 삭제전
SELECT @msg;
-- 게임 삭제후
DELETE FROM game_list WHERE id = 3;
