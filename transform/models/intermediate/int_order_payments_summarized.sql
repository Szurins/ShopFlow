with order_payments as (
    select * from {{ ref('stg_brazilian_ecommerce__order_payments') }}
),

summarized as (
    select
        order_id,
        count(payment_sequence) as total_payment_transactions,
        sum(payment_value) as total_payment_value,
        max(payment_installments) as max_payment_installments
    from order_payments
    group by order_id
)

select * from summarized
