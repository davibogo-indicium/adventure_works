with
    source_product as (
        select *
        from {{ source('crm', 'raw__production_product') }}
    )

    , rename as (
        select
            cast(productid as int) as pk_product
            , name as product_name
        from source_product
    )

select *
from rename