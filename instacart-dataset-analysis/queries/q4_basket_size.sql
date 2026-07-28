with cte as (select order_id, max(add_to_cart_order) as basket_size
from order_products_prior 
group by order_id)
select
round(avg(basket_size), 2) as avg_basket,
min(basket_size) as min_basket,
max(basket_size) as max_basket,
percentile_cont(0.5) within group (order by basket_size) as median_basket_size
from cte
