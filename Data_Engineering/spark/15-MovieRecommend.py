# 작업 시작 전, 인터프리터를 3.8.16(spark_env)로 변경하세요
from pyspark.sql import SparkSession
from pyspark.ml.recommendation import ALS
from pyspark.ml.evaluation import RegressionEvaluator
from pyspark.sql.types import IntegerType

# 데이터가 매우 큰 경우, 강제로 사용할 메모리의 용량을 설정
MAX_MEMORY = '4g'

spark = SparkSession.builder.appName('movie-recommendation')\
        .config('spark.executor.memory', MAX_MEMORY)\
        .config('spark.driver.memory', MAX_MEMORY)\
        .getOrCreate()

filepath = '/home/ubuntu/working/spark-examples/data/MovieLens/ratings.csv'
ratings_df = spark.read.csv(f'file://{filepath}',
                            inferSchema = True,
                            header = True)

ratings_df.show(5)
# # timestamp는 빼고 선택
ratings_df = ratings_df.select(['userId','movieId','rating'])

# # ratings_df.printSchema()

# # 통계정보 확인
ratings_df.select('rating').describe().show()

# train_df, test_df 데이터 세트 분리
train_df, test_df = ratings_df.randomSplit([0.8,0.2], seed=42)

# train, test set shape확인
# train_df.count(), len(train_df.columns)
# test_df.count(), len(test_df.columns)

# 모델 불러오기
als = ALS(
    maxIter=5, # 최적화는 5번만
    regParam=0.1, # learning_rate. 최적화가 경사하강법과 유사하기 땜문

    userCol="userId", # 사용자 정보
    itemCol='movieId', # 아이템 컬럼(여기선 영화)
    ratingCol='rating', # 평점 컬럼

    coldStartStrategy='drop' # 학습하지 못한 데이터에 대한 처리(삭제,drop)
) # transformer


# 모델 훈련
als_model = als.fit(train_df)

# 훈련 전엔 transformer, 훈련하고 나서는 model
print(type(als))
print(type(als_model))

# 예측(test_df) - transform
# 이 user가 이 영화에 평점 몇 점을 줄거야!
predictions = als_model.transform(test_df)
predictions.show() # Actions

# 평가 (회귀평가)
evaluator = RegressionEvaluator(
    metricName = 'rmse',
    labelCol= 'rating',
    predictionCol='prediction'
) # predictions.show()했을 때 보였던 rating-prediction 사이의 rmse 구하는 것


# 예측된 데이터프레임 넣어주기
rmse = evaluator.evaluate(predictions)
print(f'rmse: {rmse}')

# 추천하기
# 1. 각 user에게 top3 아이템을 추천
#        [{영화 id, 예상 평점}, {영화 id, 예상 평점}, {영화 id, 예상 평점}]

# als_model.recommendForAllUsers(3).show()

# 2. 각 영화에 어울리는 top3 유저를 추천
# als_model.recommendForAllItems(3).show()


# 3. 
# 사용자 목록을 만들어서 추천
user_list = [276, 53, 393]
users_df = spark.createDataFrame(user_list, IntegerType()).toDF('userId')

user_recommend = als_model.recommendForUserSubset(users_df, 5) # users_df에 있는 user들에게만 5개 추천?
user_recommend.show()

# 특정 user를 위한 추천
movies_list = user_recommend.filter('userId = 393').select('recommendations')
# movies_list.show()

# 데이터프레임으로 조회해서 가져오는 것이 아닌, 실제 데이터를 가져와야 하기 때문에
        # collect()같은 것들을 사용하는 것이 좋다.
movies_list = movies_list.select('recommendations').collect()[0].recommendations
# movies_list.select('recommendations').first()

print(movies_list)


recommend_df = spark.createDataFrame(movies_list)
recommend_df.show()




movie_filepath = '/home/ubuntu/working/spark-examples/data/MovieLens/movies.csv'
movies_df = spark.read.csv(f'file://{movie_filepath}',
                        inferSchema = True,
                        header=True)

# SQL 활용을 위해 TempView에 등록
recommend_df.createOrReplaceTempView('rec')
movies_df.createOrReplaceTempView('movies')

query = """
select *
from movies
join rec on movies.movieId = rec.movieId
oreder by rating desc"""

spark.sql(query).show()

## 여기 뭔가 잘못된듯.?? 다시해봐라