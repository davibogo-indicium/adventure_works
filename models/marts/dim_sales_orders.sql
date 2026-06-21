with
    dimension_sales_orders as (
        select *
        from {{ ref('int_sales_orders') }}
    )

    , remove_duplications as (
        select
            sk_sales_order_detail as pk_sales_order_detail
            , ANY_VALUE(client_name) AS client_name
            , ANY_VALUE(product_name) AS product_name
            , ANY_VALUE(card_type) AS card_type
            , ANY_VALUE(sales_reason_name) AS sales_reason_name
            , ANY_VALUE(sales_order_status) AS sales_order_status
        from dimension_sales_orders
        group by
            sk_sales_order_detail
    )

select *
from remove_duplications