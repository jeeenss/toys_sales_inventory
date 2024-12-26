WITH src_stores AS (
    SELECT * FROM {{ ref('src_stores')}}
)
SELECT 
    STORE_ID, 
    STORE_NAME, 
    STORE_CITY, 
    STORE_LOCATION, 
    NVL(STORE_OPEN_DATE,'1980-01-01 00:00:00') AS STORE_OPEN_DATE, 
    CREATED_AT, 
    UPDATED_AT
FROM src_stores