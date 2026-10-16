select
    countryregioncode as country_region_code,
    name              as country_region_name
from {{ source('adventure_works', 'countryregion') }}
