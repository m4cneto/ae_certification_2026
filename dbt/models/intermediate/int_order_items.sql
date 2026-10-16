-- Grao: uma linha por item de pedido (salesorderdetailid).
-- Cabecalho entra apenas com atributos, nunca com valores somaveis:
-- subtotal, tax e freight se repetiriam em cada item e inflariam qualquer soma.
select
    d.sales_order_detail_id,
    d.sales_order_id,
    h.order_date,
    h.customer_id,
    d.product_id,
    h.credit_card_id,
    h.ship_address_id,
    h.status_code,
    h.is_online_order,
    coalesce(p.is_promotion, false) as is_promotion,

    d.order_qty,
    d.unit_price,
    d.unit_price_discount_pct,
    d.line_total

from {{ ref('stg_sales__order_detail') }} as d
inner join {{ ref('stg_sales__order_header') }} as h
    on d.sales_order_id = h.sales_order_id
left join {{ ref('int_order_promotion_flag') }} as p
    on d.sales_order_id = p.sales_order_id
