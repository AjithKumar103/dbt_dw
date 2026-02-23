with stg_store as (
  select * from {{ ref('stg_v_store') }}
),

final as (
  select 
    --surrogate key
    {{dbt_utils.generate_surrogate_key([
      'store_id','store_name','store_city'
      ])}} as store_key,

    --descriptive attributes
    store_id,
    store_name,
    store_city,
    store_region,
    store_country

    --scd type 2 attributes
    
  from stg_store
)

select * from final