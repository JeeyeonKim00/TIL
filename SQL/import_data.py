import pandas as pd
from sqlalchemy import create_engine

# db_connection_str = 'mysql+pymysql://multi:Campus123!@localhost/sql_analyze'
# db_connection = create_engine(db_connection_str)

# temper_df = pd.read_csv("./datas/ta_20230525211223.csv", header=None)
# temper_df.columns=["STD_DE", "AREA_CD", "AVG_TEMPER", "MIN_TEMPER", "MAX_TEMPER"]
# temper_df.to_sql(
#     name="TB_TEMPER_DATA",
#     con=db_connection,
#     index=False,
#     if_exists="append"
# )


db_connection_str = 'mysql+pymysql://test:kjy030512!@localhost/sql_analyze'
db_connection = create_engine(db_connection_str)

pop_table = pd.read_sql("SELECT * FROM TB_POPLTN_DATA", con=db_connection)
print(list(pop_table.columns))


pop_df = pd.read_csv("./datas/202211_202304_population.csv", header=None)
pop_df.columns=list(pop_table.columns)
pop_df.to_sql(
    name="TB_POPLTN_DATA",
    con=db_connection,
    index=False,
    if_exists="replace"
)
db_connection.dispose()

##########################################


import pandas as pd
from sqlalchemy import create_engine

db_connection_str = 'mysql+pymysql://root:kjy030512!@localhost:3306/test'
# db_connection_str = 'mysql+pymysql://multi:Campus123!@localhost/sql_analyze'
db_connection = create_engine(db_connection_str)

pop_table = pd.read_sql("SELECT * FROM TB_PBTRNSP_DATA", con=db_connection)
print(list(pop_table.columns))


pop_df = pd.read_csv("./datas/subway_202304.csv", header=None)
pop_df.columns=list(pop_table.columns)
pop_df.to_sql(
    name="TB_PBTRNSP_DATA",
    con=db_connection,
    index=False,
    if_exists="replace"
)

db_connection.dispose()
