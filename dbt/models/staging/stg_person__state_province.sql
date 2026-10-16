select
    stateprovinceid   as state_province_id,
    name              as state_province_name,
    stateprovincecode as state_province_code,
    countryregioncode as country_region_code
from {{ source('adventure_works', 'stateprovince') }}
