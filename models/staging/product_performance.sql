-- models/rps/product_performance.sql
{{ config(materialized='table') }}

WITH product_data AS (
    SELECT * FROM {{ ref('seed_products') }}
),
policy_data AS (
    SELECT * FROM {{ ref('policies') }}
)

SELECT
    pd.product_id,
    pd.product_name,
    pd.category,
    COUNT(p.policy_id) AS policies_sold,
    SUM(p.premium) AS total_premium,
    AVG(p.premium) AS avg_premium,
    SUM(p.premium) / NULLIF(pd.base_premium, 0) AS premium_multiplier
FROM product_data pd
LEFT JOIN policy_data p ON pd.product_name = p.policy_type
GROUP BY 1, 2, 3, pd.base_premium