# SELECT 에서 서브쿼리 사용하기
# 전체 나라 수, 전체 도시 수, 전체 언어의 수를 출력
use world;


# step 2) 서브 쿼리로 사용하기(FROM절)
# sub-query만들었으면 반드시 테이블 알리아스 붙여라.
select *

from ( select name as 'city_name', countrycode, population
        from city
        where population >= 8000000 ) as city_pop_over_800 ;

# step 3) 다른 테이블과의 조인. 같은 테이블과의 조인을 수행하는 것 = self- join
SELECT city_pop_over_800.city_name,
		country_simple.name,
        city_pop_over_800.population
FROM ( select name as 'city_name', countrycode, population
        from city
        where population >= 8000000 ) as city_pop_over_800 

JOIN ( select code, name from country ) as country_simple 
ON city_pop_over_800.countrycode = country_simple.code;
        

# where절 subquery
# 800만 이상 도시의 국가코드, 국가이름, 대통령 이름
SELECT code, name
FROM country
WHERE code in (SELECT distinct(countrycode)
				from city
				where population >= 8000000);

SELECT distinct(countrycode)
from city
where population >= 8000000;

