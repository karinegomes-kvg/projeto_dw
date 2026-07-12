{{ config(materialized='table') }}

WITH base AS (
    SELECT DISTINCT
        beat,
        distrito
    FROM {{ ref('stg_crimes') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY beat) AS sk_jurisdicao,
    beat,
    distrito
FROM base