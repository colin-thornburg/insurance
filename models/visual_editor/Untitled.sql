WITH policies AS (
  SELECT
    CUSTOMER_ID,
    PREMIUM
  FROM {{ ref('policies') }}
), aggregate_1 AS (
  SELECT
    CUSTOMER_ID AS CUSTOMER_ID,
    SUM(PREMIUM) AS sum_PREMIUM
  FROM policies
  GROUP BY
    1
)
SELECT
  *
FROM aggregate_1