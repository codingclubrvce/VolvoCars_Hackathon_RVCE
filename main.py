from google.cloud.sql.connector import Connector
import pymysql
import sqlalchemy

# initialize Connector object
connector = Connector()

# function to return the database connection
def getconn() -> pymysql.connections.Connection:
    conn: pymysql.connections.Connection = connector.connect(
        "splendid-sonar-428607-b2:asia-south1:volvo",
        "pymysql",
        user="root",
        password="volvo2024"
    )
    return conn

# create connection pool
pool = sqlalchemy.create_engine(
    "mysql+pymysql://",
    creator=getconn,
)

with pool.connect() as conn:
    result = conn.execute(sqlalchemy.text("SHOW DATABASES"))

    for row in result:
        print(row)