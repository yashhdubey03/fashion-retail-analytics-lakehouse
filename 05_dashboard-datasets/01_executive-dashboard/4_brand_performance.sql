SELECT
    product_brand AS brand,
    total_orders,
    units_sold,
    net_revenue
FROM workspace.fashion_gold.brand_performance
ORDER BY net_revenue DESC;
