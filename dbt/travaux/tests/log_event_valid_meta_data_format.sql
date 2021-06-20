select *
from {{ source('log', 'event_log') }}
where array_length(regexp_split_to_array(meta_data, '_'), 1) <> 4
