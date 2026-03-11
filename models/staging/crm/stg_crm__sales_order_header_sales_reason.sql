with
    source_sales_order_header_sales_reason as (
        select *
        from {{ source('crm', 'SalesOrderHeaderSalesReason') }}
    )

    rename as (
        select
            cast(BusinessEntityID || '-' || SalesOrderID || '-' || SalesReasonID as int) as pk_sales_order_header_sales_reason
            , cast(BusinessEntityID || '-' || SalesOrderID as int) as fk_sales_order_header
            , cast(SalesReasonID as int) as fk_sales_reason
        from source_sales_order_header_sales_reason

    )

select *
from rename