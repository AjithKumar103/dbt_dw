with src_store as (
  select * from {{ source('sales_source','src_store') }}
),

final as (
  select * from src_store
)

select * from final