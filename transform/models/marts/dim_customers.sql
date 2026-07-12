with customers as (
    select * from {{ ref('stg_brazilian_ecommerce__customers') }}
),

geolocation as (
    select * from {{ ref('int_geolocation_deduplicated') }}
),

joined as (
    select
        c.customer_id,
        c.customer_unique_id,
        c.customer_zip_code_prefix,
        c.customer_city,
        c.customer_state,
        g.geolocation_latitude as latitude,
        g.geolocation_longitude as longitude
    from customers c
    left join geolocation g
        on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
)

select * from joined
