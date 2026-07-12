with order_items as (
    select * from {{ ref('stg_brazilian_ecommerce__order_items') }}
),

summarized as (
    select
        order_id,
        count(order_item_sequence) as total_items_count,
        count(distinct product_id) as unique_products_count,
        sum(price) as total_items_price,
        sum(freight_value) as total_freight_value,
        sum(price) + sum(freight_value) as total_order_item_value
    from order_items
    group by order_id
)

select * from summarized
