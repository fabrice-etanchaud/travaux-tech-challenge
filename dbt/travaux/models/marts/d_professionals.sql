select
  professional_id_anonymized
  ,created_at as registered_at
from
  {{ ref('stg__event_log') }}
where
  event_type = 'created_account'
