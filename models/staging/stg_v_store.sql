with src_store as (
  select * from {{ source('sales_source','src_store') }}
),

final as (
  select
    store_id,
    store_name,
    initcap(trim(city)) store_city,
    initcap(trim(region)) store_region,
    initcap(trim(country)) store_country
    
  from src_store
)

select * from final