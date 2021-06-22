select
  event_id as proposal_id
  ,professional_id_anonymized
  ,service_id
  ,{{ timestamp_to_dimension('created_at', 'proposal') }}
  ,lead_fee
from {{ ref('stg__event_log') }}
where event_type = 'proposed'
