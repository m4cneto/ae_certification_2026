-- Nenhum pedido pode existir sem item. Se aparecer, o join do fato perdeu linha.
select h.sales_order_id
from {{ ref('stg_sales__order_header') }} as h
left join {{ ref('fct_sales') }} as f
    on h.sales_order_id = f.sales_order_id
where f.sales_order_id is null
