SELECT
    customer_id,
    age,
    gender,
    marital_status,
    occupation,
    income_bracket
FROM {{ ref('seed_customer_demographics') }}