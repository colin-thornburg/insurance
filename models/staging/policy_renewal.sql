-- models/rps/policy_renewal.sql
{{ config(materialized='table') }}

WITH policy_data AS (
    SELECT * FROM {{ ref('policies') }}
),
renewal_candidates AS (
    SELECT
        policy_id,
        customer_id,
        policy_type,
        premium,
        end_date,
        DATEDIFF(day, CURRENT_DATE(), end_date) AS days_to_renewal
    FROM policy_data
    WHERE end_date > CURRENT_DATE()
)

SELECT
    policy_id,
    customer_id,
    policy_type,
    premium,
    end_date,
    days_to_renewal,
    CASE
        WHEN days_to_renewal <= 30 THEN 'Urgent'
        WHEN days_to_renewal <= 60 THEN 'Soon'
        WHEN days_to_renewal <= 90 THEN 'Upcoming'
        ELSE 'Future'
    END AS renewal_status
FROM renewal_candidates
WHERE days_to_renewal <= 90
ORDER BY days_to_renewal