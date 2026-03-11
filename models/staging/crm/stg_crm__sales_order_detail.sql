with
    source_sales_order_detail as (
        select *
        from {{ source('crm', 'SalesOrderDetail') }}
    )

    rename as (
        select
            cast(SalesOrderDetailID as int) as pk_sales_order_detail
            , cast(BusinessEntityID || '-' || SalesOrderID as int) as fk_sales_order_header
            , cast(ProductID as int) as fk_product
            , cast(OrderQty as int) as item_quantity
            , cast(UnitPriceDiscount as float) as item_price_discount
            , cast(UnitPrice as float) as item_price
        from source_sales_order_detail
    )

select *
from rename