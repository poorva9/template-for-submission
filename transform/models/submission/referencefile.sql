WITH q3_ref AS (
  SELECT * FROM {{ ref('orders', 'q3') }}
)


SELECT *
FROM q3_ref;
