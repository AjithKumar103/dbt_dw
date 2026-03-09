{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

with sales as (
    select * from {{ ref('stg_v_sales') }}
),

dim_sh_customer as (
    select * from {{ ref('dim_sh_customer') }} 
),

dim_sh_product as (
    select * from {{ ref('dim_sh_product') }} 
),

dim_sh_store as (
    select * from {{ ref('dim_sh_store') }}
),

final as (
    select
        --primary keys
        s.order_id,
        --foreign keys
        c.customer_key,
        p.product_key,
        st.store_key,
        --date attributes
        s.order_date,
        --facts
        quantity units,
        sales_amount sales,
        discount, 
        cost,

        --last load
        current_timestamp as last_load_date_time

    from sales s

    -- dim customer
    inner join dim_sh_customer c 
    on c.customer_id = s.customer_id 
    and s.order_date between c.customer_valid_from_date_time 
        and coalesce(c.customer_valid_to_date_time,'9999-01-01')

    -- dim product
    inner join dim_sh_product p 
    on p.product_id = s.product_id
    and s.order_date between p.product_valid_from_date_time 
        and coalesce(p.product_valid_to_date_time,'9999-01-01')

    -- dim store
    inner join dim_sh_store st on st.store_id = s.store_id

    {% if is_incremental() %}

    where s.order_date >= (select coalesce(max(order_date),'1900-01-01') from {{ this }} )

    {% endif %}
)

select * from final