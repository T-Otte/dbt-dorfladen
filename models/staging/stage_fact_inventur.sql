select
k.Datum_Aufnahme
,a.Artikelnummer
,k.Markt
,a.Verbuchungszaehler
,a.Menge_Art as Menge
,a.Sollbestand_art as Sollbestand
,a.Diff_Menge_art as Diff_Menge
,a.VK_Diff_Art as VK_Diff
,a.VK_Wert_Art as VK_Wert
,a.EK_Diff_Art as EK_Diff
,a.EK_Wert_Art as EK_Wert
from {{ source('dorfladen', 'STAGE_INVENTUR_POSITION') }} p
inner join
{{ source('dorfladen', 'STAGE_INVENTUR_KOPF') }} k
on k.Verbuchungszaehler = p.Verbuchungszaehler
inner join
{{ source('dorfladen', 'STAGE_INVENTUR_ART') }} a
on p.Verbuchungszaehler = a.Verbuchungszaehler