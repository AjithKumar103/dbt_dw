with src_sales as (
  select * from {{ source('sales_source','src_sales') }}
),

final as (
  select * from src_sales
)

select * from final