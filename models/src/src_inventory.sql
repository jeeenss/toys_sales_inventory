WITH raw_inventory AS (
    SELECT * FROM {{ source("mexico_toys_db","inventory")}}
)
SELECT
    STORE_ID, 
    PRODUCT_ID, 
    STOCK_ON_HAND, 
    CREATED_AT, 
    UPDATED_AT
FROM 
    raw_inventory