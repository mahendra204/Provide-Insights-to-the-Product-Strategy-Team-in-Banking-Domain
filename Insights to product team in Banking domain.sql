SELECT * FROM [dataengineer].[dbo].[dim_customers] 
select * from [dataengineer].[dbo].[fact_spends] 

with cte as(
select customer_id, sum(spend) as total_amount_spend from [dataengineer].[dbo].[fact_spends] group by 
customer_id)
,cte2 as( select * from [dataengineer].[dbo].[dim_customers])
, cte3 as(
select c.customer_id, c.total_amount_spend, c2.avg_income*6 as total_income 
from cte c join cte2 c2 on c.customer_id=c2.customer_id )
select *, total_amount_spend/total_income from cte3 order by 4 desc 

with cte as(
select customer_id, sum(spend) as total_spend
from  [dataengineer].[dbo].[fact_spends] group by customer_id),
cte2 as ( select * from [dataengineer].[dbo].[dim_customers]),
cte3 as(
select c.customer_id, c2.avg_income*6 as total_income, c.total_spend from cte c join cte2 c2 on
c.customer_id=c2.customer_id)
select *, round((total_spend/ total_income)*100,2) as '%income_utilization' from cte3 order by 4 desc

