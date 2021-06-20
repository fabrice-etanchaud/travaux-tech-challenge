select
  event_id as proposal_id
  ,professional_id_anonymized
  ,service_id
  ,created_at as proposed_at
  ,lead_fee
from {{ ref('stg__event_log') }}
where event_type = 'proposed'
