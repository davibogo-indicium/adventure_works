with
    source_person as (
        select *
        from {{ source('erp', 'person_person') }}
    )

    , rename as (
        select
            cast(businessentityid as int) as pk_person
            , firstname || ' ' || middlename || ' ' || lastname as full_name
        from source_person
    )

select *
from rename