with order_items as (
    select * from {{ ref('stg_brazilian_ecommerce__order_items') }}
),

orders as (
    select * from {{ ref('int_orders_cleaned') }}
),

joined as (
    select
        concat(order_items.order_id, '_', cast(order_items.order_item_sequence as string)) as order_item_key,
        order_items.order_id,
        order_items.order_item_sequence,
        orders.customer_id,
        order_items.product_id,
        order_items.seller_id,
        orders.order_status,
        orders.purchased_at,
        order_items.shipping_limit_at,
        order_items.price,
        order_items.freight_value,
        order_items.price + order_items.freight_value as total_item_value
    from order_items
    inner join orders 
        on order_items.order_id = orders.order_id
)

select * from joined
