select
    salesreasonid as sales_reason_id,
    name          as sales_reason_name,
    reasontype    as sales_reason_type
from {{ source('adventure_works', 'salesreason') }}
