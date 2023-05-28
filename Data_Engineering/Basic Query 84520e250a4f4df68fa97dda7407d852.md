# Basic Query

Query: DB에 명령하는 것(명령어) 

- **DML**(Data Manipulation Language): 데이터 조작
    - 사용빈도 제일 多
    - `SELECT`, `INSERT`, `DELETE`, `UPDATE`
- **DDL**(Data Definition Language): 데이터 정의
    - 데이터 구조에 대한 정의
    - 데이터 테이블, 베이스 만들 때 구조적인 정의를 할 때
    - `CREATE`, `ALTER`, `DROP`, `RENAME`, `TRUNCATE`
        - DROP, DELETE, TRUNCATE의 차이?
            - DROP: 테이블 아예 사라짐
            - DELETE: 데이터만 지워지고 디스크 상 공간은 그대로
            - TRUNCATE: 최초 테이블이 만들어졌던 상태로 돌아감. 데이터가 하나도 없는 상태이며 컬럼값만 남아있다.
- **DCL**(Data Control Language): 데이터 제어
    - 데이터 베이스 전체를 제어
    - 권한, 접근
    - `GRANT`(권한부여), `REVOKE`(권한 회수, 제거)

# 쿼리 순서

```sql
SELECT col1, col2, col3,… 
FROM A # 1. 데이터 몽땅 가지고 온 다음에
WHERE col1 >10 AND col2 like ‘%%’; # 2. 조건을 걸어서 데이터 걸러낸다.
```

- **SELECT** → 제일 마지막에 실행됨.
- **FROM** → 제일 먼저 실행됨.(뭘 가져와야할지 알아야하니까)


mkdir -p sql-examples/datas (-p는 하위폴더까지 만드는것)

# Query

### 1. 데이터베이스 생성 & 사용 & 확인

```sql
# database 만들기
CREATE DATABASE test;

# 2) 현존하는 **모든** 데이터 베이스 확인
SHOW DATABASES;

# 3) 데이터베이스 사용
USE test;

# 4) **지금 사용하고 있는** 선택된 데이터베이스 확인
SELECT DATABASE();
```

SELECT 를 해서 테이블조회를 하면 그 조회된 내역을 포함하는 임시 Table이 DB server에 만들어지는 것. 

### 2. 테이블 생성(CREATE)

```sql
# 5) 테이블 만들기(제약조건 없이)
CREATE TABLE user1(
	user_id INT,
    name VARCHAR(20), 
    email VARCHAR(30),
    age INT(3),
    rdate DATE
);

# 6) 테이블 생성 (제약조건 있음)
CREATE TABLE user2(
user_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20) NOT NULL, 
email VARCHAR(30) UNIQUE NOT NULL,
age INT(3) DEFAULT 30,
rdate TIMESTAMP DEFAULT now()
);
```

### 3. **테이블 변경(ALTER)**

**: (컬럼 추가_ADD, 변경_MODIFY, 삭제_DROP)**

```sql
**# 7) 현재 선택된 데이터 베이스의 문자집합 확인**
SHOW VARIABLES LIKE 'character_set_database';

**# 8) 데이터 베이스의 문자집합을 ascii로 변경**
ALTER DATABASE test CHARACTER SET = ascii;
SHOW VARIABLES LIKE 'character_set_database';

**# 9) 데이터 베이스의 문자집합을 utf8로 변경**
ALTER DATABASE test  CHARACTER SET = utf8mb4;
SHOW VARIABLES LIKE 'character_set_database';

```

- 테이블 구조 변경 ( 보통 컬럼에 대한 추가, 삭제, 변경)

```sql
**# 10) 컬럼 추가 (ADD)**
ALTER TABLE user2 ADD tmp TEXT;

# 11) 컬럼 변경 (MODIFY)
# MODIFY 뒤에 COLUMN 생략 가넝
ALTER TABLE user2 MODIFY COLUMN tmp INT(3);

# 12) 컬럼 삭제(DROP)
ALTER TABLE user2 DROP tmp;

# 테이블 삭제
DROP TABLE user1;

# 데이터베이스 삭제
DROP DATABASE test;
```

### 4. 테이블 조회

```sql
SELECT name, email, rdate
FROM user1
WHERE user_id =5;
```

⭐위에처럼 **request**를 db server에 날리면, 그에 대한 **response**로서 임시 테이블이 return된다.  우리는 **임시tb**을 response 받는 것이다. 

그냥 쿼리를 쳤더니 테이블이 나왔네? 로 이해해선 안됨. 

![Untitled 1](https://github.com/JeeyeonKim00/TIL/assets/127364024/cd2e6c40-5d33-4a90-a590-cf3cdc446913)

### 5. 데이터 삽입 (INSERT INTO- VALUES)

```sql
use test;
**INSERT INTO** user1(user_id, name, email, age, rdate)
**VALUES**(1, 'JYKim', 'brownpuka94@naver.com', 30, '2023-05-25');

**INSERT INTO** user1(user_id, name, email, age, rdate)
**VALUES** (2, 'park', 'mhso@gmail.com', 34, '2021-11-13'),
       (3, 'minho', 'mino@daum.net', 28, '2021-11-15'),
       (4, 'jiwon', 'jwon@daum.net', 27, '2021-11-11'),
       (5, 'siyeon', 'syw@snu.ac.kr', 25, '2021-11-12'),
       (6, 'taehee', 'thk@naver.com', 22, '2021-11-17');

# 특정 컬럼을 선택해서 데이터 삽입
INSERT INTO user1**(user_id, name)**
VALUES(7, 'Fine Kim');

# 컬럼명을 지정하지 않으면 전체 컬럼에 INSERT
INSERT INTO user1
VALUES(8, 'hahaha', 'jsfa@naver.com',21, now());

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
```

### 6. 중복값 제거(DISTINCT 사용)

```sql
# 중복값 제거
SELECT * FROM user1
INSERT INTO user1 values(9, 'kiki','ad@naver.com', 90, now());

INSERT INTO user1 values(10, 'hahaha','jsfa@naver.com',21,now());

SELECT * FROM user1;

SELECT DISTINCT(age) FROM user1;

```

- **DISTINCT 작동 순서**
1. age 컬럼에 해당하는 data 추출
2. 중복된 값 찾기(full scan)
3. 값 1개씩만 표시

- **특징**
    1. DISTINCT는 속도 굉장히 느림
    2. 어디서 많이 걸리냐?  작동순서 중 2번(scan)이 많이 걸린다
    3. 데이터 많아질 수록 DISTINCT하면 처리 느려짐.
    
- **그렇다면 DISTINCT를 대체할 수 있는 것?**
    - GROUP BY = 병렬처리 가능
    - 따라서 GROUP BY로 먼저 츄라이 → GROUP BY 하기 어려울 것 같은데?하면 DISTINCT 사용

### 7. WHERE 절 (filtering)

```sql
# WHERE(조건절) - Filtering
# 나이가 25세 이상인 사람들의 모든 정보를 조회하고 싶다?

SELECT *
FROM user1
WHERE age >= 25;

# 2021년 11월 15일 이전에 가입한 사람의 이메일, 이름, 나이 조회
 SELECT email, name, age, rdate
 FROM user1
 WHERE rdate < '2021-11-15';
```

*(애스터리스크)를 쓴다 =  풀스캔 한다 

→ 속도 느릴 수 있음

→ 그러니까 불러올 때 컬럼명 다 쓰는게 더 빠를 수도 있다.

### 8. 연산(AND, BETWEEN)

```sql
**# AND 연산**
 SELECT *
 FROM user1
 WHERE rdate >= '2021-11-12'
 AND rdate <= '2021-11-15';
 
 **# BETWEEN**
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

```

### 9. GROUP BY⭐⭐⭐

= ~별 (category화 시키겠다)

- 훨씬 빠름
- 목적: 집계(Aggregation)
- 평균, 합계, count 등을 구할 수 있다.
    
   ![Untitled 2](https://github.com/JeeyeonKim00/TIL/assets/127364024/bdcbd231-f4d0-45be-86fd-188f92ac6fb3)


```sql
# GROUPBY는 특정 컬럼을 기준으로 데이터를 묶은 다음
# 각종 집계 함수를 이용해 데이터를 집계(Aggregate)
# SUM, AVG, STD, STDDEV, VAR, MAX, MIN, COUNT 등등...
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

**# 연산자의 우선순위**
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

```

### 10. ORDER BY, HAVING

```sql
# 각 District별 인구수 평균, 표준편차, 최댓값, 최솟값, District 조회 후 
# 표준편차 내림차순 정렬 (ORDER BY)
# ORDER BY는 SELECT 보다 후순위에 실행됨

SELECT District, AVG(Population), STDDEV(Population) AS pop_std, MAX(Population), MIN(Population)
FROM city
GROUP BY District
ORDER BY pop_std DESC;

# HAVING 절 - GROUP BY에 대한 조건절
# WHERE는 FROM에 대한 조건절 (테이블에 대한 필터링) --> 임시테이블 만든다
# HAVING은 집계 결과에 대한 조건절(SELECT에 대한 필터링) --> 임시테이블을 만들지 않는다.

# 인구수의 총 합이 5천만 이상인 나라
SELECT CountryCode, SUM(Population) as pop_sum
FROM city
GROUP BY CountryCode
HAVING pop_sum >= 50000000
ORDER BY pop_sum DESC;
```

### 11. CEIL, ROUND, TRUNCATE

- CEIL: 실수 데이터를 올림하여 정수로 나타냄
- ROUND: 실수 데이터를 반올림
- TRUNCATE: 실수 데이터를 버림

```sql
**# 1) CEIL: 실수 데이터를 올림하여 정수로 나타내기**
SELECT CEIL(12.345); => 13

USE world;
#  국가별 언어 사용 비율을 소수 첫번째 자리에서 올림하여 정수로 나타내기
SELECT CountryCode, Language, Percentage, CEIL(Percentage)
FROM countrylanguage;

**# 2) ROUND: 실수 데이터를 반올림 할 때 사용한다.**
SELECT ROUND(12.345, 2); # 소수점 셋째 자리에서 반올림하여 둘째 자리까지 표시

SELECT CountryCode, Language, Percentage, ROUND(Percentage,0)
FROM countrylanguage;

**# 3) TRUNCATE: 실수 데이터를 버림 할 때 사용한다.**
SELECT TRUNCATE(12.345,2);

SELECT CountryCode, Language, Percentage, TRUNCATE(Percentage,0)
FROM countrylanguage;
```
