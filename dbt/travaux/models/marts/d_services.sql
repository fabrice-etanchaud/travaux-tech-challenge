select distinct
  service_id
  ,service_name_nl
  ,service_name_en
from {{ ref('stg__event_log') }}
where event_type = 'proposed'
