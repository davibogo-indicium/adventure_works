with
    source_country_region as (
        select *
        from {{ source('erp', 'person_countryregion') }}
    )

    , rename as (
        select
            countryregioncode as pk_country
            , name as country_name
        from source_country_region
    )

select *
from rename