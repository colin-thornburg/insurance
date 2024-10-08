{{ config(materialized='view') }}

SELECT
    policy_id,
    customer_id,
    policy_type,
    premium,
    start_date,
    end_date,
    agent_id,
    coverage_limit,
    deductible
FROM {{ ref('seed_policies') }}