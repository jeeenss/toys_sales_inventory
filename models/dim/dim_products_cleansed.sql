WITH src_products AS (
    SELECT * FROM {{ ref("src_products") }} 
)
SELECT 
    PRODUCT_ID, 
    PRODUCT_NAME, 
    NVL(PRODUCT_CATEGORY, 'Others') AS PRODUCT_CATEGORY, 
    REPLACE(
        PRODUCT_COST,'$'
        ) :: NUMBER(10,2) AS PRODUCT_COST,  
    REPLACE(
        PRODUCT_PRICE, '$'
        ) :: NUMBER(10,2) AS PRODUCT_PRICE,
    CREATED_AT, 
    UPDATED_AT
FROM src_products