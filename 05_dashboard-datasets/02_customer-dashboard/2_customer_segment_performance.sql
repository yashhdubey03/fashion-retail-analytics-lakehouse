SELECT
    customer_segment,
    city,
    gender,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(recency), 1) AS avg_recency_days,
    ROUND(AVG(frequency), 2) AS avg_orders_per_customer,
    ROUND(AVG(monetary), 2) AS avg_customer_spend,
    ROUND(SUM(monetary), 2) AS total_revenue
FROM workspace.fashion_gold.customer_analytics
GROUP BY customer_segment, city, gender
ORDER BY total_revenue DESC;
