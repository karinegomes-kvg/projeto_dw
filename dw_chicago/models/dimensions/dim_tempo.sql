{{ config(materialized='table') }}

WITH datas AS (

    SELECT DISTINCT
        data_ocorrencia::date AS data_completa
    FROM {{ ref('stg_crimes') }}

)

SELECT
    ROW_NUMBER() OVER (ORDER BY data_completa) AS sk_tempo,
    data_completa,

    EXTRACT(YEAR FROM data_completa) AS ano,
    EXTRACT(MONTH FROM data_completa) AS mes,
    EXTRACT(DAY FROM data_completa) AS dia,
    EXTRACT(QUARTER FROM data_completa) AS trimestre

FROM datas