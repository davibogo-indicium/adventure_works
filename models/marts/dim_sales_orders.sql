with
    dimension_sales_orders as (
        select *
        from {{ ref('int_sales_orders') }}
    )

    , remove_duplications as (
        select
            sk_sales_order_detail as pk_sales_order_detail
            , ANY_VALUE(client_name) as client_name
            , ANY_VALUE(product_name) as product_name
            , ANY_VALUE(card_type) as card_type
            , ANY_VALUE(sales_reason_name) as sales_reason_name
            , ANY_VALUE(sales_order_status) as sales_order_status
        from dimension_sales_orders
        group by
            sk_sales_order_detail
    )

select *
from remove_duplications