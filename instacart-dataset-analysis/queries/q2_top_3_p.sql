with cte as (
    select p.product_name, p.department_id, count(*) as agregacja 
    from order_products_prior op
    join products p on op.product_id = p.product_id
    group by p.product_name, p.department_id
),
ranked as (
    select *, rank() over (partition by department_id order by agregacja desc) as rnk 
    from cte
)
select d.department_name, r.product_name, r.agregacja, r.rnk
from ranked r
join departments d on r.department_id = d.department_id
where rnk <= 3
order by d.department_name, r.agregacja desc;