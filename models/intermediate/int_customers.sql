with
    customers as (
        select *
        from {{ ref('stg_erp__customer') }}
    )

    , people as (
        select *
        from {{ ref('stg_erp__person') }}
    )

    , stores as (
        select *
        from {{ ref('stg_erp__store') }}
    )

    , enriched_customers as (
        select
            customers.pk_customer
            , coalesce(people.full_name, stores.store_name) as customer_name

        from customers
        left join people on customers.fk_person = people.pk_person
        left join stores on customers.fk_store = stores.pk_store
    )

select *
from enriched_customers