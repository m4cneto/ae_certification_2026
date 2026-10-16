select
    c.customer_id                       as customer_key,
    case when c.store_id is null then 'Pessoa fisica' else 'Revenda' end as customer_type,
    coalesce(s.store_name, pe.full_name, 'Nao identificado')             as customer_name,
    pe.first_name,
    pe.last_name
from {{ ref('stg_sales__customer') }} as c
left join {{ ref('stg_person__person') }} as pe
    on c.person_id = pe.person_id
left join {{ ref('stg_sales__store') }} as s
    on c.store_id = s.store_id
