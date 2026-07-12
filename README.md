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
## Como executar o pipeline

### 1. Acessar a pasta do projeto

```bash
cd dw_chicago
```

### 2. Verificar a conexão com o banco

```bash
dbt debug
```
Esse comando verifica se a configuração do dbt e a conexão com o PostgreSQL estão corretas.

### 3. Executar os modelos

```bash
dbt run
```

Esse comando cria todos os modelos do Data Warehouse, incluindo:

- staging
- dimensões
- tabela fato

### 4. Executar os testes

```bash
dbt test
```

São executados os testes definidos no arquivo `schema.yml`, incluindo:

- not_null
- unique
- relationships

Esses testes garantem a qualidade e a integridade dos dados.

### 5. Executar os snapshots

```bash
dbt snapshot
```

Esse comando executa os snapshots implementados para as dimensões:

- dim_crime
- dim_localizacao

Os snapshots permitem manter o histórico das alterações nas dimensões, implementando o conceito de Slowly Changing Dimension (SCD Tipo 2).


## Qualidade dos dados

Foram implementados testes automáticos utilizando o dbt para validar:

- ausência de valores nulos nas chaves;
- unicidade das chaves substitutas;
- integridade referencial entre a tabela fato e as dimensões.

## Snapshots

Foram implementados snapshots utilizando o suporte nativo do dbt para preservar o histórico de alterações das dimensões:

- dim_crime
- dim_localizacao

Os snapshots utilizam a estratégia **SCD Tipo 2**, permitindo manter versões históricas dos registros.


## Fonte dos dados

Base pública:

**Crimes - 2001 to Present**

Portal de Dados da Cidade de Chicago.