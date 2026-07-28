with basket_sizes as (
    select op.order_id, p.department_id, count(*) as items 
    from order_products_prior op 
    join products p on op.product_id = p.product_id 
    group by op.order_id, p.department_id
) 
select d.department_name, round(avg(items), 2) as avg_items_per_order
from basket_sizes b 
join departments d on b.department_id = d.department_id 
group by d.department_name
order by avg_items_per_order desc;