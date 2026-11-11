SELECT
    campaign_type,
    total_campaigns,
    total_spend,
    attributed_revenue,
    total_conversions,
    avg_roas,
    avg_conversion_rate
FROM workspace.fashion_gold.campaign_type_performance
ORDER BY attributed_revenue DESC;
