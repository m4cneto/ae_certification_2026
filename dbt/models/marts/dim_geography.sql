-- Geografia da venda = endereco de entrega do pedido (ship-to).
-- Decisao documentada em docs/regras-de-negocio.md.
select
    a.address_id              as geography_key,
    a.city,
    sp.state_province_name    as state_province,
    sp.state_province_code,
    cr.country_region_name    as country,
    sp.country_region_code    as country_code,
    a.postal_code
from {{ ref('stg_person__address') }} as a
left join {{ ref('stg_person__state_province') }} as sp
    on a.state_province_id = sp.state_province_id
left join {{ ref('stg_person__country_region') }} as cr
    on sp.country_region_code = cr.country_region_code
