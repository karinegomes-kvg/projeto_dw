{{ config(materialized='table') }}

WITH base AS (

    SELECT DISTINCT
        bloco,
        descricao_local,
        ward,
        area_comunidade
    FROM {{ ref('stg_crimes') }}

)

SELECT
    ROW_NUMBER() OVER (ORDER BY bloco, ward) AS sk_localizacao,
    bloco,
    descricao_local,
    ward,
    area_comunidade
FROM base