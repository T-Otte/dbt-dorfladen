{% snapshot dim_artikel %}

    {{
        config(
          target_schema=generate_schema_name('snapshots'),
          strategy='check',
          unique_key='artikelnummer',
          check_cols='all'
        )
    }}

    select * from {{ ref('stage_dim_artikel') }}

{% endsnapshot %}