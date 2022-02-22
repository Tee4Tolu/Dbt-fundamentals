{{
    config(
        materialized = "table"
    
)}}


with customers as 
    (
        select id as customer_id,
        first_name,
        last_name
    from `dbt-tutorial.jaffle_shop.customers`
    ),

orders as (
        select id as order_id,
        USER_ID as customer_id,
        order_date,
        status
    from `dbt-tutorial.jaffle_shop.orders`
        
    ),

customer_orders as (
        select customer_id,
        min(order_date) as first_order_date,
        max(order_date) as recent_order_date,
        count(order_id) as Total_orders
    from orders
    group by 1
),

final as (
        select 
            customers.customer_id,
            customers.first_name,
            customers.last_name,
            customer_orders.first_order_date,
            customer_orders.recent_order_date,
            coalesce(customer_orders.Total_orders,0) as Total_orders
        from customers
        left join customer_orders 
        on customers.customer_id = customer_orders.customer_id
            
)
select * from final
    
    