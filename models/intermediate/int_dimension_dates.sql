with
    date_spine as (
        {{ 
            dbt_utils.date_spine(
                datepart="day",
                start_date="cast('2000-01-01' as date)",
                end_date="cast('2030-01-01' as date)"
            )
        }}
    )

    , criar_datas as (
        select
            row_number() over(order by date_day) as pk_date
            , cast(date_day as date) as dt_date
            , extract(day from date_day) as day
            , extract(year from date_day) as year
            , extract(month from date_day) as month
            , extract(quarter from date_day) as trimestre
            , case
                when extract(dow from date_day) in (0, 6) then true
                else false
            end as is_weekend

        from date_spine
    )

select *
from criar_datas