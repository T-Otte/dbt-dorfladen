select
    {{ dbt_utils.surrogate_key(['lieferantennr']) }} as lieferant_key,
    lieferantennr,
    lieferantenbez
  from {{ref('stage_dim_lieferant')}}