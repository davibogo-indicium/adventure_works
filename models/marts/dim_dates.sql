with
    dates as (
        select *
        from {{ ref('int_dimension_dates') }}
    )

select *
from dates