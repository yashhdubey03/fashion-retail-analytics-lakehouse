
WITH customer_first_purchase AS (
    SELECT
        customer_id,
        DATE_TRUNC('MONTH', MIN(order_date)) AS cohort_month
    FROM workspace.fashion_silver.orders
    WHERE order_status = 'Delivered'
      AND customer_id IS NOT NULL
    GROUP BY customer_id
),

customer_activity AS (
    SELECT DISTINCT
        o.customer_id,
        c.cohort_month,
        DATE_TRUNC('MONTH', o.order_date) AS activity_month
    FROM workspace.fashion_silver.orders o
    JOIN customer_first_purchase c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'Delivered'
),

cohort_activity AS (
    SELECT
        cohort_month,

        CAST(
            FLOOR(
                MONTHS_BETWEEN(activity_month, cohort_month)
            ) AS INT
        ) AS month_number,

        COUNT(DISTINCT customer_id) AS active_customers

    FROM customer_activity
    GROUP BY cohort_month, month_number
),

cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_id) AS cohort_size
    FROM customer_first_purchase
    GROUP BY cohort_month
),

retention_analysis AS (
    SELECT
        a.cohort_month,
        a.month_number,
        s.cohort_size,
        a.active_customers,

        ROUND(
            100.0 * a.active_customers / s.cohort_size, 2
        ) AS retention_rate_pct

    FROM cohort_activity a
    JOIN cohort_sizes s
        ON a.cohort_month = s.cohort_month
)

SELECT
    DATE_FORMAT(cohort_month, 'LLL-yyyy') AS cohort_month,

    month_number,

    CASE
        WHEN month_number = 0 THEN 'First Month'
        ELSE CONCAT('Month ', month_number + 1)
    END AS cohort_age,

    cohort_size,
    active_customers,

    CASE
        WHEN month_number = 0 THEN 0
        ELSE active_customers
    END AS repeat_customers,

    cohort_size - active_customers AS customer_drop_off,

    retention_rate_pct,

    CASE
        WHEN month_number = 0 THEN 'Baseline'
        WHEN retention_rate_pct >= 50 THEN 'Strong'
        WHEN retention_rate_pct >= 25 THEN 'Moderate'
        ELSE 'Low'
    END AS retention_status

FROM retention_analysis
ORDER BY
    cohort_month DESC,
    month_number;
