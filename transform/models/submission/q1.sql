SELECT
    country_name,
    SUM(gmv_local) AS total_gmv
FROM
    Orders.Orders
GROUP BY
    country_name;
