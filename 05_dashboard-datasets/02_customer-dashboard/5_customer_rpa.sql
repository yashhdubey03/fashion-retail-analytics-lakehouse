SELECT
    CASE
        WHEN frequency = 1 THEN 'One-time'
        WHEN frequency = 2 THEN 'Repeat'
        WHEN frequency BETWEEN 3 AND 5 THEN 'Frequent'
        ELSE 'Loyal (6+)'
    END AS purchase_segment,
    city,
    gender,
    customer_segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(frequency), 2) AS avg_orders_per_customer,
    ROUND(SUM(monetary), 2) AS total_revenue
FROM workspace.fashion_gold.customer_analytics
GROUP BY
    CASE
        WHEN frequency = 1 THEN 'One-time'
        WHEN frequency = 2 THEN 'Repeat'
        WHEN frequency BETWEEN 3 AND 5 THEN 'Frequent'
        ELSE 'Loyal (6+)'    END,
    city,
    gender,
    customer_segment
ORDER BY avg_orders_per_customer;
