select d.department_name, d.department_id, 
    round(sum(op.reordered) * 1.0 / count(*), 2) as reorder_rate
from order_products_prior op
join products p on op.product_id = p.product_id
join departments d on p.department_id = d.department_id
group by d.department_id, d.department_name
order by reorder_rate desc;