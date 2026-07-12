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
PROJETO_DW/
├── data/
│   └── Crimes.csv                    # Base de dados bruta (CSV)
├── dw_chicago/                       # Projeto dbt 
│   ├── analyses/                     
│   ├── logs/                         
│   ├── macros/                       
│   ├── models/                       # Modelos de dados 
│   │   ├── dimensions/               # Tabelas dimensão 
│   │   ├── facts/                    # Tabela fato 
│   │   ├── staging/                  # Camada de staging 
│   │   └── schema.yml                # Configurações e testes dos modelos
│   ├── seeds/                        
│   ├── snapshots/                    # Estratégias de Slowing Changing Dimensions (SCD)
│   │   ├── snapshot_dim_crime.sql
│   │   └── snapshot_dim_localizacao.sql
│   ├── target/                       
│   └── tests/                        # Testes de qualidade de dados personalizados
├── scripts/                          # Scripts Python de suporte/ETL
│   ├── analyze_csv.py                # Análise exploratória dos dados
│   ├── config.py                     # Configurações e variáveis de ambiente
│   ├── create_database.py            # Criação do banco de dados
│   ├── create_schemas.py             # Criação dos schemas no banco
│   ├── database.py                   # Conexão com o banco de dados
│   └── import_csv.py                 # Script para ingestão do CSV no banco
├── .gitignore                        # Arquivos ignorados pelo Git
├── dbt_project.yml                   # Configuração principal do projeto dbt
└── README.md                         # Documentação do projeto
```

---

## Passo 1: Carga dos dados do sistema

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

## Passo 2: Criação e carga do modelo dimensional

