select
    productid             as product_id,
    name                  as product_name,
    productnumber         as product_number,
    productsubcategoryid  as product_subcategory_id,
    color                 as color,
    size                  as size,
    standardcost          as standard_cost,
    listprice             as list_price
from {{ source('adventure_works', 'product') }}
