SELECT DISTINCT

    ROW_NUMBER() OVER (
        ORDER BY distrito, beat
    ) AS sk_jurisdicao,

    beat,

    distrito

FROM {{ ref('stg_crimes') }}