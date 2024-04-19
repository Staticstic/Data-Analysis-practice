-- Q1-1. 5개의 테이블을 하나의 테이블로 조인하는 쿼리 작성
-- DB 구조를 살펴봤을때 (user, customer, order)와 (user, refund, course)로 연결할 수 있다.
-- (user, customer, order) 테이블
SELECT u.*
	, c.name
    , c.phone
    , c.email
    , o.id AS order_id
    , o.type AS order_type
    , o.state AS order_state
    , o.name AS order_name
    , o.created_at AS order_created_at
    , o.updated_at AS order_updated_at
    , o.list_price
    , o.sale_price
    , o.discount_price
    , o.tax_free_price
FROM final_project.user AS u
LEFT JOIN final_project.customer AS c ON u.id=c.user_id
LEFT JOIN final_project.order AS o ON c.id=o.customer_id
ORDER BY 1

-- (user, refund, course) 테이블
SELECT u.*
	, r.id AS refund_id
    , r.type AS refund_type
    , r.state AS refund_state
    , r.created_at AS refund_created_at
    , r.updated_at AS refund_updated_at
    , r.course_id
    , r.amount
    , r.tax_free_amount
    , c.type AS course_type
    , c.state AS course_state
    , c.created_at AS course_created_at
    , c.updated_at AS course_updated_at
    , c.title
    , c.description
    , c.close_at
    , c.total_class_hours
    , c.keywords
FROM final_project.refund AS r
LEFT JOIN final_project.user AS u ON u.id=r.user_id
LEFT JOIN final_project.course AS c ON c.id=r.course_id
ORDER BY 1

