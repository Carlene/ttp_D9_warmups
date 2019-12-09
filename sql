--find the total sales ($$) and number of orders per month in the database (northwind).
-- don't worry about months with no sales.

WITH order_price AS(
SELECT
 CASE WHEN discount > 0
 THEN unitprice * quantity * (1 - discount)
 ELSE unitprice * quantity
 END as total_price
 ,orderid

FROM 
 orderdetails

GROUP BY 
 orderid
 ,unitprice
 ,quantity
 ,discount)


SELECT
 concat(EXTRACT(year from orderdate), '-', EXTRACT(month from orderdate)) as "date"
 ,round(SUM(total_price)::numeric, 2)
 ,count(distinct o.orderid) as orders_per_month


FROM 
 orders as o
JOIN order_price as op
 ON o.orderid = op.orderid

GROUP BY
 1

ORDER BY
 1


-- Which month has the highest average sales ($$) over every year of the database?
--(hint you can either start from scratch or make use of the previous answer)

WITH order_price AS(
SELECT
 CASE WHEN discount > 0
 THEN unitprice * quantity * (1 - discount)
 ELSE unitprice * quantity
 END as total_price
 ,orderid

FROM 
 orderdetails

GROUP BY 
 orderid
 ,unitprice
 ,quantity
 ,discount)


SELECT
 EXTRACT(month from orderdate) as month
 ,round(AVG(total_price)::numeric, 2)


FROM 
 orders as o
JOIN order_price as op
 ON o.orderid = op.orderid

GROUP BY
 1

ORDER BY
 2 DESC

