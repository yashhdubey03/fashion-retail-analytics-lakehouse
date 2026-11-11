SELECT
    campaign_objective,
    total_campaigns,
    total_spend,
    attributed_revenue,
    total_customers_reached,
    total_conversions,
    avg_roas,
    avg_conversion_rate
FROM workspace.fashion_gold.campaign_objective_performance
ORDER BY attributed_revenue DESC;
