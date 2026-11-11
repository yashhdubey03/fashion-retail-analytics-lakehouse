SELECT
    city,
    gender,
    age_group,
    COUNT(*) AS total_customers
FROM workspace.fashion_gold.customer_analytics
GROUP BY
    city,
    gender,
    age_group
ORDER BY
    city,
    age_group,
    gender;
