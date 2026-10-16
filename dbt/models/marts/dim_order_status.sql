select
    status_code as status_key,
    status_name
from {{ ref('order_status') }}
