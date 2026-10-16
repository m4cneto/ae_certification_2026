-- Membro "-1" cobre os pedidos sem cartao (revenda e faturamento direto),
-- para que o fato nunca tenha chave nula.
select
    credit_card_id as credit_card_key,
    card_type
from {{ ref('stg_sales__credit_card') }}

union all

select
    -1              as credit_card_key,
    'Sem cartao'    as card_type
