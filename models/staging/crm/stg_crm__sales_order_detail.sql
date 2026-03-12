with
    source_sales_order_detail as (
        select *
        from {{ source('crm', 'sales_salesorderdetail') }}
    )

    , rename as (
        select
            cast(salesorderdetailid as int) as pk_sales_order_detail
            , cast(salesorderid as int) as fk_sales_order_header
            , cast(productid as int) as fk_product
            , cast(orderqty as int) as item_quantity
            , cast(unitpricediscount as float) as item_price_discount
            , cast(unitprice as float) as item_price
        from source_sales_order_detail
    )

select *
from rename