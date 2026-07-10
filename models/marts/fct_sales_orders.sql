with
    fact_sales_orders as (
        select *
        from {{ ref('int_sales_orders') }}
    )

    , group as (
        select
            sk_sales_order_detail as fk_sales_order_detail
            , fk_address
            , sales_order_dt
            , pk_sales_order_header
            , sum(item_price) as sum_item_price
            , sum(item_price_discount) as sum_item_price_discount
            , sum(item_quantity) as sum_item_quantity
            , sum(gross_revenue) as sum_gross_revenue
            , sum(liquid_revenue) as sum_liquid_revenue
        from fact_sales_orders
        group by
            sk_sales_order_detail
            , fk_address
            , sales_order_dt
            , pk_sales_order_header
    )

select *
from group