SELECT DISTINCT

    ROW_NUMBER() OVER (
        ORDER BY bloco
    ) AS sk_localizacao,

    bloco,

    descricao_local,

    ward,

    area_comunidade,

    latitude,

    longitude

FROM {{ ref('stg_crimes') }}