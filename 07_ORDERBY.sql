-- ORDER BY 는 SELECT문의 질의 경과를 정렬할때 사용합니다.
-- ORDER BY 절 다음에는 어떤 컬럼을 기준으로 어떤 방식으로 정렬할지 적어줘야 합니다.

-- 다음은 user_tbl 에 대해서 키순으로 내림차순 정렬한 예시입니다.
SELECT * FROM user_tbl ORDER BY user_height DESC;

-- 문제
-- user_tbl 에 대해서, 키순으로 오름차순 정렬을 해주세되, 키가 동률이라면 체중순으로 내림차순
SELECT * FROM user_tbl ORDER BY user_height ASC, user_weight DESC;

-- 이름 가나다라 순으로 정보를 정렬하되, un이라는 별칭을 활용해보겠습니다.
SELECT user_num, user_name AS un, user_birth_year, user_address
	FROM user_tbl
    ORDER BY un DESC;
    
-- 컬럼 번호를(왼쪽부터 1번부터 시작, 우측으로 갈수록 1씩 증가) 이용해서도 정렬 가능합니다.    
SELECT user_num, user_name AS un, user_birth_year, user_address
FROM user_tbl
   ORDER BY 2 DESC;
   
-- 지역별 키 평균을 내림차순으로 정렬해서 보여주세요.
SELECT
	user_address AS 지역,
	AVG (user_height) AS 평균키
FROM user_tbl
GROUP BY user_address
ORDER BY 2 DESC;

-- 경기 지역 사람들만 체중 내림차순 정렬해 주세요.
-- 나머지 지역은 정렬기준이 없습니다.
SELECT * FROM user_tbl
ORDER BY
	CASE user_address
		WHEN '경기' THEN user_weight
        ELSE NULL
	END DESC;
    
-- 생년도가 1992년인 사람은 키 기준 오름차순
-- 생년도가 1998인 사람은 이름기준 오름차순으로 정렬해서 출력해주세요

SELECT
	user_name,
	user_birth_year,
	user_height
FROM user_tbl    
ORDER BY
	CASE user_birth_year
		WHEN '1992' THEN user_height
        WHEN '1998' THEN user_name
	    ELSE NULL
	END ASC