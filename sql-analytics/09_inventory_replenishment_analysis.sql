WITH inventory_risk AS (
    SELECT
        warehouse_id,
        category,
        COUNT(DISTINCT product_id) AS affected_products,

        SUM(
            CASE WHEN inventory_status = 'Out Of Stock'
                 THEN 1 ELSE 0 END
        ) AS out_of_stock_records,

        SUM(
            CASE WHEN inventory_status = 'Low Stock'
                 THEN 1 ELSE 0 END
        ) AS low_stock_records,

        SUM(stock_quantity) AS available_stock,

        SUM(reorder_level - stock_quantity) AS recommended_reorder_units

    FROM workspace.fashion_gold.inventory_replenishment
    GROUP BY warehouse_id, category
),

ranked_inventory AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY recommended_reorder_units DESC
        ) AS replenishment_priority_rank,

        ROUND(
            100.0 * out_of_stock_records /
            NULLIF(out_of_stock_records + low_stock_records, 0), 2
        ) AS out_of_stock_pct

    FROM inventory_risk
)

SELECT
    warehouse_id,
    category,
    affected_products,
    out_of_stock_records,
    low_stock_records,
    available_stock,
    recommended_reorder_units,
    out_of_stock_pct,
    replenishment_priority_rank
FROM ranked_inventory
ORDER BY replenishment_priority_rank, warehouse_id;
