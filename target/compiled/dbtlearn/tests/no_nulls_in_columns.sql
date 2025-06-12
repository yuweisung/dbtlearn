
    select * from "airbnb"."dev"."dim_listings_cleansed" where
    listing_id is null or
    listing_name is null or
    room_type is null or
    minimum_nights is null or
    host_id is null or
    price is null or
    created_at is null or
    updated_at is null or
    
    false
