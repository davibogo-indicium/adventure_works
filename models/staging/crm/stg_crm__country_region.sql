with
    source_country_region as (
        select *
        from {{ source('crm', 'person_countryregion') }}
    )

    , rename as (
        select
            cast(countryregioncode as int) as pk_country
            , name as country_name
        from source_country_region
    )

select *
from rename