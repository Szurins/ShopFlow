with products as (
    select * from {{ ref('int_products_translated') }}
)

select * from products
