from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from database import get_connection
from config import DATABASE


def create_database():

    conn = get_connection("postgres")
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

    cursor = conn.cursor()

    cursor.execute(
        "SELECT 1 FROM pg_database WHERE datname = %s;",
        (DATABASE,)
    )

    if cursor.fetchone():
        print(f"Banco '{DATABASE}' já existe.")
    else:
        cursor.execute(f'CREATE DATABASE "{DATABASE}";')
        print(f"Banco '{DATABASE}' criado com sucesso!")

    cursor.close()
    conn.close()


if __name__ == "__main__":
    create_database()