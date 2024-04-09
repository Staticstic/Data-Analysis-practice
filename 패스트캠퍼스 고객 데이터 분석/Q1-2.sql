-- Q1-2. Order 테이블의 각 강의별 가장 첫 번째로 신청한 유저와 가장 마지막에 신청한 유저와 그 때의 날짜를 구하시오.
WITH order_2 AS (
    SELECT 
        *
        , ROW_NUMBER() OVER (PARTITION BY name ORDER BY created_at) AS rn_asc
        , ROW_NUMBER() OVER (PARTITION BY name ORDER BY created_at DESC) AS rn_desc
    FROM final_project.order
)
SELECT 
    name 
    , MAX(CASE WHEN rn_asc = 1 THEN customer_id END) AS first_customer
    , MAX(CASE WHEN rn_asc = 1 THEN created_at END) AS first_date
    , MAX(CASE WHEN rn_desc = 1 THEN customer_id END) AS last_customer
    , MAX(CASE WHEN rn_desc = 1 THEN created_at END) AS last_date
FROM order_2
GROUP BY 1

-- 다른 방법
SELECT 
    DISTINCT name,
    FIRST_VALUE(customer_id) OVER (PARTITION BY name ORDER BY created_at) AS first_user_id,
    LAST_VALUE(customer_id) OVER (PARTITION BY name ORDER BY created_at ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_user_id,
    FIRST_VALUE(created_at) OVER (PARTITION BY name ORDER BY created_at) AS first_date,
    LAST_VALUE(created_at) OVER (PARTITION BY name ORDER BY created_at ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_date
FROM final_project.order