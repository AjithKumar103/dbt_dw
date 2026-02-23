with sst_customer as (
  select * from {{ ref('sst_customer') }}
),

final as (
  select 
    --surrogate key
    {{dbt_utils.generate_surrogate_key([
      'customer_id','customer_name_full'
      ])}} as customer_key,
      
    --descriptive attributes
    customer_id,
    customer_name_full,
    customer_name_first,
    customer_name_last,
    gender,
    customer_city,
    customer_state,
    customer_country,

    --scd type 2 attributes
    dbt_valid_from customer_valid_from_date_time,
    dbt_valid_to customer_valid_to_date_time

  from sst_customer
)

select * from final