select 
    id as Payment_id,
    orderid as Order_id,
    amount/100 as amount,
    paymentmethod,
    status status,
    created created_at 	 
from `dbt-tutorial.stripe.payment`;