select  
{{ dbt_utils.surrogate_key(['artikelnummer']) }} as artikel_key
,artikelnummer
,artikelbezeichnung
,warengruppe
,mwst_satz
,bestandsfuehrung
 from {{ ref('stage_dim_artikel') }}