select
f.datum --datum_key
--artikel.dbt_scd_id as artikel_key
,artikel.artikel_Key
,markt.markt_key
,zeit.Zeit_key
,f.Kasse
,f.Transaktion
,f.LFTPosNr
,f.PLUNummer
,f.Menge
,f.VKPreis
,f.Umsatz
,f.RabWertPos
,f.RabWertBon
,f.Bonnummer
,f.KUNDENNUMMER
from {{ ref('stage_fact_kassenbon') }} f
left join {{ ref('dim_artikel') }} artikel on f.Artikelnummer = artikel.Artikelnummer-- and artikel.dbt_valid_to is null
left join {{ ref('dim_kalender') }} kalender on f.datum = kalender.datum
left join {{ ref('dim_markt') }} markt on f.markt = markt.markt
left join {{ ref('dim_zeit') }} zeit on f.zeit = zeit.zeit