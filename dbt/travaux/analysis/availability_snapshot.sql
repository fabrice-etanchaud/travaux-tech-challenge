with cte as (
	select 
	  event_id
	  ,professional_id_anonymized
	  ,event_type
	  ,created_at as started_at
	  ,lead(created_at) over w as ended_at
	  ,lead(event_type) over w as next_event_type
	  ,lead(event_id) over w as next_event_id
	from staging.stg__event_log
	where event_type in ('became_able_to_propose', 'became_unable_to_propose')
	window w as (partition by professional_id_anonymized order by created_at)
)

select *
from cte
where professional_id_anonymized in (

	select distinct professional_id_anonymized
	from cte
	where started_at = ended_at
	or event_type = next_event_type

)

