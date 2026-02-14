with src_product as (
  select * from {{ source('sales_source','src_product') }}
),

final as (
  select * from src_product
)

select * from final