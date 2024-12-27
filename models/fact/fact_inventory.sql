WITH src_inventory AS (
    SELECT * FROM {{ ref('src_inventory')}}
)
SELECT 
    inv.STORE_ID,
    STORE_NAME,
    STORE_CITY,
    STORE_LOCATION,
    STORE_OPEN_DATE,
    inv.PRODUCT_ID,
    PRODUCT_NAME,
    PRODUCT_CATEGORY,
    PRODUCT_COST,
    PRODUCT_PRICE,
    STOCK_ON_HAND,
    inv.CREATED_AT,
    inv.UPDATED_AT
FROM src_inventory inv 
    LEFT JOIN {{ ref('dim_stores')}} stores ON inv.STORE_ID = stores.STORE_ID
    LEFT JOIN {{ ref('dim_products')}} products ON inv.PRODUCT_ID = products.PRODUCT_ID
