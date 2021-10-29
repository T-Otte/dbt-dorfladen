with marktdaten as (

    select distinct
        markt
    from {{ source('dorfladen', 'STAGE_MARKTBUCHHALTUNG') }}

    union distinct

    select distinct
        markt
    from {{ source('dorfladen', 'STAGE_PREISBEWERTUNG') }}

    union distinct

    select distinct
        markt
    from {{ source('dorfladen', 'STAGE_RECHNUNG_KOPF') }}

    union distinct

    select distinct
        markt
    from {{ source('dorfladen', 'STAGE_SONST_BEWEGUNG_KOPF') }}

    union distinct

    select distinct
        markt
    from {{ source('dorfladen', 'STAGE_INVENTUR_KOPF') }}

)

select
  {{ dbt_utils.surrogate_key(['markt']) }} as markt_key, 
  markt,
  'Dorfladen' as marktname
  from marktdaten