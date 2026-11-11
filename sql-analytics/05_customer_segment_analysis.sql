WITH segment_metrics AS (
    SELECT
        customer_segment,
        COUNT(DISTINCT customer_id) AS total_customers,
        ROUND(AVG(recency), 1) AS avg_recency_days,
        ROUND(AVG(frequency), 2) AS avg_orders_per_customer,
        ROUND(AVG(monetary), 2) AS avg_customer_spend,
        ROUND(SUM(monetary), 2) AS total_revenue
    FROM workspace.fashion_gold.customer_analytics
    GROUP BY customer_segment
),

segment_analysis AS (
    SELECT
        *,
        ROUND(
            100.0 * total_revenue /
            SUM(total_revenue) OVER (), 2
        ) AS revenue_contribution_pct,

        ROUND(
            100.0 * total_customers /
            SUM(total_customers) OVER (), 2
        ) AS customer_share_pct,

        RANK() OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_rank

    FROM segment_metrics
)

SELECT *
FROM segment_analysis
ORDER BY revenue_rank;
