SELECT

    s.id_origem,

    s.numero_caso,

    dt.sk_tempo,

    dc.sk_crime,

    dl.sk_localizacao,

    dj.sk_jurisdicao,

    doo.sk_ocorrencia,

    1 AS quantidade_ocorrencia,

    CASE
        WHEN s.prisao_efetuada THEN 1
        ELSE 0
    END AS teve_prisao

FROM {{ ref('stg_crimes') }} s

JOIN {{ ref('dim_tempo') }} dt
    ON DATE(s.data_ocorrencia) = dt.data_completa

JOIN {{ ref('dim_crime') }} dc
    ON s.iucr = dc.iucr
   AND s.tipo_primario = dc.tipo_primario
   AND s.descricao = dc.descricao
   AND s.codigo_fbi = dc.codigo_fbi

JOIN {{ ref('dim_localizacao') }} dl
    ON s.bloco = dl.bloco
   AND s.descricao_local = dl.descricao_local
   AND s.ward = dl.ward
   AND s.area_comunidade = dl.area_comunidade
   AND s.latitude = dl.latitude
   AND s.longitude = dl.longitude

JOIN {{ ref('dim_jurisdicao') }} dj
    ON s.beat = dj.beat
   AND s.distrito = dj.distrito

JOIN {{ ref('dim_ocorrencia') }} doo
    ON s.prisao_efetuada = doo.prisao_efetuada
   AND s.crime_domestico = doo.crime_domestico