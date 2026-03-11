with
    source_state_province as (
        select *
        from {{ source('crm', 'StateProvince') }}
    )

    rename as (
        select
            cast(StateProvinceID as int) as pk_state
            , cast(CountryRegionCode as int) as fk_country
            , Name as state_name
        from source_state_province
    )

select *
from rename