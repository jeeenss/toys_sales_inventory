{{
    config(
        materialized = 'ephemeral'
    )
}}
WITH raw_stores AS (
    SELECT * FROM {{ source("mexico_toys_db","stores")}}
)
SELECT
    STORE_ID, 
    STORE_NAME, 
    STORE_CITY, 
    STORE_LOCATION, 
    STORE_OPEN_DATE, 
    CREATED_AT, 
    UPDATED_AT
FROM 
    raw_stores