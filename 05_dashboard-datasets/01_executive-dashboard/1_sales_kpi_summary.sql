SELECT
    order_date,
    SUM(net_revenue) AS total_revenue,
    SUM(total_orders) AS total_orders,
    SUM(units_sold) AS units_sold,
    ROUND(
        SUM(net_revenue) / NULLIF(SUM(total_orders), 0), 2
    ) AS average_order_value
FROM workspace.fashion_gold.daily_sales_performance
GROUP BY order_date;
