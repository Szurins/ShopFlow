with source as (
    select * from {{ source('brazilian_ecommerce', 'bronze_order_payments') }}
),

renamed as (
    select
        order_id,
        cast(payment_sequential as integer) as payment_sequence,
        payment_type,
        cast(payment_installments as integer) as payment_installments,
        cast(payment_value as double) as payment_value
    from source
)

select * from renamed
