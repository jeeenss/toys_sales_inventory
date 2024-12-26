WITH raw_sales AS (
    SELECT * FROM {{ source("mexico_toys_db","sales")}}
)
SELECT
    SALE_ID, 
    DATE AS SALE_DATE, 
    STORE_ID, 
    PRODUCT_ID, 
    UNITS
FROM 
    raw_sales