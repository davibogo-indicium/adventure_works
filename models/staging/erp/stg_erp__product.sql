with
    source_product as (
        select *
        from {{ source('erp', 'production_product') }}
    )

    , rename as (
        select
            cast(productid as int) as pk_product
            , name as product_name
        from source_product
    )

select *
from rename