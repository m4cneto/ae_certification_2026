-- Grao: uma linha por item de pedido.
-- gross_revenue - discount_amount = net_revenue (testado em tests/).
select
    sales_order_detail_id,
    sales_order_id,

    order_date      as date_key,
    customer_id     as customer_key,
    product_id      as product_key,
    credit_card_id  as credit_card_key,
    ship_address_id as geography_key,
    status_code     as status_key,

    is_online_order,
    is_promotion,

    order_qty,
    unit_price,
    unit_price_discount_pct,
    cast(order_qty * unit_price as decimal(19, 4))                            as gross_revenue,
    cast(order_qty * unit_price * unit_price_discount_pct as decimal(19, 4))  as discount_amount,
    line_total                                                                as net_revenue

from {{ ref('int_order_items') }}
