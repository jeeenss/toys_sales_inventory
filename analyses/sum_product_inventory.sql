WITH product_inv AS (
    SELECT 
        PRD.PRODUCT_ID,
        PRD.PRODUCT_NAME,
        PRD.PRODUCT_CATEGORY,
        PRD.PRODUCT_COST,
        PRD.PRODUCT_PRICE,
        COUNT(DISTINCT STORE_ID) TOTAL_DISTRIBUTED_STORE,
        SUM(STOCK_ON_HAND) OVERALL_STOCK
    FROM {{ ref('dim_products') }} PRD
        LEFT JOIN {{ ref('fact_inventory') }} INV
            ON PRD.PRODUCT_ID = INV.PRODUCT_ID
    GROUP BY 1,2,3,4,5
)
SELECT * FROM product_inv 
    ORDER BY 1,2,3,4,5