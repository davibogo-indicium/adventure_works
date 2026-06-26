with
    source_store as (
        select *
        from {{ source('erp', 'sales_store') }}
    )

    , rename as (
        select
            cast(businessentityid as int) as pk_store
            , cast(salespersonid as int) as fk_sales_person
            , initcap(cast(name as string)) as store_name
        from source_store
    )

select *
from rename