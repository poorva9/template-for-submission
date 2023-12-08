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
   EXTRACT(YEAR FROM date_local) ,country_name, rnk;
