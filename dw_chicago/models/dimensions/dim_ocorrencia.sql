{{ config(materialized='table') }}

WITH base AS (

    SELECT DISTINCT
        prisao_efetuada,
        crime_domestico
    FROM {{ ref('stg_crimes') }}

)

SELECT
    ROW_NUMBER() OVER () AS sk_ocorrencia,
    prisao_efetuada,
    crime_domestico
FROM base