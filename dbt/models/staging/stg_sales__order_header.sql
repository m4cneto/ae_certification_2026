select
    salesorderid                as sales_order_id,
    cast(orderdate as date)     as order_date,
    customerid                  as customer_id,
    status                      as status_code,
    onlineorderflag             as is_online_order,
    shiptoaddressid             as ship_address_id,
    billtoaddressid             as bill_address_id,
    coalesce(creditcardid, -1)  as credit_card_id,
    territoryid                 as territory_id,
    subtotal                    as order_subtotal,
    taxamt                      as order_tax,
    freight                     as order_freight,
    totaldue                    as order_total_due
from {{ source('adventure_works', 'salesorderheader') }}
