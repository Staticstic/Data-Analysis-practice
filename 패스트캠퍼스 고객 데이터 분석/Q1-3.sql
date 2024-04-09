-- Q1-3. Order 테이블의 list_price를 월별로 합계한 후, 전달 대비 얼마나 증가하였는지, 증감율을 구하시오
WITH sales AS (
	SELECT MONTH(created_at) AS order_month
		, SUM(list_price) AS total_sales
	FROM final_project.order
	GROUP BY 1
	ORDER BY 1
)
SELECT order_month
	, total_sales
    , LAG(total_sales) OVER (ORDER BY order_month) AS prior_sales
    , ((total_sales - LAG(total_sales) OVER (ORDER BY order_month)) / LAG(total_sales) OVER (ORDER BY order_month)) * 100 AS growth_rate
FROM sales