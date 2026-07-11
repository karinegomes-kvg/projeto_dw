SELECT DISTINCT

    ROW_NUMBER() OVER (ORDER BY DATE(data_ocorrencia)) AS sk_tempo,

    DATE(data_ocorrencia) AS data_completa,

    EXTRACT(YEAR FROM data_ocorrencia) AS ano,

    EXTRACT(MONTH FROM data_ocorrencia) AS mes,

    EXTRACT(DAY FROM data_ocorrencia) AS dia,

    TO_CHAR(data_ocorrencia, 'Day') AS dia_semana,

    EXTRACT(QUARTER FROM data_ocorrencia) AS trimestre

FROM {{ ref('stg_crimes') }}

ORDER BY data_completa