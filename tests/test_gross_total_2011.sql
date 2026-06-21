/*
    This test ensures that the gross sales for 2011 match the audited accounting value:
    $ 12.646.112,16
*/

with filtered_orders as (
    select 
        sum(item_price * item_quantity) as period_gross_total
    from {{ ref('int_sales_order') }}
    where extract(year from sales_order_dt) = 2011
)

--select 
--    period_gross_total
--from filtered_orders
--where 1=1
--not between (12646112.16*0.99) and (12646112.16*1.01)

select * from filtered_orders