with
    source_customer as (
        select *
        from {{ source('erp', 'sales_customer') }}
    )

    , rename as (
        select
            cast(customerid as int) as pk_customer
            , cast(personid as int) as fk_person
            , cast(storeid as int) as fk_store
        from source_customer
    )

select *
from rename