SELECT DISTINCT

    ROW_NUMBER() OVER (
        ORDER BY prisao_efetuada, crime_domestico
    ) AS sk_ocorrencia,

    prisao_efetuada,

    crime_domestico

FROM {{ ref('stg_crimes') }}