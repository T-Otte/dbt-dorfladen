with stunden as (
  {% for i in range(24) %}
    select {{ '%02d' % i }} as stunde {% if not loop.last %} union all {% endif %}
  {% endfor %}
)
,minuten as (
  {% for i in range(60) %}
    select {{ '%02d' % i }} as minute {% if not loop.last %} union all {% endif %}
  {% endfor %}
)
, sekunden as (
  {% for i in range(60) %}
    select {{ '%02d' % i }} as sekunde  {% if not loop.last %} union all {% endif %}
  {% endfor %}
)


select {{ dbt_utils.surrogate_key(['stunde','minute','sekunde']) }} as zeit_key 
,stunde||':'||minute||':'||sekunde as zeit
,stunde
,minute
,sekunde
,tageszeit
from
(
    select
    lpad(stunde,2,'') as stunde
    ,lpad(minute,2,'') as minute
    ,lpad(sekunde,2,'') as sekunde
    ,case when stunde >= 6 and stunde <= 10 then 'Morgens'
          when stunde < 12 then 'Vormittags'
          when stunde < 15 then 'Mittags'
          when stunde < 18 then 'Nachmittags'
          when stunde < 22 then 'Abends'
          else 'Nachts'
    end as tageszeit
    from stunden
    CROSS JOIN minuten
    CROSS JOIN sekunden
)