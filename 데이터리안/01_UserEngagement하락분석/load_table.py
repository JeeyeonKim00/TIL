from sqlalchemy import create_engine
import pandas as pd

def create_connection(host, user, password, database):
    engine = create_engine(f'mysql+mysqlconnector://{user}:{password}@{host}/{database}')
    return engine

def load_csv(path, tb_name):
    engine = create_connection('localhost','CLOUDY','1234','yammers')
    df = pd.read_csv(path)
    df.to_sql(name= tb_name,
                con = engine,
                if_exists = 'replace',
                index = False)    