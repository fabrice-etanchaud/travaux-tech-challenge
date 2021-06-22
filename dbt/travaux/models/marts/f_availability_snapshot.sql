with periods as (
  select *
    ,min(begin_date) over () as min_begin_date
  from
    {{ ref('f_availability_periods') }}
)

select d_dates.date_id
  ,count(*) as active_professionals_count
from {{ ref('d_dates') }} as d_dates
left join periods on
  periods.begin_date <= d_dates.date_id  and d_dates.date_id < periods.end_date
where d_dates.date_id between min_begin_date and 20200330
  and periods.availability_status = 'Yes'
group by d_dates.date_id
