with
    source_person as (
        select *
        from {{ source('crm', 'Person') }}
    )

    rename as (
        select
            cast(PersonsID as int) as pk_person
            , FirstName || ' ' MiddleName || ' ' || LastName as person_name
        from source_person
    )

select *
from rename