select *
from {{ ref('stg__event_log') }}
where event_type = 'proposed'
  and (service_id is null or service_name_nl is null or service_name_en is null or lead_fee is null)
