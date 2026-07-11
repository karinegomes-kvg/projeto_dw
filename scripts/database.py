import psycopg2
from config import HOST, PORT, USER, PASSWORD, DATABASE


def get_connection(database=DATABASE):
    return psycopg2.connect(
        host=HOST,
        port=PORT,
        user=USER,
        password=PASSWORD,
        dbname=database
    )