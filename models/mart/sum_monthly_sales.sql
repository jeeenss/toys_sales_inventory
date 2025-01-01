{{ 
    config(
        materialized = 'incremental',
        unique_key = ['MONTH_KEY','STORE_LOCATION','PRODUCT_NAME','PRODUCT_CATEGORY'],
        incremental_strategy = 'merge',
        on_schema_change = 'fail'
    ) 
}}
WITH fct_sales AS (
    SELECT 
        DATE_TRUNC('month', sale_date) AS MONTH_KEY,
        STORE_LOCATION,
        PRODUCT_NAME,
        PRODUCT_CATEGORY, 
        SUM(SALES_UNITS) TOTAL_SALES_UNIT,
        SUM(SALES_UNITS*PRODUCT_COST) TOTAL_COST,
        SUM(SALES_UNITS*PRODUCT_PRICE) TOTAL_SALES
    FROM {{ ref('fact_sales')}}
    GROUP BY 1,2,3,4
)
SELECT 
    *,
    CONVERT_TIMEZONE('Asia/Jakarta', CURRENT_TIMESTAMP()) AS LOADED_TIME
FROM fct_sales
{% if is_incremental() %}
  {% if var("month_key", False) %}
    {{ log('Loading ' ~ this ~ ' incrementally (MONTH_KEY: ' ~ var("month_key") ~ ')', info=True) }}
    WHERE MONTH_KEY = '{{ var("month_key") }}'
  {% else %}
    WHERE MONTH_KEY NOT IN ( SELECT DISTINCT MONTH_KEY FROM {{ this }})
    {{ log('Loading ' ~ this ~ ' incrementally (all missing MONTH_KEY)', info=True)}}
  {% endif %}
{% endif %}