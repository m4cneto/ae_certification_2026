select
    productsubcategoryid as product_subcategory_id,
    productcategoryid    as product_category_id,
    name                 as subcategory_name
from {{ source('adventure_works', 'productsubcategory') }}
