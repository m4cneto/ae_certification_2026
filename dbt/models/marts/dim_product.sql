select
    p.product_id                                as product_key,
    p.product_name,
    p.product_number,
    coalesce(sc.subcategory_name, 'Sem subcategoria') as subcategory_name,
    coalesce(c.category_name, 'Sem categoria')        as category_name,
    p.color,
    p.size,
    p.standard_cost,
    p.list_price
from {{ ref('stg_production__product') }} as p
left join {{ ref('stg_production__product_subcategory') }} as sc
    on p.product_subcategory_id = sc.product_subcategory_id
left join {{ ref('stg_production__product_category') }} as c
    on sc.product_category_id = c.product_category_id
