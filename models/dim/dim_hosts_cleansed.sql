with src_hosts as (
    select * from {{ref('src_hosts')}}
)
select
    host_id,
    COALESCE(host_name, 'Anonymous') as host_name,
    COALESCE(is_superhost, 'f'::boolean) as is_superhost,
    created_at,
    updated_at
from src_hosts    
