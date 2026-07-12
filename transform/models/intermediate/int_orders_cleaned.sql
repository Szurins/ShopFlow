with orders as (
    select * from {{ ref('stg_brazilian_ecommerce__orders') }}
),

cleaned as (
    select
        order_id,
        customer_id,
        order_status,
        purchased_at,
        
        case 
            when approved_at < purchased_at then purchased_at 
            else approved_at 
        end as approved_at,
        
        case 
            when delivered_to_carrier_at < purchased_at then null 
            else delivered_to_carrier_at 
        end as delivered_to_carrier_at,
        
        case 
            when delivered_to_customer_at < purchased_at then null 
            else delivered_to_customer_at 
        end as delivered_to_customer_at,
        
        estimated_delivery_at
    from orders
)

select * from cleaned
