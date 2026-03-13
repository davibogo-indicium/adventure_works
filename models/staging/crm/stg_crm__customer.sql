with
    source_customer as (
        select *
        from {{ source('crm', 'sales_customer') }}
    )

    , rename as (
        select
            cast(customerid as int) as pk_customer
            , cast(personid as int) as fk_person
        from source_customer
    )

select *
from rename