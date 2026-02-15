with src_customer as (
  select * from {{ source('sales_source','src_customer') }}
),

final as (
  select 
    customer_id,
    initcap(customer_name) customer_name_full,
    initcap({{ first_name('customer_name') }}) customer_name_first,
    initcap({{ last_name('customer_name') }}) customer_name_last,
    lower(gender) gender,
    initcap(trim(city)) customer_city,
    initcap(trim(state)) customer_state,
    initcap(trim(country)) customer_country,
    last_updated
  from src_customer
)

select * from final