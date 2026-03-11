with
    source_customer as (
        select *
        from {{ source('crm', 'Customer') }}
    )

    rename as (
        select
            cast(CustomerID as int) as pk_customer
            , cast(PersonID as int) as fk_person
        from source_customer
    )

select *
from rename