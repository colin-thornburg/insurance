-- models/rps/agent_performance.sql
{{ config(materialized='table') }}

WITH agent_data AS (
    SELECT * FROM {{ source('rps_raw', 'seed_agents') }}
),
policy_data AS (
    SELECT * FROM {{ ref('policies') }}
)

SELECT
    a.agent_id,
    a.agent_name,
    a.region,
    COUNT(p.policy_id) AS policies_sold,
    SUM(p.premium) AS total_premium_sold,
    AVG(p.premium) AS avg_premium_per_policy,
    a.performance_score
FROM agent_data a
LEFT JOIN policy_data p ON a.agent_id = p.agent_id
GROUP BY 1, 2, 3, 7