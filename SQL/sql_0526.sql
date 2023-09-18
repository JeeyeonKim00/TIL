# CEIL, ROUND, TRUNCATE

# 1) CEIL: 실수 데이터를 올림하여 정수로 나타내기
SELECT CEIL(12.345);

USE world;
#  국가별 언어 사용 비율을 소수 첫번쨰 자리에서 올림하여 정수로 나타내기
SELECT CountryCode, Language, Percentage, CEIL(Percentage)
FROM countrylanguage;

# 2) ROUND: 실수 데이터를 반올림 할 때 사용한다.
SELECT ROUND(12.345, 2); # 소수점 셋째 자리에서 반올림하여 둘째 자리까지 표시

SELECT CountryCode, Language, Percentage, ROUND(Percentage,0)
FROM countrylanguage;

# 3) TRUNCATE: 실수 데이터를 버림 할 때 사용한다.
SELECT TRUNCATE(12.345,2);

SELECT CountryCode, Language, Percentage, TRUNCATE(Percentage,0)
FROM countrylanguage;

# 4) SQL에서도 조건문을 사용할 있음. IF 문, CASE 문
# 1) IF(조건, 참 expr, 거짓 expr) -> where에 의해 걸러짐

# 도시 인구가 100만이 넘으면 'Big City'. 안 넘으면 'Small City'
SELECT name, Population, 
IF (Population >= 1000000,'Big City','Small City')
FROM city;

# 도시의 인구가 100만이 넘으면 'Big City', 50만이 넘으면 'Medium City', 안넘으면 'Small City'
SELECT name, 
	Population,
	IF (
		Population >=1000000, 
        'Big City', 
        IF(Population >=500000, 'Medium City','Small City'))
FROM city;

# NULL: 데이터가 없음을 의미
SELECT *
FROM country
WHERE IndepYear IS NULL;

SELECT *
FROM country
WHERE IndepYear IS NOT NULL;

# NULL값을 처리 -> NULL 값 대신에 다른 값으로 채우겠다.
# IFNULL (컬럼명, 채울값)

SELECT IndepYear, IFNULL(IndepYear, 0), Name
FROM country;

# CASE
-- CASE  
-- 	WHEN (조건1) THEN 출력1,
--     WHEN (조건2) THEN 출력2,
-- END


# 나라 별로 인구가 10억 이상, 1억 이상, 1억 이하인 컬럼을 추가하여 표현
SELECT name, 
		Population,
		CASE
			WHEN Population >= 1000000000 THEN '10억 이상'
            WHEN Population >= 100000000 THEN '1억 이상'
            WHEN Population < 100000000 THEN '1억 미만'
		END AS 'Result'
FROM country;


# groupby>
SELECT  AVG(Population) as avg_pop,
		CASE
			WHEN Population >= 1000000000 THEN '10억 이상'
            WHEN Population >= 100000000 THEN '1억 이상'
            WHEN Population < 100000000 THEN '1억 미만'
		END AS 'Result'
FROM country
GROUP BY result;

# DATE_FORMAT (날짜 데이터, 포맷팅)
# 날짜: (년-월-일 시:분:초)
use sakila;

SELECT amount, DATE_FORMAT(payment_date, '%Y-%m') as 'monthly'
FROM payment;


SELECT SUM(amount), DATE_FORMAT(payment_date, '%Y-%m') as 'monthly'
FROM payment
GROUP BY monthly;

#  JOIN
-- DROP DATABASE test;
-- CREATE DATABASE test;
USE test;
-- CREATE TABLE user (
-- 	user_id int(11) unsigned NOT NULL AUTO_INCREMENT, name varchar(30) DEFAULT NULL,
-- 	PRIMARY KEY (user_id)
-- );

-- CREATE TABLE addr (
-- 	id int(11) unsigned NOT NULL AUTO_INCREMENT, addr varchar(30) DEFAULT NULL,
-- 	user_id int(11) DEFAULT NULL,
-- 	PRIMARY KEY (id)
-- );
DROP DATABASE test;
CREATE DATABASE test;
use test;
CREATE TABLE user (
	user_id int(11) unsigned NOT NULL AUTO_INCREMENT, name varchar(30) DEFAULT NULL,
	PRIMARY KEY (user_id)
);

CREATE TABLE addr (
	id int(11) unsigned NOT NULL AUTO_INCREMENT, addr varchar(30) DEFAULT NULL,
	user_id int(11) DEFAULT NULL,
	PRIMARY KEY (id)
);

INSERT INTO user(name) VALUES ("jin"),
("po"),
("alice"),
("petter");
INSERT INTO addr(addr, user_id) VALUES ("seoul", 1),
("pusan", 2),
("deajeon", 3),
("deagu", 5), ("seoul", 6);

# INNER JOIN: 두 테이블 사이에 공통된 값이 없는 row는 출력 안함
SELECT user.user_id, user.name, addr.addr
FROM user
JOIN addr ON user.user_id = addr.user_id;

use world;

# INNER JOIN
# 도시 이름과 국가이름을 출력
# 도시: city, 국가이름: country 테이블

select * from city;
select * from country;

SELECT country.Name 'country_name' , city.Name 'city_name'
FROM city
JOIN country ON city.CountryCode = country.Code;

# LEFT JOIN
# FROM절에 오는 테이블의 모든 정보를 표시

use test;

SELECT user.user_id, user.name, addr.addr
FROM user
LEFT JOIN addr ON user.user_id = addr.user_id;


# RIGHT JOIN
SELECT addr.user_id, user.name, addr.addr
FROM user
RIGHT JOIN addr ON user.user_id = addr.user_id;

# UNION
# SELECT 문의 결과 데이터를 하나로 합쳐서 출력.
# 주의해야 할 사항: 컬럼의 개수, 타입, 순서가 모두 일치해야 함.
# UNION은 자동으로 distinct가 적용된다. (중복 데이터는 제거됨)
# UNION ALL은 중복을 허용 
SELECT name FROM user
UNION 
SELECT addr FROM addr; # 중복(서울) 제거된 후 출력

SELECT name FROM user
UNION ALL 
SELECT addr FROM addr; # 중복(서울) 제거된 후 출력

# UNION 으로 FULL OUTER JOIN 구현
SELECT id, user.name, addr.addr
FROM user
LEFT JOIN addr ON user.user_id = addr.user_id
UNION
SELECT id, user.name, addr.addr
FROM user
RIGHT JOIN addr ON user.user_id = addr.user_id;
