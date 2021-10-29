select
Datum_Aufnahme
,artikel.dbt_scd_id Artikel_Key
,markt.markt_key
,Verbuchungszaehler
,Menge
,Sollbestand
,Diff_Menge
,VK_Diff
,VK_Wert
,EK_Diff
,EK_Wert
from {{ ref('stage_fact_inventur') }} f
left join {{ ref('dim_artikel') }} artikel on f.Artikelnummer = artikel.Artikelnummer and artikel.dbt_valid_to is null
left join {{ ref('dim_kalender') }} kalender on f.datum_aufnahme = kalender.datum
left join {{ ref('dim_markt') }} markt on f.markt = markt.markt