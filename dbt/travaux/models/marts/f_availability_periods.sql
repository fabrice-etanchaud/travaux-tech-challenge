with cte as (
  select event_id
    ,professional_id_anonymized
    ,event_type
    ,created_at as started_at
    ,coalesce(lead(created_at) over w, '{{ var('max_date') }}'::timestamp) as ended_at
  from {{ ref('stg__availability_events') }}
  where not is_redundant
  window w as (partition by professional_id_anonymized order by created_at)
)

select event_id as availability_period_id
  ,professional_id_anonymized
  ,case event_type
    when 'became_able_to_propose' then 'Yes'
    when 'became_unable_to_propose' then 'No'
  end as availability_status
  ,{{ timestamp_to_dimension('started_at', 'begin') }}
  ,{{ timestamp_to_dimension('ended_at', 'end') }}
from cte
