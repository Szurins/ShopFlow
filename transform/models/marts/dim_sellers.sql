with sellers as (
    select * from {{ ref('stg_brazilian_ecommerce__sellers') }}
),

geolocation as (
    select * from {{ ref('int_geolocation_deduplicated') }}
),

joined as (
    select
        s.seller_id,
        s.seller_zip_code_prefix,
        s.seller_city,
        s.seller_state,
        g.geolocation_latitude as latitude,
        g.geolocation_longitude as longitude
    from sellers s
    left join geolocation g
        on s.seller_zip_code_prefix = g.geolocation_zip_code_prefix
)

select * from joined
