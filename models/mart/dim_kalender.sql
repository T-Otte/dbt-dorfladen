select
    {{ dbt_utils.surrogate_key(['date_day']) }} as DATUM_KEY,
    date_day as Datum,
    day_of_month as Tag,
    month_of_year as Monat,
    year_number as Jahr,
    week_of_year as Kalenderwoche,
    day_of_week as Wochentag,
    month_name as Monat_bez,
    quarter_of_year as Quartal,
    case when day_of_week in (1,7) then 0 else 1 end as KZ_Arbeitstag
  from {{ref('stage_dim_kalender')}}