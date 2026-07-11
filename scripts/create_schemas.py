from database import get_connection

SCHEMAS = ["raw", "staging", "dw"]


def create_schemas():
    conn = get_connection()
    cursor = conn.cursor()

    try:
        for schema in SCHEMAS:
            cursor.execute(f"CREATE SCHEMA IF NOT EXISTS {schema};")
            print(f"Schema '{schema}' criado/verificado.")

        conn.commit()

    except Exception as e:
        conn.rollback()
        print("Erro:", e)

    finally:
        cursor.close()
        conn.close()


if __name__ == "__main__":
    create_schemas()