-- models/dimensions/dim_customers.sql
{{ config(materialized='table') }}

WITH customer_data AS (
    SELECT * FROM {{ ref('stg_customer_demographics') }}
),
policy_data AS (
    SELECT 
        customer_id,
        COUNT(*) as total_policies,
        SUM(premium) as total_premium
    FROM {{ ref('stg_policies') }}
    GROUP BY customer_id
)

SELECT
    cd.customer_id,
    cd.age,
    cd.gender,
    cd.marital_status,
    cd.occupation,
    cd.income_bracket,
    COALESCE(pd.total_policies, 0) AS total_policies,
    COALESCE(pd.total_premium, 0) AS total_premium,
    CURRENT_TIMESTAMP()::TIMESTAMP_LTZ AS last_update_date
FROM customer_data cd
LEFT JOIN policy_data pd ON cd.customer_id = pd.customer_id