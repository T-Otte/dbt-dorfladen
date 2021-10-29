{{
    config(
        materialized='incremental'
    )
}}

select
lieferant_key
--,datum_key
,artikel.artikel_Key
,markt_key
,belegnummer_key
,f.datum_wareneingang
,f.we_menge
,f.ges_ek_rechnung
,f.ges_ek_liste
,f.ges_ek_netto
,case when f.auftragsnr = 0 then lag(f.auftragsnr) over (order by f.datum_wareneingang, f.we_nummer) else f.auftragsnr end as auftragsnr
,f.we_nummer
,f.RabAuftrKopf
from {{ ref('stage_fact_wareneingang') }} f
left join {{ ref('dim_artikel') }} artikel on f.artikelnummer = artikel.artikelnummer-- and artikel.dbt_valid_to is null
left join {{ ref('dim_lieferant') }} lieferant on f.lieferantennr = lieferant.lieferantennr
left join {{ ref('dim_kalender') }} kalender on f.datum_wareneingang = kalender.datum
left join {{ ref('dim_markt') }} markt on f.markt = markt.markt
left join {{ ref('dim_belegnummer') }} belegnummer on f.belegnummer = belegnummer.belegnummer

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where f.datum_wareneingang > (select max(datum_wareneingang) from {{ this }})

{% endif %}