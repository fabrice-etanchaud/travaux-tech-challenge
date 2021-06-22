{{
  config(
    materialized = "table",
    post_hook = [
        "alter table {{this}}
            add primary key(date_id),
            add unique(date),
            add unique(month, year, day_of_month),
            add unique(iso_week, iso_year, day_of_week),
            add unique(quarter, year, month, day_of_month);"
    ]
  )
}}

select
  {{ timestamp_to_key('a_date') }} as date_id
  ,a_date::date as date
  ,extract(millennium from a_date)::int as millenium
  ,extract(century from a_date)::int as century
  ,extract(decade from a_date)::int as decade
  ,extract(year from a_date)::int as year
  ,to_char(a_date, 'WW'):: int as week_of_year
  ,extract(doy from a_date)::int as day_of_year
  ,extract(quarter from a_date)::int as quarter
  ,extract(month from a_date)::int as month
  ,to_char(a_date, 'Month') as month_label
  ,extract(day from a_date)::int as day_of_month
  ,extract(isoyear from a_date)::int as iso_year
  ,extract(week from a_date)::int as iso_week
  ,extract('isodow' from a_date)::int as day_of_week
  ,to_char(a_date, 'Day') as day_label
from
  generate_series(date('{{var("min_date")}}'), date('{{var("max_date")}}'), interval '1 day') as dates(a_date)
union all
values(
  {{ timestamp_to_key('null') }}
  ,'1901-01-01'::date
  ,0
  ,0
  ,0
  ,0
  ,0
  ,0
  ,0
  ,0
  ,'N/A'
  ,0
  ,0
  ,0
  ,0
  ,'N/A'
)
