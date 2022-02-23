with orders as (
    select * from {{ref('stg_orders')}}
),

payment as (
    select * from {{ref('stg_payments')}}
),

payment_order as (
    select 
        order_id,
        sum(case when status = 'success' then amount end ) amount
    from payment
    group by order_id

),

final as (
    select 
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce (payment_order,0) as amount
    from orders
    left join payment_order
    on orders.orders_id = payment_order.orders_id 
)
select * from final