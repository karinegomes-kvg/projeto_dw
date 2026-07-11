SELECT
    "ID" AS id_origem,
    "Case Number" AS numero_caso,
    "Date" AS data_ocorrencia,
    "IUCR" AS iucr,
    "Primary Type" AS tipo_primario,
    "Description" AS descricao,
    "Location Description" AS descricao_local,
    "Arrest" AS prisao_efetuada,
    "Domestic" AS crime_domestico,
    "Beat" AS beat,
    "District" AS distrito,
    "Ward" AS ward,
    "Community Area" AS area_comunidade,
    "FBI Code" AS codigo_fbi,
    "Block" AS bloco,
    "Latitude" AS latitude,
    "Longitude" AS longitude
FROM raw.crimes