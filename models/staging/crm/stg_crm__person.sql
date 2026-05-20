with
    source_person as (
        select *
        from {{ source('crm', 'raw__s3_person_person') }}
    )

    , rename as (
        select
            cast(businessentityid as int) as pk_person
            , firstname || ' ' || middlename || ' ' || lastname as person_name
        from source_person
    )

select *
from rename