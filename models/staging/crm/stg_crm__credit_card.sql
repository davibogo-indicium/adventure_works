with
    source_credit_card as (
        select *
        from {{ source('crm', 'CreditCard') }}
    )

    rename as (
        select
            cast(CreditCardID as int) as pk_card
            , cast(CardType as int) as card_type
        from source_credit_card
    )

select *
from rename