import mysql.connector
from mysql.connector import connect,Error
import pandas as pd

# mysql 연결 함수
def create_mysql_connection(host, user, password, database):
    try:
        connection = connect(
            host = host,
            user = user,
            password = password,
            database = database
        )

        if connection.is_connected():
            print(f'Connected to MySQL server : {host}')
        return connection
    except Error as e:
        print(f'Error: {e}')
        return None


# mysql 연결 종료 함수
def close_connection(connection):
    if connection:
        connection.close()
        print('Connection to MySQL closed.')

