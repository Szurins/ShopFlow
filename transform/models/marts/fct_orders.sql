with orders as (
    select * from {{ ref('int_orders_cleaned') }}
),

items as (
    select * from {{ ref('int_order_items_summarized') }}
),

payments as (
    select * from {{ ref('int_order_payments_summarized') }}
),

reviews as (
    select * from {{ ref('int_order_reviews_summarized') }}
),

joined as (
    select
        o.order_id,
        o.customer_id,
        o.order_status,
        o.purchased_at,
        o.approved_at,
        o.delivered_to_carrier_at,
        o.delivered_to_customer_at,
        o.estimated_delivery_at,
        
        -- Order item summaries
        coalesce(i.total_items_count, 0) as total_items_count,
        coalesce(i.unique_products_count, 0) as unique_products_count,
        coalesce(i.total_items_price, 0.0) as total_items_price,
        coalesce(i.total_freight_value, 0.0) as total_freight_value,
        coalesce(i.total_order_item_value, 0.0) as total_order_item_value,
        
        -- Payment summaries
        coalesce(p.total_payment_transactions, 0) as total_payment_transactions,
        coalesce(p.total_payment_value, 0.0) as total_payment_value,
        coalesce(p.max_payment_installments, 0) as max_payment_installments,
        
        -- Review summaries
        coalesce(r.total_reviews_count, 0) as total_reviews_count,
        coalesce(r.average_review_score, 0.0) as average_review_score
    from orders o
    left join items i on o.order_id = i.order_id
    left join payments p on o.order_id = p.order_id
    left join reviews r on o.order_id = r.order_id
)

select * from joined
