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
    country_name, total_gmv DESC;
