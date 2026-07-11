import pandas as pd

# Caminho do arquivo CSV
CSV_PATH = "../data/Crimes.csv"

# Lê o arquivo
df = pd.read_csv(CSV_PATH)

print("=" * 60)
print("INFORMAÇÕES GERAIS")
print("=" * 60)

print(f"Número de linhas: {df.shape[0]:,}")
print(f"Número de colunas: {df.shape[1]}")

print("\nColunas:")
for coluna in df.columns:
    print(f" - {coluna}")

print("\n" + "=" * 60)
print("TIPOS DAS COLUNAS")
print("=" * 60)

print(df.dtypes)

print("\n" + "=" * 60)
print("VALORES NULOS")
print("=" * 60)

print(df.isnull().sum())

print("\n" + "=" * 60)
print("PRIMEIRAS LINHAS")
print("=" * 60)

print(df.head())