with
    addresses as (
        select *
        from {{ ref('stg_crm__address') }}
    )

    , states as (
        select *
        from {{ ref('stg_crm__state_province') }}
    )

    , countries as (
        select *
        from {{ ref('stg_crm__country_region') }}
    )

    , addresses_enriched as (
        select
            addresses.pk_address
            , addresses.city_name
            , states.state_name
            , countries.country_name
        from addresses
        left join states on addresses.fk_state = states.pk_state
        left join countries on states.fk_country = countries.pk_country
    )

select *
from addresses_enriched