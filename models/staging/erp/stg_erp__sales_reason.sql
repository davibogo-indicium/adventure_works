with
    source_sales_reason as (
        select *
        from {{ source('erp', 'sales_salesreason') }}
    )

    , rename as (
        select
            cast(salesreasonid as int) as pk_sales_reason
            , name as sales_reason_name
            , reasontype as sales_reason_type
        from source_sales_reason

    )

select *
from rename