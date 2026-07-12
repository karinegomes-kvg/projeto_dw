WITH crimes AS (

    SELECT DISTINCT
        iucr,
        tipo_primario,
        descricao,
        codigo_fbi

    FROM {{ ref('stg_crimes') }}

)

SELECT

    ROW_NUMBER() OVER (
        ORDER BY iucr, tipo_primario
    ) AS sk_crime,

    iucr,
    tipo_primario,
    descricao,
    codigo_fbi

FROM crimes