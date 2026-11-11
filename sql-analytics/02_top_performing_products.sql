SELECT
    product_id,
    product_category,
    product_subcategory,
    product_brand,
    units_sold,
    total_orders,
    net_revenue,
    average_selling_price
FROM workspace.fashion_gold.product_performance
ORDER BY net_revenue DESC
LIMIT 20;
