with
    source_country_region as (
        select *
        from {{ source('crm', 'CountryRegion') }}
    )

    rename as (
        select
            cast(CountryRegionCode as int) as pk_country
            , Name as country_name
        from source_country_region
    )

select *
from rename