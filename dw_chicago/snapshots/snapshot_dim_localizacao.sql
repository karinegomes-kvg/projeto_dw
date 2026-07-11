{% snapshot snapshot_dim_localizacao %}

{{
    config(
        target_schema='snapshots',
        unique_key='sk_localizacao',

        strategy='check',

        check_cols=[
            'bloco',
            'descricao_local',
            'ward',
            'area_comunidade',
            'latitude',
            'longitude'
        ]
    )
}}

SELECT *
FROM {{ ref('dim_localizacao') }}

{% endsnapshot %}