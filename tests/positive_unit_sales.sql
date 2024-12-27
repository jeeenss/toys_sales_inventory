SELECT 
    * 
FROM {{ ref('fact_sales')}}
WHERE SALES_UNITS <= 0
LIMIT 100