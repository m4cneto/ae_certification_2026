-- Um pedido pode ter varios motivos de venda. Para responder a pergunta "f" sem
-- multiplicar linhas no fato, reduzimos a relacao a uma flag por pedido.
select
    osr.sales_order_id,
    max(case when sr.sales_reason_name = 'Promotion' then true else false end) as is_promotion
from {{ ref('stg_sales__order_sales_reason') }} as osr
inner join {{ ref('stg_sales__sales_reason') }} as sr
    on osr.sales_reason_id = sr.sales_reason_id
group by osr.sales_order_id
