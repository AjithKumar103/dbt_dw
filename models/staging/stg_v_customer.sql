with src_customer as (
  select * from {{ source('sales_source','src_customer') }}
),

final as (
  select 
    customer_id,
    initcap(customer_name) customer_name,
    lower(gender) gender,
    initcap(trim(city)) city,
    initcap(trim(state)) state,
    initcap(trim(country)) country,
    last_updated
  from src_customer
)

select * from final