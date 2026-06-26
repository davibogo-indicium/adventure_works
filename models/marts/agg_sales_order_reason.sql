with
    sales_order_reason_agg as (
        select *
        from {{ ref('int_sales_order_reason_agg') }}
    )

    , sales_reason_aggregated as (
        select
            sk_sales_order_detail
            , fk_sales_reason
            , fk_address
            , sales_order_dt
            , count(distinct pk_sales_order_header) as total_orders
            , sum(item_quantity) as total_quantity
            , sum(gross_total) as total_gross
            , sum(net_total) as total_net
        from sales_order_reason_agg
        where fk_sales_reason is not null
        group by 
            sk_sales_order_detail
            , fk_sales_reason
            , fk_address
            , sales_order_dt
    )

    , sales_order_reason_gen_unique_key as (
        select
            {{ dbt_utils.generate_surrogate_key(['fk_sales_reason', 'fk_address', 'sk_sales_order_detail', 'sales_order_dt']) }} as sk_reason_address_details
            , fk_sales_reason
            , fk_address
            , sk_sales_order_detail
            , sales_order_dt
            , total_orders
            , total_quantity
            , total_gross
            , total_net
        from sales_reason_aggregated
    )

select *
from sales_order_reason_gen_unique_key