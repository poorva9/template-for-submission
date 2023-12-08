WITH q3_ref AS (
  SELECT * FROM {{ ref('Orders', 'q3') }}
)


SELECT *
FROM q3_ref;
