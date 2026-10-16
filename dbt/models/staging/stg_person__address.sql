select
    addressid       as address_id,
    city            as city,
    stateprovinceid as state_province_id,
    postalcode      as postal_code
from {{ source('adventure_works', 'address') }}
