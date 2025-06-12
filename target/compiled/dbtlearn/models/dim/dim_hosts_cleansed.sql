with  __dbt__cte__src_hosts as (
with raw_hosts as (
    select * from "airbnb"."raw"."raw_hosts"
)
select 
  id as host_id,
  name as host_name,
  is_superhost::boolean,
  created_at::timestamp with time zone,
  updated_at::timestamp with time zone
from raw_hosts
), src_hosts as (
    select * from __dbt__cte__src_hosts
)
select
    host_id,
    COALESCE(host_name, 'Anonymous') as host_name,
    COALESCE(is_superhost, 'f'::boolean) as is_superhost,
    created_at,
    updated_at
from src_hosts