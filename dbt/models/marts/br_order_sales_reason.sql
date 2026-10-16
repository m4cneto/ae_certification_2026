-- Bridge: resolve o muitos-para-muitos entre pedido e motivo da venda.
-- Analises por motivo passam por aqui; o fato nunca junta direto com o motivo,
-- senao a receita seria contada uma vez por motivo do pedido.
select
    sales_order_id,
    sales_reason_id as sales_reason_key
from {{ ref('stg_sales__order_sales_reason') }}
