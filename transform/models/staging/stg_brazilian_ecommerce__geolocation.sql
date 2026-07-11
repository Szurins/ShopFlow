with source as (
    select * from {{ source('brazilian_ecommerce', 'bronze_geolocation') }}
),

renamed as (
    select
        cast(geolocation_zip_code_prefix as string) as geolocation_zip_code_prefix,
        cast(geolocation_lat as double) as geolocation_latitude,
        cast(geolocation_lng as double) as geolocation_longitude,
        geolocation_city,
        geolocation_state
    from source
)

select * from renamed
