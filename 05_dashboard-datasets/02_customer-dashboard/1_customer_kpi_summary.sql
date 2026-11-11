SELECT
    city,
    gender,
    customer_segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(monetary), 2) AS total_customer_revenue,
    ROUND(AVG(monetary), 2) AS avg_customer_spend,
    ROUND(AVG(frequency), 2) AS avg_orders_per_customer
FROM workspace.fashion_gold.customer_analytics
GROUP BY city, gender, customer_segment;
