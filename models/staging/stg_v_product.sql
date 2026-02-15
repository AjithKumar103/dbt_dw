with src_product as (
  select * from {{ source('sales_source','src_product') }}
),

final as (
  select 
    product_id,
    trim(product_name) product_name,
    trim(category) category,
    trim(sub_category) sub_category,
    brand,
    last_updated

  from src_product
)

select * from final