with
    source_address as (
        select *
        from {{ source('crm', 'person_address') }}
    )

    , rename as (
        select
            cast(addressid as int) as pk_address
            , cast(stateprovinceid as int) as fk_state
            , city as city_name
        from source_address
    )

select *
from rename