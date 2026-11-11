WITH category_sales AS (
    SELECT
        product_category,
        SUM(net_revenue) AS category_revenue,
        SUM(units_sold) AS units_sold,
        SUM(total_orders) AS total_orders
    FROM workspace.fashion_gold.category_performance
    GROUP BY product_category
),

category_analysis AS (
    SELECT
        *,
        ROUND(
            100.0 * category_revenue /
            SUM(category_revenue) OVER (), 2
        ) AS revenue_contribution_pct,

        RANK() OVER (
            ORDER BY category_revenue DESC
        ) AS revenue_rank,

        ROUND(
            category_revenue -
            AVG(category_revenue) OVER (), 2
        ) AS revenue_vs_category_average

    FROM category_sales
)

SELECT
    product_category,
    ROUND(category_revenue, 2) AS category_revenue,
    units_sold,
    total_orders,
    revenue_contribution_pct,
    revenue_rank,
    revenue_vs_category_average
FROM category_analysis
ORDER BY revenue_rank;
