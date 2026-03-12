with
    source_sales_reason as (
        select *
        from {{ source('crm', 'SalesReason') }}
    )

    rename as (
        select
            cast(SalesReasonID as int) as pk_sales__reason
            , Name as sales_reason_name
        from source_sales_reason

    )

select *
from rename