select
    businessentityid as person_id,
    persontype       as person_type,
    firstname        as first_name,
    lastname         as last_name,
    trim(firstname || ' ' || lastname) as full_name
from {{ source('adventure_works', 'person') }}
