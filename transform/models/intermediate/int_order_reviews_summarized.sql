with order_reviews as (
    select * from {{ ref('stg_brazilian_ecommerce__order_reviews') }}
),

summarized as (
    select
        order_id,
        count(review_id) as total_reviews_count,
        avg(review_score) as average_review_score
    from order_reviews
    group by order_id
)

select * from summarized
