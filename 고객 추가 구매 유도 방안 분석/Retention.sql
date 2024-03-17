# 리텐션 구하기
WITH first_order AS (
SELECT customer_no
		, MIN(order_date) AS first_order_date
FROM online_commerce
GROUP BY 1
), month_table AS (
SELECT o.customer_no 
	, channel
	, DATE_FORMAT(f.first_order_date, '%Y-%m-01') AS first_order_month
	, DATE_FORMAT(o.order_date, '%Y-%m-01') AS order_month
FROM online_commerce o
LEFT JOIN first_order f ON o.customer_no=f.customer_no
)

SELECT first_order_month
     , COUNT(DISTINCT customer_no) AS month0
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 1 MONTH) = order_month THEN customer_no END) AS month1
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 2 MONTH) = order_month THEN customer_no END) AS month2
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 3 MONTH) = order_month THEN customer_no END) AS month3
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 4 MONTH) = order_month THEN customer_no END) AS month4
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 5 MONTH) = order_month THEN customer_no END) AS month5
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 6 MONTH) = order_month THEN customer_no END) AS month6
FROM month_table
WHERE channel = 'Mobile'
GROUP BY first_order_month
ORDER BY first_order_month
