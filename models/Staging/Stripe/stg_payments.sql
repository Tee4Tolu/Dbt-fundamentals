select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    amount/100 as amount,
    status as status,
    created as date
from `dbt-tutorial.stripe.payment`