with
    sales_reasons as (
        select *
        from {{ ref('int_sales_reasons') }}
    )

    , sales_orders as (
        select *
        from {{ ref('int_sales_orders') }}
    )

    , sales_orders_joined as (
        select
            sales_orders.sk_sales_order_detail
            , sales_orders.pk_sales_order_header
            , sales_reasons.pk_sales_reason as fk_sales_reason
            , sales_orders.customer_name
            , sales_orders.product_name
            , sales_orders.card_type
            , sales_orders.sales_order_dt
            , sales_orders.sales_order_status
            , sales_orders.fk_address
            , sales_orders.item_price
            , sales_orders.item_price_discount
            , sales_orders.item_quantity
            , sales_orders.gross_revenue
            , sales_orders.liquid_revenue
        from sales_orders
        left join sales_reasons on sales_orders.pk_sales_order_header = sales_reasons.fk_sales_order_header
    )

select *
from sales_orders_joined