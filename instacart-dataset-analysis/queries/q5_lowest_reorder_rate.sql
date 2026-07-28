select p.product_id, p.product_name,
    round(sum(op.reordered) * 1.0 / count(*), 2) as reorder_rate,
    count(*) as total_orders
from order_products_prior op
join products p on op.product_id = p.product_id
group by p.product_id, p.product_name
having count(*) > 50
order by reorder_rate asc
limit 10;