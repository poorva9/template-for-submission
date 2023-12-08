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
    customer_count DESC;
