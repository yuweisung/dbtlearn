with raw_listings as (
    select * from raw.raw_listings
) 
select 
  id as listing_id, 
  name as listing_name, 
  listing_url, 
  room_type, 
  minimum_nights, 
  host_id, 
  price as price_str,
  created_at::timestamp with time zone, 
  updated_at::timestamp with time zone
from raw_listings