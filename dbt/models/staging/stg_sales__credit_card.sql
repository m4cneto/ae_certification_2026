select
    creditcardid as credit_card_id,
    cardtype     as card_type
from {{ source('adventure_works', 'creditcard') }}
