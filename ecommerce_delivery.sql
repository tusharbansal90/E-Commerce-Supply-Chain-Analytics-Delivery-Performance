CREATE DATABASE supply_chain_analysis;
USE supply_chain_analysis;

SELECT COUNT(*) AS total_rows
FROM supply_chain;

SELECT *
FROM supply_chain
LIMIT 10;

DESCRIBE supply_chain;

SELECT DISTINCT delivery_status FROM supply_chain;

SELECT
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_null_value,
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_null_value,
SUM(CASE WHEN product_card_id IS NULL THEN 1 ELSE 0 END) AS product_id_null_value,
SUM(CASE WHEN delivery_status IS NULL THEN 1 ELSE 0 END) AS delivery_status_id_null_value,
SUM(CASE WHEN days_for_shipping_real IS NULL THEN 1 ELSE 0 END) AS shipping_real_id_null_value,
SUM(CASE WHEN days_for_shipment_scheduled IS NULL THEN 1 ELSE 0 END) AS shipping_scheduled_id_null_value,
SUM(CASE WHEN order_profit_per_order IS NULL THEN 1 ELSE 0 END) AS order_profit_null_value,
SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS sales_null_value,
SUM(CASE WHEN benefit_per_order IS NULL THEN 1 ELSE 0 END) AS benifit_per_order_null_value,
SUM(CASE WHEN sales_per_customer IS NULL THEN 1 ELSE 0 END) AS sales_per_customer_null_value
FROM supply_chain;


SELECT type,days_for_shipping_real,days_for_shipment_scheduled,benefit_per_order,sales_per_customer,delivery_status,
late_delivery_risk,category_id,category_name,customer_city,customer_country,customer_email,customer_fname,customer_id,
customer_lname,customer_password,customer_segment,customer_state,customer_street,customer_zipcode,department_id
,department_name,latitude,longitude,market,order_city,order_country,order_customer_id,order_date_dateorders,order_id,
order_item_cardprod_id,order_item_discount,order_item_discount_rate,order_item_id,order_item_product_price,order_item_profit_ratio,
order_item_quantity,sales,order_item_total,order_profit_per_order,order_region,order_state,order_status,order_zipcode,
product_card_id,product_category_id,product_description,product_image,product_name,product_price,product_status,shipping_date_dateorders,shipping_mode
,COUNT(*)
FROM supply_chain
GROUP BY type,days_for_shipping_real,days_for_shipment_scheduled,benefit_per_order,sales_per_customer,delivery_status,
late_delivery_risk,category_id,category_name,customer_city,customer_country,customer_email,customer_fname,customer_id,
customer_lname,customer_password,customer_segment,customer_state,customer_street,customer_zipcode,department_id
,department_name,latitude,longitude,market,order_city,order_country,order_customer_id,order_date_dateorders,order_id,
order_item_cardprod_id,order_item_discount,order_item_discount_rate,order_item_id,order_item_product_price,order_item_profit_ratio,
order_item_quantity,sales,order_item_total,order_profit_per_order,order_region,order_state,order_status,order_zipcode,
product_card_id,product_category_id,product_description,product_image,product_name,product_price,product_status,shipping_date_dateorders,shipping_mode
HAVING COUNT(*) > 1;


SELECT order_id , COUNT(*)
FROM supply_chain
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC LIMIT 10;


SELECT delivery_status,COUNT(*),
    ROUND(COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0
    / COUNT(*),2) AS late_delivery_percentage,
    ROUND(COUNT(CASE WHEN delivery_status = 'Advance shipping' THEN 1 END) * 100.0
    / COUNT(*),2) AS advance_shipping_percentage,
    ROUND(COUNT(CASE WHEN delivery_status = 'Shipping on time' THEN 1 END) * 100.0
    / COUNT(*),2) AS on_time_percentage,
    ROUND(COUNT(CASE WHEN delivery_status = 'Shipping canceled' THEN 1 END) * 100.0
    / COUNT(*),2) AS canceled_percentage
FROM supply_chain
GROUP BY delivery_status;




SELECT
    customer_segment,
    COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
    COUNT(CASE WHEN delivery_status = 'Shipping on time' THEN 1 END) AS on_time_orders
FROM supply_chain
GROUP BY customer_segment
ORDER BY late_orders DESC;



SELECT
    category_name,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END)AS late_delivery,
    ROUND(COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*), 2) AS late_delivery_percentage
FROM supply_chain
GROUP BY category_name
ORDER BY late_delivery_percentage DESC;



SELECT
    customer_segment,
     ROUND(COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*),2) AS late_delivery_percentage,
	COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
	COUNT(CASE WHEN delivery_status = 'Shipping on time' THEN 1 END) AS on_time_orders
FROM supply_chain
GROUP BY customer_segment
ORDER BY late_delivery_percentage DESC;




SELECT
    market,COUNT(*)AS total_row,
     ROUND(COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*),2) AS late_delivery_percentage,
	COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
	COUNT(CASE WHEN delivery_status = 'Shipping on time' THEN 1 END) AS on_time_orders
FROM supply_chain
GROUP BY market
ORDER BY late_delivery_percentage DESC;



SELECT 
shipping_mode,COUNT(*) AS Total_order,
COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
ROUND(COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*),2) AS late_delivery_percentage
FROM supply_chain
GROUP BY shipping_mode
ORDER BY late_delivery_percentage DESC;



SELECT
    shipping_mode,
    COUNT(*) AS total_orders,
    ROUND(AVG(days_for_shipping_real), 2) AS avg_actual_days,
    ROUND(AVG(days_for_shipment_scheduled), 2) AS avg_scheduled_days,
    ROUND(
        AVG(days_for_shipping_real - days_for_shipment_scheduled), 2
    ) AS avg_delay_days
FROM supply_chain
GROUP BY shipping_mode
ORDER BY avg_delay_days DESC;





SELECT 
customer_city,COUNT(*) AS Total_order,
COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
ROUND(COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*),2) AS late_delivery_percentage
FROM supply_chain
GROUP BY customer_city
HAVING COUNT(*) >= 100
ORDER BY late_orders DESC LIMIT 10;




SELECT 
late_delivery_risk,COUNT(*) AS Total_order,
COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
COUNT(CASE WHEN delivery_status = 'Shipping on time' THEN 1 END) AS On_time_delivery_orders,
ROUND(COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*),2) AS late_delivery_percentage
FROM supply_chain
GROUP BY late_delivery_risk
ORDER BY late_orders DESC;




SELECT
    delivery_status,
    COUNT(*) AS total_orders,
    ROUND(AVG(days_for_shipping_real), 2) AS avg_actual_days,
    ROUND(AVG(days_for_shipment_scheduled), 2) AS avg_scheduled_days,
    ROUND(
        AVG(days_for_shipping_real - days_for_shipment_scheduled), 2
    ) AS avg_delay_days
FROM supply_chain
GROUP BY delivery_status
ORDER BY avg_delay_days DESC;



SELECT
category_name,
COUNT(*)AS total_order,
ROUND(
        AVG(days_for_shipping_real - days_for_shipment_scheduled), 2
    ) AS avg_delay_days
FROM supply_chain
GROUP BY category_name
ORDER BY avg_delay_days DESC;



WITH category_analysis AS (
    SELECT
        category_name,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN delivery_status = 'Late delivery' THEN 1 ELSE 0 END) AS late_orders,
        ROUND(SUM(CASE WHEN delivery_status = 'Late delivery' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2 ) AS late_delivery_percentage
    FROM supply_chain
    GROUP BY category_name
)
SELECT
    *,
    DENSE_RANK() OVER (
        ORDER BY late_delivery_percentage DESC
    ) AS category_rank
FROM category_analysis
ORDER BY category_rank
LIMIT 10;



WITH category_analysis AS (
SELECT market, category_name, COUNT(*) AS total_orders,
 SUM(CASE WHEN delivery_status = 'Late delivery' THEN 1 ELSE 0 END ) AS late_orders,
 ROUND( SUM(CASE WHEN delivery_status = 'Late delivery' THEN 1 ELSE 0 END ) * 100.0 / COUNT(*), 2 ) AS late_delivery_percentage
 FROM supply_chain
 GROUP BY market, category_name
),
category_ranking AS (
    SELECT *, DENSE_RANK() OVER ( PARTITION BY market ORDER BY late_delivery_percentage DESC ) AS category_rank
    FROM category_analysis
)
SELECT *
FROM category_ranking
WHERE category_rank <= 3
ORDER BY market, category_rank;



SELECT
    (CASE WHEN days_for_shipping_real > days_for_shipment_scheduled THEN 'Delayed'
        WHEN days_for_shipping_real = days_for_shipment_scheduled THEN 'On Schedule'
        ELSE 'Early'
    END )AS shipping_performance,
	COUNT(*) AS total_orders,
	ROUND(AVG(sales_per_customer), 2) AS avg_sales_per_customer,
    ROUND(AVG(benefit_per_order), 2) AS avg_benefit_per_order,
    ROUND(AVG(days_for_shipping_real), 2) AS avg_actual_shipping_days

FROM supply_chain
GROUP BY shipping_performance
ORDER BY avg_actual_shipping_days DESC;


SELECT
    delivery_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM supply_chain),
        2
    ) AS percentage_of_orders
FROM supply_chain
GROUP BY delivery_status
ORDER BY total_orders DESC;





WITH market_analysis AS (
    SELECT market, delivery_status, COUNT(*) AS total_orders,
	ROUND( COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY market), 2 ) AS order_percentage
    FROM supply_chain
    GROUP BY market, delivery_status
),
market_ranking AS (
    SELECT *, DENSE_RANK() OVER ( PARTITION BY market ORDER BY total_orders DESC ) AS status_rank
    FROM market_analysis
)
SELECT *
FROM market_ranking
WHERE status_rank <= 3
ORDER BY market, status_rank;





WITH market_delivery AS (
    SELECT market, COUNT(*) AS total_orders,
	SUM(CASE WHEN delivery_status = 'Late delivery' THEN 1 ELSE 0 END ) AS late_orders,
	ROUND( 100.0 * SUM( CASE WHEN delivery_status = 'Late delivery' THEN 1 ELSE 0 END ) / COUNT(*), 2 ) AS late_delivery_percentage
    FROM supply_chain
    GROUP BY market
),
market_comparison AS (
    SELECT *,
    ROUND( AVG(late_delivery_percentage) OVER (), 2 ) AS avg_market_late_percentage
    FROM market_delivery
)
SELECT
    market,
    total_orders,
    late_orders,
    late_delivery_percentage,
    avg_market_late_percentage,
    ROUND(late_delivery_percentage - avg_market_late_percentage, 2 ) AS difference_from_average,
    DENSE_RANK() OVER ( ORDER BY late_delivery_percentage DESC ) AS delay_risk_rank
FROM market_comparison
ORDER BY delay_risk_rank;