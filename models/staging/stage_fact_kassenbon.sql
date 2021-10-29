select
k.Datum
,p.Artikelnummer
,k.Markt
,k.Zeit
,k.Kasse
,k.Transaktion
,p.LFTPosNr
,p.PLUNummer
,p.Menge
,cast(replace(p.VKPreis,',','.') as Decimal(15,2)) VKPreis
,cast(replace(k.Umsatz,',','.') as Decimal(15,2)) Umsatz
,p.RabWertPos
,p.RabWertBon
,k.Bonnummer
,k.KUNDENNUMMER
from {{ source('dorfladen', 'STAGE_KASSENBON_POSITION') }} p
inner join
{{ source('dorfladen', 'STAGE_KASSENBON_KOPF') }} k
on k.transaktion = p.transaktion
inner join
{{ source('dorfladen', 'STAGE_KASSENBON_ZAHLUNGSMITTEL') }} z
on p.transaktion = z.transaktion