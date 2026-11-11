SELECT
    order_date,
    total_orders,
    units_sold,
    gross_revenue,
    total_discounts,
    net_revenue,
    average_order_value
FROM workspace.fashion_gold.daily_sales_performance
ORDER BY order_date;
