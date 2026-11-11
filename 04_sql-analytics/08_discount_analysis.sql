WITH discount_analysis AS (
    SELECT
        CASE
            WHEN discount_percent = 0 THEN 'No Discount'
            WHEN discount_percent <= 5 THEN '1-5%'
            WHEN discount_percent <= 10 THEN '6-10%'
            WHEN discount_percent <= 15 THEN '11-15%'
            ELSE '16-20%'
        END AS discount_band,

        SUM(quantity) AS units_sold,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(gross_amount) AS gross_revenue,
        SUM(discount_amount) AS total_discount,
        SUM(net_amount) AS net_revenue

    FROM workspace.fashion_silver.order_items
    GROUP BY
        CASE
            WHEN discount_percent = 0 THEN 'No Discount'
            WHEN discount_percent <= 5 THEN '1-5%'
            WHEN discount_percent <= 10 THEN '6-10%'
            WHEN discount_percent <= 15 THEN '11-15%'
            ELSE '16-20%'
        END
)

SELECT
    discount_band,
    units_sold,
    total_orders,
    ROUND(gross_revenue, 2) AS gross_revenue,
    ROUND(total_discount, 2) AS total_discount,
    ROUND(net_revenue, 2) AS net_revenue,
    ROUND(
        100.0 * total_discount / NULLIF(gross_revenue, 0), 2
    ) AS effective_discount_pct,
    ROUND(
        100.0 * net_revenue / SUM(net_revenue) OVER (), 2
    ) AS revenue_contribution_pct

FROM discount_analysis
ORDER BY
    CASE discount_band
        WHEN 'No Discount' THEN 1
        WHEN '1-5%' THEN 2
        WHEN '6-10%' THEN 3
        WHEN '11-15%' THEN 4
        ELSE 5
    END;
