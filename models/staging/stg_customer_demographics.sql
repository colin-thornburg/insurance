SELECT
    customer_id,
    age,
    gender,
    marital_status,
    occupation,
    income_bracket
FROM {{ source('rps_raw','seed_customer_demographics') }}