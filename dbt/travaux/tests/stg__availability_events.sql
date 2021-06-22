select professional_id_anonymized
  ,created_at
  ,count(*)
from {{ ref('stg__availability_events') }}
where not is_redundant
group by professional_id_anonymized
  ,created_at
having count(*) > 1
