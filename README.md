# Data Warehouse - Crimes de Chicago

## Descrição

Este projeto tem como objetivo construir um Data Warehouse utilizando a base de dados pública **Crimes - 2001 to Present**, disponibilizada pela cidade de Chicago.

O projeto foi desenvolvido utilizando PostgreSQL e dbt (Data Build Tool), aplicando conceitos de modelagem dimensional, esquema estrela, tabelas fato e dimensão, testes de qualidade dos dados e snapshots (SCD Tipo 2).

---

## Pré-requisitos

Antes de executar o projeto, é necessário ter instalado:

- Python 3.11 ou superior
- PostgreSQL
- pgAdmin (opcional, para administração do banco)
- Bibliotecas Python:
  - pandas
  - sqlalchemy
  - psycopg2-binary

Instale as bibliotecas com:

```bash
pip install pandas sqlalchemy psycopg2-binary
```

---

## Tecnologias utilizadas
- Python 3.11
- PostgreSQL
- dbt Core
- dbt-postgres
- Pandas
- SQL

---

## Estrutura do projeto

```
dw_chicago/
│
├── models/
│   ├── staging/
│   │   └── stg_crimes.sql
│   │
│   ├── dimensions/
│   │   ├── dim_tempo.sql
│   │   ├── dim_crime.sql
│   │   ├── dim_localizacao.sql
│   │   ├── dim_jurisdicao.sql
│   │   └── dim_ocorrencia.sql
│   │
│   ├── facts/
│   │   └── fato_ocorrencias.sql
│   │
│   └── schema.yml
│
├── snapshots/
│   ├── snapshot_dim_crime.sql
│   └── snapshot_dim_localizacao.sql
│
├── dbt_project.yml
└── README.md
```

---

## Modelo Dimensional

O Data Warehouse foi modelado utilizando o esquema estrela, composto por:

### Tabela fato

- fato_ocorrencias

### Tabelas dimensão

- dim_tempo
- dim_crime
- dim_localizacao
- dim_jurisdicao
- dim_ocorrencia

---

## Passo 1
## Configuração do banco

Edite o arquivo `config.py` com as informações de conexão do PostgreSQL:

```python
HOST = "localhost"
PORT = "5432"
USER = "postgres"
PASSWORD = "sua_senha"
DATABASE = "dw_chicago"
```
## 1. Criar o banco de dados

Execute:

```bash
python create_database.py
```
Esse script cria o banco `dw_chicago`.

## 2. Criar os schemas

Execute:

```bash
python create_schemas.py
```

Serão criados os schemas utilizados no projeto:

- raw
- dw

## 3. Importar os dados

Coloque o arquivo `Crimes.csv` na pasta:

```
data/
```

Em seguida execute:

```bash
python import_csv.py
```

Durante a importação, o script realiza automaticamente:
- conversão das colunas `Date` e `Updated On` para o tipo Data/Hora;
- conversão das colunas `Latitude` e `Longitude` para valores numéricos;
- importação em lotes de 50.000 registros para reduzir o consumo de memória.
Ao final, todos os registros serão armazenados na tabela:

```
raw.crimes
```

---