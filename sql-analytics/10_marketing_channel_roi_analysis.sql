WITH channel_metrics AS (
    SELECT
        marketing_channel,
        total_campaigns,
        total_spend,
        attributed_revenue,
        impressions,
        clicks,
        conversions,

        ROUND(
            attributed_revenue / NULLIF(total_spend, 0), 2
        ) AS blended_roas,

        ROUND(
            100.0 * clicks / NULLIF(impressions, 0), 2
        ) AS click_through_rate,

        ROUND(
            total_spend / NULLIF(conversions, 0), 2
        ) AS cost_per_conversion

    FROM workspace.fashion_gold.campaign_channel_performance
),

channel_rankings AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY blended_roas DESC
        ) AS roas_rank,

        ROUND(
            100.0 * total_spend / SUM(total_spend) OVER (), 2
        ) AS spend_contribution_pct,

        ROUND(
            100.0 * attributed_revenue /
            SUM(attributed_revenue) OVER (), 2
        ) AS revenue_contribution_pct

    FROM channel_metrics
)

SELECT
    marketing_channel,
    total_campaigns,
    ROUND(total_spend, 2) AS total_spend,
    ROUND(attributed_revenue, 2) AS attributed_revenue,
    blended_roas,
    click_through_rate,
    cost_per_conversion,
    spend_contribution_pct,
    revenue_contribution_pct,
    roas_rank

FROM channel_rankings
ORDER BY roas_rank;
