{% snapshot snapshot_dim_crime %}

{{
    config(
        target_schema='snapshots',
        unique_key='sk_crime',

        strategy='check',

        check_cols=[
            'iucr',
            'tipo_primario',
            'descricao',
            'codigo_fbi'
        ]
    )
}}

SELECT *
FROM {{ ref('dim_crime') }}

{% endsnapshot %}