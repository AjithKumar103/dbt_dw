with sst_product as (
  select * from {{ ref('sst_product') }}
),

final as (
  select 
    --surrogate key
    {{dbt_utils.generate_surrogate_key([
      'product_id','product_name','category','brand'
      ])}} as product_key,

    --descriptive attributes
    product_id,
    product_name,
    category,
    sub_category,
    brand,

    --scd type 2 attributes
    dbt_valid_from product_valid_from_date_time,
    dbt_valid_to product_valid_to_date_time

  from sst_product
)

select * from final