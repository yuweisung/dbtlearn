with raw_hosts as (
    select * from raw.raw_hosts
)
select 
  id as host_id,
  name as host_name,
  is_superhost::boolean,
  created_at::timestamp with time zone,
  updated_at::timestamp with time zone
from raw_hosts