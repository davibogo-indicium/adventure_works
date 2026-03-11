with
    source_product as (
        select *
        from {{ source('crm', 'Product') }}
    )

    rename as (
        select
            cast(ProductID as int) as pk_product
            , cast(Name as int) as product_name
        from source_product
    )

select *
from rename