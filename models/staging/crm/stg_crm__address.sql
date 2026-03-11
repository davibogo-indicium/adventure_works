with
    source_address as (
        select *
        from {{ source('crm', 'Address') }}
    )

    rename as (
        select
            cast(AddressID as int) as pk_address
            , cast(StateProvinceID as int) as fk_state
        from source_address
    )

select *
from rename