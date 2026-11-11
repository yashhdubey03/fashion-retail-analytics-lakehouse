SELECT
    target_segment,
    total_campaigns,
    total_spend,
    attributed_revenue,
    total_customers_reached,
    total_conversions,
    avg_roas,
    avg_conversion_rate
FROM workspace.fashion_gold.campaign_segment_performance
ORDER BY attributed_revenue DESC;
