{{
  config(
    materialized='view'
  )
}}

WITH q1 AS(
SELECT
    country_name,
    SUM(gmv_local) AS total_gmv
FROM
    Orders.Orders
GROUP BY
    country_name;),

q2 AS(
SELECT
    Vendors.vendor_name,
    COUNT(DISTINCT Orders.customer_id) AS customer_count,
    SUM(Orders.gmv_local) AS total_gmv
FROM
    Orders.Orders
JOIN
    Vendors.Vendors ON Orders.VENDOR_ID = Vendors.ID
WHERE 
    Orders.COUNTRY_NAME = 'Taiwan'
GROUP BY
    Vendors.vendor_name
ORDER BY
    customer_count DESC;),

q3 AS(
WITH RankedVendors AS (
    SELECT
        Orders.country_name,
        Vendors.vendor_name,
        SUM(Orders.gmv_local) AS total_gmv,
        RANK() OVER (PARTITION BY Orders.country_name ORDER BY SUM(Orders.gmv_local) DESC) AS rnk
    FROM
        Orders.Orders
    JOIN
        Vendors.Vendors ON Orders.VENDOR_ID = Vendors.ID
    GROUP BY
        Orders.country_name, Vendors.vendor_name
)
SELECT
    country_name,
    vendor_name,
    total_gmv
FROM
    RankedVendors
WHERE
    rnk = 1
ORDER BY
    country_name, total_gmv DESC;),

q4 AS(
WITH RankedVendors AS(
  SELECT
        Orders.date_local AS date_local,
        Orders.country_name,
        Vendors.vendor_name,
        SUM(Orders.gmv_local) AS total_gmv,
        RANK() OVER (PARTITION BY Orders.country_name, EXTRACT(YEAR FROM Orders.date_local) ORDER BY SUM(Orders.gmv_local) DESC) AS rnk
FROM 
  Orders.Orders
JOIN 
  Vendors.Vendors ON Orders.vendor_id = vendors.id
GROUP BY Orders.country_name, Vendors.vendor_name, Orders.date_local)
SELECT
    date_local,
    country_name,
    vendor_name,
    total_gmv
FROM
    RankedVendors
WHERE
    rnk <= 2
ORDER BY
   EXTRACT(YEAR FROM date_local) ,country_name, rnk;)







