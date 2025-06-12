
  
    

  create  table "airbnb"."dev"."mart_fullmoon_reviews__dbt_tmp"
  
  
    as
  
  (
    

with fct_reviews as (
    select * from "airbnb"."dev"."fct_reviews"
),
full_moon_dates as (
    select * from "airbnb"."dev"."seed_full_moon_dates"
)

select r.*,
    case when fm.full_moon_date is null then 'not full moon'
    else 'full moon'
    end as is_full_moon
from fct_reviews r
    left join full_moon_dates fm
    on (r.review_date = fm.full_moon_date::date)
  );
  