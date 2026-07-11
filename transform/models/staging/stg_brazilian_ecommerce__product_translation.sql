with source as (
    select * from {{ source('brazilian_ecommerce', 'bronze_product_translation') }}
),

renamed as (
    select
        product_category_name,
        product_category_name_english
    from source
)

select * from renamed
