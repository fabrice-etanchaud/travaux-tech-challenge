select
  professional_id_anonymized
  ,{{ timestamp_to_dimension('created_at', 'registration') }}
from
  {{ ref('stg__event_log') }}
where
  event_type = 'created_account'
