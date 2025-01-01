WITH store_inventory AS (
    SELECT 
        STR.STORE_ID,
        STR.STORE_NAME,
        STR.STORE_CITY,
        STR.STORE_LOCATION,
        COUNT(DISTINCT PRODUCT_ID) TOTAL_PRODUCT,
        SUM(STOCK_ON_HAND) OVERALL_STOCK
    FROM {{ ref('dim_stores')}} STR 
        LEFT JOIN {{ ref('fact_inventory') }} INV
            ON STR.STORE_ID = INV.STORE_ID
    GROUP BY 1,2,3,4
)
SELECT * FROM store_inventory 
    ORDER BY 1,2,3,1