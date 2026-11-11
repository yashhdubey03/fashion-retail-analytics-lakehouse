SELECT
    product_category AS category,
    total_orders,
    units_sold,
    gross_revenue,
    total_discounts,
    net_revenue,
    ROUND(
        100.0 * net_revenue / SUM(net_revenue) OVER (),
        2
    ) AS revenue_contribution_pct
FROM workspace.fashion_gold.category_performance
ORDER BY net_revenue DESC;
