with
    source_sales_order_header_sales_reason as (
        select *
        from {{ source('crm', 'sales_salesorderheadersalesreason') }}
    )

    , rename as (
        select
            salesorderid || '-' || salesreasonid as pk_sales_order_header_sales_reason
            , cast(salesorderid as int) as fk_sales_order_header
            , cast(salesreasonid as int) as fk_sales_reason
        from source_sales_order_header_sales_reason

    )

select *
from rename