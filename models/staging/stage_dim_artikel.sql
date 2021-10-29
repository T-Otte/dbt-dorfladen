{{ config(
    tags=["Wareneingang"]
) }}
select distinct 
artikelnummer
,artikelbezeichnung
,warengruppe
,mwst_satz
,bestandsfuehrung
from
(
    select
     artikelnummer
    ,artikelbezeichnung
    ,warengruppe
    ,mwst_satz
    ,bestandsfuehrung
    from {{ source('dorfladen', 'STAGE_WARENEINGANG_POSITION') }}

    union all

    select
    artikelnummer
    ,ARTBEZLANG as artikelbezeichnung
    ,warengruppe
    ,MWST_PROZ / 100 as mwst_satz
    ,BESTFUE as bestandsfuehrung
    from {{ source('dorfladen', 'STAGE_KASSENBON_POSITION') }} k
    where datum = (select max(datum) from {{ source('dorfladen', 'STAGE_KASSENBON_POSITION') }} k2 where k.artikelnummer = k2.artikelnummer )

    union all

    select
    artikelnummer
    ,artikelbezeichnung
    ,warengruppe
    ,mwst_satz
    ,bestandsfuehrung
    from {{ source('dorfladen', 'STAGE_INVENTUR_ART') }}
)
where mwst_satz <> 0
