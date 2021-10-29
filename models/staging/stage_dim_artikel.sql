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

    select distinct
    artikelnummer
    ,artikelbezeichnung
    ,warengruppe
    ,mwst_satz
    ,bestandsfuehrung
    from {{ source('dorfladen', 'STAGE_KASSENBON_POSITION') }}

    union all

    select
    artikelnummer
    ,artikelbezeichnung
    ,warengruppe
    ,mwst_satz
    ,bestandsfuehrung
    from {{ source('dorfladen', 'STAGE_INVENTUR_ART') }}
)