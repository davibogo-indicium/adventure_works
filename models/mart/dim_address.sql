with
    dimension_address as (
        select *
        from {{ ref('int_dimension_address') }}
    )

    , remove_duplications as (
        select
            pk_address as pk_address
            , ANY_VALUE(city_name) AS city_name
            , ANY_VALUE(state_name) AS state_name
            , ANY_VALUE(country_name) AS country_name
        from dimension_address
        group by
            pk_sales_order_detail
    )

select *
from remove_duplications