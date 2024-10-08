{{ config(materialized='view') }}

SELECT
    DATE_TRUNC('month', start_date) AS month,
    policy_type,
    SUM(premium) AS total_premium,
    AVG(coverage_limit) AS avg_coverage_limit,
    AVG(deductible) AS avg_deductible,
    COUNT(DISTINCT agent_id) AS active_agents
FROM {{ ref('policies') }}
GROUP BY 1, 2
ORDER BY 1, 2