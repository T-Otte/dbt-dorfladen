with belegnummern as (
    select distinct belegnummer, zentaufnr from {{ source('dorfladen', 'STAGE_WARENEINGANG_KOPF') }})

select
    {{ dbt_utils.surrogate_key(['belegnummer','zentaufnr']) }} as belegnummer_key,
    belegnummer,
    zentaufnr as ZentraleAuftragsNr
from belegnummern



