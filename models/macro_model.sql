WITH raw_orders AS (

  SELECT * 
  
  FROM {{ source('prophecy-development.dataset', 'raw_orders') }}

),

raw_customers AS (

  SELECT * 
  
  FROM {{ source('prophecy-development.dataset', 'raw_customers') }}

),

Join_1 AS (

  SELECT 
    raw_customers.first_name AS first_name,
    raw_customers.last_name AS last_name,
    raw_orders.id AS id,
    raw_orders.user_id AS user_id,
    raw_orders.order_date AS order_date,
    raw_orders.status AS status
  
  FROM raw_orders
  INNER JOIN raw_customers
     ON raw_orders.id = raw_customers.id

),

Reformat_1 AS (

  SELECT 
    first_name AS first_name,
    last_name AS last_name,
    id AS id,
    user_id AS user_id,
    order_date AS order_date,
    status AS status,
    {{ cents('id') }} AS my_first_cent,
    {{ cents('id', 45) }} AS my_second_cent
  
  FROM Join_1

),

Reformat_2 AS (

  SELECT * 
  
  FROM Reformat_1

),

audit_1 AS (

  {{ audit(table_name = 'Reformat_2') }}

)

SELECT * 

FROM audit_1
