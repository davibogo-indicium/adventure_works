with
    source_credit_card as (
        select *
        from {{ source('crm', 'sales_creditcard') }}
    )

    , rename as (
        select
            cast(creditcardid as int) as pk_card
            , cast(cardtype as int) as card_type
        from source_credit_card
    )

select *
from rename