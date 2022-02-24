 
 with fct_orders as  
    (with orders as (
        select * from {{ ref('stg_orders' )}}
    ),

    payments as (
        select * from {{ ref('stg_payments' )}}
    ) ,

    order_payments as (
        select 
            orderid,
            status,
            sum(case when status = 'success' then amount end) as amount
        from payments 
        group by orderid,status
    ),

    final as ( select
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    order_payments.status,
    coalesce(order_payments.amount,0) as amount
    from orders
    left join order_payments
    on order_payments.orderid = orders.order_id
    )
    select * from final)
select * from fct_orders