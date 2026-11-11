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
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY product_category
    ORDER BY net_revenue DESC
) <= 10
ORDER BY net_revenue DESC;
