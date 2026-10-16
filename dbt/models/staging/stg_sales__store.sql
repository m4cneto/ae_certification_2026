select
    businessentityid as store_id,
    name             as store_name
from {{ source('adventure_works', 'store') }}
