select
--lieferanten_key
--datum_key
--artikel_key
--markt_key
--belegnummer_key
k.lieferantennr
,k.datum_wareneingang
,p.artikelnummer
,k.markt
,k.belegnummer
,p.we_menge
,p.ges_ek_rechnung
,p.ges_ek_liste
,p.ges_ek_netto
,k.auftragsnr
,k.we_nummer
,k.RabAuftrKopf
from {{ source('dorfladen', 'STAGE_WARENEINGANG_KOPF') }} k
inner join
{{ source('dorfladen', 'STAGE_WARENEINGANG_POSITION') }} p
on k.auftragsnr = p.auftragsnr