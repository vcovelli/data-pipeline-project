SELECT 
  customer_id,
  COUNT(order_id) AS total_orders,
  AVG(order_value) AS avg_order_value
FROM {{ ref('customer_data_raw') }}
GROUP BY customer_id

