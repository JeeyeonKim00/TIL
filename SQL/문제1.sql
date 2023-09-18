-- 1. countrylanguage 테이블에서 countrycode가 'NA'로 시작하는 국가의 언어들중, 사용자의 언어percentage가 10이상 30이하인 언어를 percentage순으로 오름차순 정렬
USE world;
SELECT *
FROM countrylanguage;

SELECT *
FROM countrylanguage
WHERE CountryCode LIKE 'NA%'
AND Percentage BETWEEN 10 AND 30
ORDER BY Percentage ASC;

-- 2. countrylanguage 테이블에서 contrycode별 공식적인 언어(isofficial이 T)와 평균 퍼센테이지를 조회하고 평균 퍼센테이지를 내림차순으로 정렬
SELECT CountryCode, AVG(Percentage) as avg_per
FROM countrylanguage
WHERE IsOfficial = 'T'
GROUP BY CountryCode
ORDER  BY avg_per DESC;

-- 3. city 테이블의 국가코드별 도시의 개수를 구하세요. 단 도시가 50개 이상인 국가만 표시하세요.
SELECT CountryCode, COUNT(Name) as cnt
FROM city
GROUP BY CountryCode
HAVING cnt >= 50
ORDER BY cnt DESC;


-- 4. country 테이블에서 독립년도가 1901~1999인 지역 중에서, 정부형태(GovenrnmentForm)가 Republic이면서 평균 GNP가 6000 이상인 지역
SELECT Region
FROM country
WHERE (IndepYear BETWEEN 1901 AND 1999)
AND GovernmentForm = 'Republic'
GROUP BY Region
having GNP >= 6000;


-- 5.country 테이블에서 Region별   surfaceArea, Capital 평균 및 GNP합계 구하시오 (단 Capital은 30 이상인곳만 조회,하고 오름차순 정렬) (편집됨) 

SELECT Region, AVG(SurfaceArea) as surf, AVG(Capital) as cap, SUM(GNP) as sum
FROM country
WHERE capital >= 30
GROUP BY Region
ORDER BY cap;

-- 6. city 테이블에서, CountryCode가 A로 시작하면서 인구가 50만명 이상인 국가의 이름, CountryCode, Population을 구하고, 인구 수를 기준으로 내림차순 정리
SELECT Name, CountryCode, Population
FROM city
WHERE CountryCode LIKE 'A%'
AND Population >= 500000
ORDER BY Population DESC;


-- 7. country 테이블에서 대륙별 국가이름, 지역, 평균 독립년도와 평균 예상 수명을 조회하고 
-- 남아메리카와 아프리카 대륙을 제외, 
-- 독립년도가 20세기 이후인 국가들 중 공화국(republic)인 나라들의 데이터를 구하시오. 
-- 평균 독립년도는 오름차순, 평균 예상 수명은 내림차순으로 정렬.

-- SELECT Continent, Name, Region, AVG(IndepYear) avg_indep, AVG(LifeExpectancy) avg_life
-- FROM country
-- WHERE GovernmentForm = 'Republic' and IndepYear >=1900
-- GROUP BY Continent, Name, Region
-- HAVING Continent NOT IN ('Africa','South America')  
-- ORDER BY avg_indep , avg_life DESC;




-- 8. 대륙, 국가, 인구수, GNP, 예상 수명의 상관 관계를 조사하기 위해 
-- country 테이블에서 
-- 대륙, 대륙별 평균 GNP, 대륙별 예상 평균 수명, 국가, 인구수, GNP, 예상 수명을 조회하고 
-- 각각의 컬럼 값이 Null인 국가는 조회하지 않으며, 
-- 인구 수가 10000명 이하의 국가는 제외하여 구한다. 
-- 평균 수명과 평균 GNP는 내림차순으로 정렬한다.


-- SELECT Continent, 
-- 		AVG(GNP) avg_gnp, 
--         AVG(LifeExpectancy) avg_life, 
--         AVG(Population) avg_pop
-- FROM country
-- WHERE (Continent IS NOT NULL AND GNP IS NOT NULL AND LifeExpectancy IS NOT NULL AND Population IS NOT NULL) AND Population >= 10000
-- GROUP  BY Continent 
-- ORDER BY avg_life , avg_gnp DESC;
