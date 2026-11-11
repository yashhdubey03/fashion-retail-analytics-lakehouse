WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('MONTH', order_date) AS month_start,
        SUM(total_orders) AS total_orders,
        SUM(units_sold) AS units_sold,
        SUM(net_revenue) AS net_revenue
    FROM workspace.fashion_gold.daily_sales_performance
    GROUP BY month_start
),

sales_trends AS (
    SELECT
        month_start,
        total_orders,
        units_sold,
        net_revenue,
        ROUND(net_revenue / total_orders, 2) AS average_order_value,

        LAG(net_revenue) OVER (
            ORDER BY month_start
        ) AS previous_month_revenue,

        AVG(net_revenue) OVER (
            ORDER BY month_start
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS rolling_3_month_revenue

    FROM monthly_sales
)

SELECT
    DATE_FORMAT(month_start, 'MMM-yyyy') AS sales_month,
    total_orders,
    units_sold,
    ROUND(net_revenue, 2) AS net_revenue,
    average_order_value,
    previous_month_revenue,
    ROUND(
        100.0 * (net_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0), 2
    ) AS mom_growth_pct,
    ROUND(rolling_3_month_revenue, 2) AS rolling_3_month_revenue

FROM sales_trends
ORDER BY month_start DESC;
