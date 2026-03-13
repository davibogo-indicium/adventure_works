with
    source_sales_reason as (
        select *
        from {{ source('crm', 'sales_salesreason') }}
    )

    , rename as (
        select
            cast(salesreasonid as int) as pk_sales_reason
            , name as sales_reason_name
        from source_sales_reason

    )

select *
from rename