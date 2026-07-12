{{ config(materialized='table') }}

WITH base AS (

    SELECT *
    FROM {{ ref('stg_crimes') }}

)

SELECT

    -- surrogate key da fato
    ROW_NUMBER() OVER () AS sk_fato,

    -- chaves estrangeiras
    crime.sk_crime,
    loc.sk_localizacao,
    jur.sk_jurisdicao,
    ocorr.sk_ocorrencia,
    tempo.sk_tempo,

    -- medidas
    1 AS quantidade_ocorrencias,

    -- atributos opcionais (degenerate)
    base.numero_caso

FROM base

-- JOIN CRIME
LEFT JOIN {{ ref('dim_crime') }} crime
    ON base.iucr = crime.iucr
   AND base.tipo_primario = crime.tipo_primario

-- JOIN LOCALIZAÇÃO
LEFT JOIN {{ ref('dim_localizacao') }} loc
    ON base.bloco = loc.bloco
   AND base.descricao_local = loc.descricao_local
   AND base.ward = loc.ward
   AND base.area_comunidade = loc.area_comunidade

-- JOIN JURISDIÇÃO
LEFT JOIN {{ ref('dim_jurisdicao') }} jur
    ON base.beat = jur.beat
   AND base.distrito = jur.distrito

-- JOIN OCORRÊNCIA
LEFT JOIN {{ ref('dim_ocorrencia') }} ocorr
    ON base.prisao_efetuada = ocorr.prisao_efetuada
   AND base.crime_domestico = ocorr.crime_domestico

-- JOIN TEMPO
LEFT JOIN {{ ref('dim_tempo') }} tempo
    ON base.data_ocorrencia::date = tempo.data_completa