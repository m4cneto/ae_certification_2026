select
    productcategoryid as product_category_id,
    name              as category_name
from {{ source('adventure_works', 'productcategory') }}
