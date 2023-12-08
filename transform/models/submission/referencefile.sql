WITH q3_ref AS (
  SELECT * FROM {{ ref('qn2-2', 'q3') }}
)


SELECT *
FROM q3_ref;
