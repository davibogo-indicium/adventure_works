/*
    This test ensures that the gross sales for 2011 match the audited accounting value:
    $ 12.646.112,16
*/

with filtered_orders as (
    select 
        sum(gross_revenue) as period_gross_revenue
    from {{ ref('int_sales_orders') }}
    where extract(year from sales_order_dt) = 2011
)

select 
    period_gross_revenue
from filtered_orders
where period_gross_revenue not between (12646112.16*0.99) and (12646112.16*1.01)