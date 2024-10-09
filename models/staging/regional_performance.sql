-- models/rps/regional_performance.sql
{{ config(materialized='table') }}

WITH agent_data AS (
    SELECT * FROM {{ ref('seed_agents') }}
),
policy_data AS (
    SELECT * FROM {{ ref('policies') }}
)

SELECT
    a.region,
    COUNT(DISTINCT a.agent_id) AS active_agents,
    COUNT(p.policy_id) AS total_policies,
    SUM(p.premium) AS total_premium,
    AVG(p.premium) AS avg_premium_per_policy,
    SUM(p.premium) / COUNT(DISTINCT a.agent_id) AS avg_premium_per_agent
FROM agent_data a
LEFT JOIN policy_data p ON a.agent_id = p.agent_id
GROUP BY 1