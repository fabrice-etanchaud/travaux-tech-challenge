{{ config(materialized = 'ephemeral') }}

select
  event_id
  ,professional_id_anonymized
  ,event_type
  ,created_at
  ,case when event_type = lag(event_type) over w
	  or lag(created_at) over w = created_at
	  or lead(created_at) over w = created_at
     then true
     else false
   end as is_redundant
from {{ ref('stg__event_log') }}
where event_type in ('became_able_to_propose', 'became_unable_to_propose')
window w as (partition by professional_id_anonymized order by created_at)
