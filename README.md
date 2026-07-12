# Data Warehouse - Crimes de Chicago

## Descrição

Este projeto tem como objetivo construir um Data Warehouse utilizando a base de dados pública **Crimes - 2001 to Present**, disponibilizada pela cidade de Chicago.

O projeto foi desenvolvido utilizando PostgreSQL e dbt (Data Build Tool), aplicando conceitos de modelagem dimensional, esquema estrela, tabelas fato e dimensão, testes de qualidade dos dados e snapshots (SCD Tipo 2).

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

## Como executar o pipeline

### 1. Acessar a pasta do projeto

```bash
cd dw_chicago
```

---

### 2. Verificar a conexão com o banco

```bash
dbt debug
```

Esse comando verifica se a configuração do dbt e a conexão com o PostgreSQL estão corretas.

---

### 3. Executar os modelos

```bash
dbt run
```

Esse comando cria todos os modelos do Data Warehouse, incluindo:

- staging
- dimensões
- tabela fato

---

### 4. Executar os testes

```bash
dbt test
```

São executados os testes definidos no arquivo `schema.yml`, incluindo:

- not_null
- unique
- relationships

Esses testes garantem a qualidade e a integridade dos dados.

---

### 5. Executar os snapshots

```bash
dbt snapshot
```

Esse comando executa os snapshots implementados para as dimensões:

- dim_crime
- dim_localizacao

Os snapshots permitem manter o histórico das alterações nas dimensões, implementando o conceito de Slowly Changing Dimension (SCD Tipo 2).

---

## Qualidade dos dados

Foram implementados testes automáticos utilizando o dbt para validar:

- ausência de valores nulos nas chaves;
- unicidade das chaves substitutas;
- integridade referencial entre a tabela fato e as dimensões.

---

## Snapshots

Foram implementados snapshots utilizando o suporte nativo do dbt para preservar o histórico de alterações das dimensões:

- dim_crime
- dim_localizacao

Os snapshots utilizam a estratégia **SCD Tipo 2**, permitindo manter versões históricas dos registros.

---

## Fonte dos dados

Base pública:

**Crimes - 2001 to Present**

Portal de Dados da Cidade de Chicago.