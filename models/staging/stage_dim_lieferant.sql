with lieferanten as (

    select distinct
        lieferantennr,
        lieferantenbez
    from {{ source('dorfladen', 'STAGE_SONST_BEWEGUNG_KOPF') }}

    union distinct

    select distinct
        lieferantennr,
        lieferantenbez
    from {{ source('dorfladen', 'STAGE_WARENEINGANG_KOPF') }}



)

select * from lieferanten