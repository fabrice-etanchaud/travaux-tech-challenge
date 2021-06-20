select
  event_id
  ,event_type
  ,professional_id_anonymized
  ,created_at
  ,cast((regexp_split_to_array(meta_data, '_'))[1] as bigint) as service_id
  ,(regexp_split_to_array(meta_data, '_'))[2] as service_name_nl
  ,(regexp_split_to_array(meta_data, '_'))[3] as service_name_en
  ,cast((regexp_split_to_array(meta_data, '_'))[4] as decimal(12,2)) as lead_fee
from
  {{ source('log', 'event_log') }}
