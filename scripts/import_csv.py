import pandas as pd
from sqlalchemy import create_engine
from config import HOST, PORT, USER, PASSWORD, DATABASE

CSV_PATH = "../data/Crimes.csv"

engine = create_engine(
    f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}"
)

try:
    for i, chunk in enumerate(pd.read_csv(CSV_PATH, chunksize=50000)):

        print(f"Importando lote {i + 1}...")

        # Datas
        chunk["Date"] = pd.to_datetime(
            chunk["Date"],
            format="%m/%d/%Y %I:%M:%S %p",
            errors="coerce"
        )

        chunk["Updated On"] = pd.to_datetime(
            chunk["Updated On"],
            format="%m/%d/%Y %I:%M:%S %p",
            errors="coerce"
        )

        # Latitude e Longitude
        for coluna in ["Latitude", "Longitude"]:
            chunk[coluna] = (
                chunk[coluna]
                .astype(str)
                .str.replace(",", ".", regex=False)
            )

            chunk[coluna] = pd.to_numeric(
                chunk[coluna],
                errors="coerce"
            )

        chunk.to_sql(
            name="crimes",
            con=engine,
            schema="raw",
            if_exists="append" if i > 0 else "replace",
            index=False
        )

    print("\nImportação concluída com sucesso!")

except Exception as e:
    print(f"\nErro no lote {i + 1}:")
    print(e)