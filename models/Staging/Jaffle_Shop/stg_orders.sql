with orders as (
        select id as order_id,
        USER_ID as customer_id,
        order_date,
        status
    from {{source('jaffle_Shop','orders')}}
        
    )
select * from orders

