WITH raw_products AS (
    SELECT * FROM {{ source("mexico_toys_db","products")}}
)
SELECT
    PRODUCT_ID, 
    PRODUCT_NAME, 
    PRODUCT_CATEGORY, 
    PRODUCT_COST, 
    PRODUCT_PRICE, 
    CREATED_AT, 
    UPDATED_AT
FROM 
    raw_products