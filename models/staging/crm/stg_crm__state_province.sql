with
    source_state_province as (
        select *
        from {{ source('crm', 'person_stateprovince') }}
    )

    , rename as (
        select
            cast(stateprovinceid as int) as pk_state
            , countryregioncode as fk_country
            , name as state_name
        from source_state_province
    )

select *
from rename