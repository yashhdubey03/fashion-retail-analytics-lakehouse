SELECT
    city,
    CASE
        WHEN city = 'Mumbai' THEN 19.0760
        WHEN city = 'Pune' THEN 18.5204
        WHEN city = 'Delhi' THEN 28.6139
        WHEN city = 'Bengaluru' THEN 12.9716
    END AS latitude,
    CASE
        WHEN city = 'Mumbai' THEN 72.8777
        WHEN city = 'Pune' THEN 73.8567
        WHEN city = 'Delhi' THEN 77.2090
        WHEN city = 'Bengaluru' THEN 77.5946
    END AS longitude,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(monetary), 2) AS total_revenue
FROM workspace.fashion_gold.customer_analytics
GROUP BY city;
