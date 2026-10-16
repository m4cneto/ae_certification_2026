select
    salesorderdetailid  as sales_order_detail_id,
    salesorderid        as sales_order_id,
    productid           as product_id,
    orderqty            as order_qty,
    unitprice           as unit_price,
    unitpricediscount   as unit_price_discount_pct,
    linetotal           as line_total
from {{ source('adventure_works', 'salesorderdetail') }}
