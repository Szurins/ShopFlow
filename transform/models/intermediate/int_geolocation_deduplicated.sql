with source as (
    select * from {{ ref('stg_brazilian_ecommerce__geolocation') }}
),

deduplicated as (
    select
        geolocation_zip_code_prefix,
        avg(geolocation_latitude) as geolocation_latitude,
        avg(geolocation_longitude) as geolocation_longitude,
        min(geolocation_city) as geolocation_city,
        min(geolocation_state) as geolocation_state
    from source
    group by geolocation_zip_code_prefix
)

select * from deduplicated
