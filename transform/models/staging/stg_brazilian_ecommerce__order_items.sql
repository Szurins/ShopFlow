with source as (
    select * from {{ source('brazilian_ecommerce', 'bronze_order_items') }}
),

renamed as (
    select
        order_id,
        cast(order_item_id as integer) as order_item_sequence,
        product_id,
        seller_id,
        cast(shipping_limit_date as timestamp) as shipping_limit_at,
        cast(price as double) as price,
        cast(freight_value as double) as freight_value
    from source
)

select * from renamed
