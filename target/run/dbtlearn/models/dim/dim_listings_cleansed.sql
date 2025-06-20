
  
    

  create  table "airbnb"."dev"."dim_listings_cleansed__dbt_tmp"
  
  
    as
  
  (
    with  __dbt__cte__src_listings as (
with raw_listings as (
    select * from "airbnb"."raw"."raw_listings"
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
), src_listings as (
    select * from __dbt__cte__src_listings
)
select
    listing_id,
    listing_name,
    room_type,
    case when minimum_nights = 0 
        then 1
        else minimum_nights 
        end as minimum_nights,
    host_id,
    replace(price_str, '$','')::numeric(10,2) as price,
    created_at,
    updated_at
from src_listings
  );
  