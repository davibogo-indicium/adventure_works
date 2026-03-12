with
    source_sales_order_header as (
        select *
        from {{ source('crm', 'SalesOrderHeader') }}
    )

    rename as (
        select
            cast(BusinessEntityID || '-' || SalesOrderID as int) as pk_sales_order_header
            , cast(BusinessEntityID as int) as fk_customer
            , Status as sales_order_status
        from source_sales_order_header
    )

select *
from rename