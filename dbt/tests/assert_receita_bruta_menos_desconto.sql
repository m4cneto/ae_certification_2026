-- Coerencia aritmetica das metricas do fato:
-- receita bruta - desconto tem que ser igual a receita liquida, item a item.
select
    sales_order_detail_id,
    gross_revenue,
    discount_amount,
    net_revenue
from {{ ref('fct_sales') }}
where abs((gross_revenue - discount_amount) - net_revenue) > 0.01
