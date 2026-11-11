WITH customer_purchase_summary AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(net_order_amount) AS lifetime_revenue,
        MIN(order_date) AS first_purchase_date,
        MAX(order_date) AS last_purchase_date
    FROM workspace.fashion_silver.orders
    WHERE order_status = 'Delivered'
      AND customer_id IS NOT NULL
    GROUP BY customer_id
),

purchase_segments AS (
    SELECT
        *,
        CASE
            WHEN total_orders = 1 THEN 'One-Time Customer'
            WHEN total_orders = 2 THEN 'Repeat Customer'
            WHEN total_orders BETWEEN 3 AND 5 THEN 'Frequent Customer'
            ELSE 'Loyal Customer'
        END AS purchase_segment
    FROM customer_purchase_summary
)

SELECT
    purchase_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(total_orders), 2) AS avg_orders_per_customer,
    ROUND(AVG(lifetime_revenue), 2) AS avg_lifetime_revenue,
    ROUND(SUM(lifetime_revenue), 2) AS total_revenue,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2
    ) AS customer_share_pct
FROM purchase_segments
GROUP BY purchase_segment
ORDER BY avg_orders_per_customer ASC;
