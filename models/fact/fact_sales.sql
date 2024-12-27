{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}
WITH src_sales AS (
    SELECT * FROM {{ ref('src_sales')}}
)
SELECT 
    SALE_ID,
    SALE_DATE,
    sales.STORE_ID,
    STORE_NAME,
    STORE_CITY,
    STORE_LOCATION,
    STORE_OPEN_DATE,
    sales.PRODUCT_ID,
    PRODUCT_NAME,
    PRODUCT_CATEGORY,
    PRODUCT_COST,
    PRODUCT_PRICE,
    SALES_UNITS
FROM src_sales sales 
    LEFT JOIN {{ ref('dim_stores')}} stores ON sales.STORE_ID = stores.STORE_ID
    LEFT JOIN {{ ref('dim_products')}} products ON sales.PRODUCT_ID = products.PRODUCT_ID
{% if is_incremental() %}
AND SALE_DATE > (select max(SALE_DATE) from {{ this }})
{% endif %}

-- unique_key = 'SALE_ID', incremental_strategy='delete+insert'