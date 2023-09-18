use sakila;

SELECT * FROM film; #film_ie
SELECT * FROM film_category; # film_id, category_id
SELECT * FROM category; # category_id
SELECT * FROM rental;
SELECT * FROM customer; # user information
SELECT * FROM inventory; # no need to use.. maybe

-- 1. 영화 대여 이력이 가장 많은 3명의 고객에 대해, 고객 이름, 이메일, 대여 횟수를 출력하세요.


SELECT rental.customer_id, 
		COUNT(rental.customer_id) as rental_cnt, 
		concat(customer.first_name,' ', customer.last_name) as full_name, 
        customer.email
FROM rental
LEFT JOIN customer ON rental.customer_id = customer.customer_id
GROUP BY customer_id
ORDER BY rental_cnt DESC
LIMIT 3;

-- 2. "Comedy" 장르에 속한 영화의  ( category.name = 'Comedy')
-- 평점 평균이 4점 이상이고, (film.rental_rate >= 4)
-- 2005년 이후에 발행된 영화 중에서(film.release_year >= 2005), 
-- 평점이 가장 높은 5편의 영화 제목과, 평균평점을 출력하세요.
-- category 테이블은 1레벨 집합 , 
-- film과 category 사이에  film_category가 있는 것(bridge 역할) --> 테이블 배치 중요 --> bridge가 되는 테이블이 가운데에 와야함
SELECT film.title, film.rental_rate
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy'
AND film.rental_rate >=4
AND film.release_year > 2005
ORDER BY film.rental_rate DESC
LIMIT 5; 

-- 3. 2006년 이후에 가장 많이 대여된 3개 영화의 제목과 대여 횟수를 출력하세요.
-- rental/ film
-- 보통 unique key값으로 집계를 한다.
-- 정보가 있는 것만 필요할 때는 (inner)join을 쓴다. --> 근데 left join써도 상관 무 --> 그냥 방식의 차이일 뿐.
SELECT film.title,  count(film.film_id) as rental_cnt
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.rental_date >= '2006-01-01'
GROUP BY film.film_id
ORDER BY rental_cnt DESC
LIMIT 3;  

-- 4. 2005년 이후에 release_year 영화 중에서, 대여한 횟수가 가장 많은 영화의 제목과 대여 횟수를 출력하세요. (inventory 활용)
-- 최고 대여 횟수 중에 max()쓰려면 서브쿼리 해야함. 
SELECT title, count(rental.rental_id) as cnt
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id= film.film_id
WHERE film.release_year > 2005
GROUP BY film.film_id
ORDER BY cnt DESC
LIMIT 1
;


-- 5. 영화 대여 횟수가 가장 많은 고객 3명의 이름, 이메일, 대여 횟수를 출력하세요.

-- 6. "Documentary"와 "Music" 장르에 해당되는 영화 중에서, 2005년 이후에 발행된 영화 제목과 발행 연도, 장르명을 출력하세요.
# subquery에서도 IN 사용합니다.
SELECT title, release_year, name 
FROM film
LEFT JOIN film_category ON film_category.film_id = film.film_id
LEFT JOIN category ON film_category.category_id = category.category_id
WHERE category.name IN ('Documentary','Music')
AND release_year >= 2005;


-- 7. "Comedy" 장르에 해당되는 영화 중에서, 대여 횟수가 가장 많은 영화 제목과 대여 횟수를 출력하세요.
-- 메인은 '대여횟수' 따라서 from 절에 와야하는 것은 rental 테이블임.

SELECT title, COUNT(film.film_id) as cnt
FROM rental
LEFT JOIN inventory ON rental.inventory_id= inventory.inventory_id
LEFT JOIN film_category ON inventory.film_id = film_category.film_id
LEFT JOIN category ON category.category_id = film_category.category_id
LEFT JOIN film ON film.film_id = film_category.film_id
WHERE name = 'Comedy'
GROUP BY film.film_id
ORDER BY cnt DESC
LIMIT 1;

