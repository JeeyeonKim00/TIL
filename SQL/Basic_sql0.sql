use test;
INSERT INTO user1(user_id, name, email, age, rdate)
VALUES(1, 'JYKim', 'brownpuka94@naver.com', 30, '2023-05-25');

INSERT INTO user1(user_id, name, email, age, rdate)
VALUES (2, 'park', 'mhso@gmail.com', 34, '2021-11-13'),
       (3, 'minho', 'mino@daum.net', 28, '2021-11-15'),
       (4, 'jiwon', 'jwon@daum.net', 27, '2021-11-11'),
       (5, 'siyeon', 'syw@snu.ac.kr', 25, '2021-11-12'),
       (6, 'taehee', 'thk@naver.com', 22, '2021-11-17');

# 특정 컬럼을 선택해서 데이터 삽입
INSERT INTO user1(user_id, name)
VALUES(7, 'Fine Kim');

# 컬럼명을 지정하지 않으면 전체 컬럼에 INSERT
INSERT INTO user1
VALUES(8, 'hahaha', 'jsfa@naver.com',21, now());

SELECT * FROM user1;

# 데이터 조회 SELECT 
# SELECT 구문은 반드시 FROM 부터, SELECT 는 제일 마지막에
SELECT name, email, rdate
FROM user1
WHERE user_id IN (5,7);

# 별명 붙이기(ALIAS)
SELECT user_id as '회원아이디',
		name as '회원이름',
        email as '회원이메일'
FROM user1;

# 중복값 제거
SELECT * FROM user1;
INSERT INTO user1 values(9, 'kiki','ad@naver.com', 90, now());

INSERT INTO user1 values(10, 'hahaha','jsfa@naver.com',21,now());

SELECT * FROM user1;

SELECT DISTINCT(age) FROM user1;

# WHERE(조건절) - Filtering
# 나이가 25세 이상인 사람들의 모든 정보를 조회하고 싶다?

SELECT *
FROM user1
WHERE age >= 25;

# 2021년 11월 15일 이전에 가입한 사람의 이메일, 이름, 나이 조회
 SELECT email, name, age, rdate
 FROM user1
 WHERE rdate < '2021-11-15';
 
 # AND 연산
 SELECT *
 FROM user1
 WHERE rdate >= '2021-11-12'
 AND rdate <= '2021-11-15';
 
 # BETWEEN
 SELECT *
 FROM user1
 WHERE rdate BETWEEN '2021-11-12' AND '2021-11-15';


# 나이가 30살 이상이고, 가입일이 2021-11-13일 이전인 사람의 모든 정보
SELECT *
FROM user1
WHERE (age >= 30) 
AND (rdate <= '2021-11-13');

SELECT * FROM user1;

# 나이가 20~35세, 가입일이 '2021-11-12~ 2021-11-15'인 사람들의 이름, 나이, 이메일, 가입일 조회
SELECT name, age, email, rdate
FROM user1
WHERE (age BETWEEN 20 AND 35)
AND (rdate BETWEEN '2021-11-12' and '2021-11-15');

# GROUP BY
# GROUPBY는 특정 컬럼을 기준으로 데이터를 묶은 다음
# 각종 집계 함수를 이용해 데이터를 집계(Aggregate)
# SUM, AVG< STD, STDDEV, VAR, MAX, MIN, COUNT 등등...
use world;

SELECT *
FROM city;

# 국가 코드 별 몇 개의 도시가 있는지?
SELECT CountryCode, COUNT(CountryCode)
FROM city
GROUP BY CountryCode;

# 각 국가마다 인구의 평균 구하기 (AVG)
SELECT CountryCode, AVG(Population)
FROM city
GROUP BY CountryCode;

# 인구수가 23만명 이하이거나 50만명 이상인 나라들의 국가 별 인구수 평균
SELECT CountryCode, AVG(Population)
FROM city
WHERE Population <= 230000 
OR Population >= 500000
GROUP BY CountryCode;


# 국가코드가 A로 시작하는 나라 중 인구수가 23만명 이하이거나 50만명 이상인 나라들의 국가 별 인구수 평균

# 연산자의 우선순위
# OR, AND 가 있으면 AND가 우선순위를 갖는다.
SELECT CountryCode, AVG(Population)
FROM city
WHERE (Population <= 230000 OR Population >= 500000)
AND CountryCode LIKE 'A%'
GROUP BY CountryCode;

# CountryCode, district 별 인구수 평균
SELECT CountryCode, District, AVG(Population)
FROM city
GROUP BY CountryCode ,District;

# 각 District별 인구수 평균, 표준편차, 최댓값, 최솟값, District 조회 후 
# 표준편차 내림차순 정렬 (ORDER BY)
# ORDER BY는 SELECT 보다 후순위에 실행됨

SELECT District, AVG(Population), STDDEV(Population) AS pop_std, MAX(Population), MIN(Population)
FROM city
GROUP BY District
ORDER BY  pop_std DESC;

# HAVING 절 - GROUP BY에 대한 조건절
# WHERE는 FROM에 대한 조건절 (테이블에 대한 필터링) --> 임시테이블 만든다
# HAVING은 집계 결과에 대한 조건절(SELECT에 대한 필터링) --> 임시테이블을 만들지 않는다.

# 인구수의 총 합이 5천만 이상인 나라
SELECT CountryCode, SUM(Population) as pop_sum
FROM city
GROUP BY CountryCode
HAVING pop_sum >= 50000000
ORDER BY pop_sum DESC;

# LIMIT: 표시되는 행의 개수를 제한
SELECT *
FROM city
LIMIT 1,3;



