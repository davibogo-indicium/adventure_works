with
    sales_order_reason_agg as (
        select *
        from {{ ref('int_sales_order_reason_agg') }}
    )

    , sales_reason_aggregated as (
        select
            sk_sales_order_detail as fk_sales_order_detail
            , pk_sales_order_header
            , fk_sales_reason
            , fk_address
            , sales_order_dt
            , sum(item_price) as item_price
            , sum(item_price_discount) as item_price_discount
            , sum(item_quantity) as item_quantity
            , sum(gross_revenue) as gross_revenue
            , sum(liquid_revenue) as liquid_revenue
        from sales_order_reason_agg
        where fk_sales_reason is not null
        group by 
            sk_sales_order_detail
            , pk_sales_order_header
            , fk_sales_reason
            , fk_address
            , sales_order_dt
    )

    , sales_order_reason_gen_unique_key as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_sales_reason', 
                'pk_sales_order_header', 
                'fk_address', 
                'fk_sales_order_detail', 
                'sales_order_dt'
            ]) }} as sk_reason_order_reason
            , pk_sales_order_header
            , fk_sales_reason
            , fk_address
            , fk_sales_order_detail
            , sales_order_dt
            , item_price
            , item_price_discount
            , item_quantity
            , gross_revenue
            , liquid_revenue
        from sales_reason_aggregated
    )

select *
from sales_order_reason_gen_unique_key