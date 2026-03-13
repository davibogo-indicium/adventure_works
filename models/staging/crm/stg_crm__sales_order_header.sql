with
    source_sales_order_header as (
        select *
        from {{ source('crm', 'sales_salesorderheader') }}
    )

    , rename as (
        select
            cast(salesorderid as int) as pk_sales_order_header
            , cast(customerid as int) as fk_customer
            , cast(creditcardid as int) as fk_card
            , cast(shiptoaddressid as int) as fk_address
            , cast(orderdate as date) as sales_order_dt
            , status as sales_order_status
        from source_sales_order_header
    )

select *
from rename