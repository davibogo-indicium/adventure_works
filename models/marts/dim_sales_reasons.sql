with
    sales_reasons as (
        select
            pk_sales_reason
            , sales_reason_name
            , sales_reason_type
        from {{ ref('int_sales_reasons') }}
    )

    , remove_duplications as (
        select
            pk_sales_reason
            , ANY_VALUE(sales_reason_name) AS sales_reason_name
            , ANY_VALUE(sales_reason_type) AS sales_reason_type
        from sales_reasons  
        where pk_sales_reason is not null
        group by pk_sales_reason
    )

select *
from remove_duplications