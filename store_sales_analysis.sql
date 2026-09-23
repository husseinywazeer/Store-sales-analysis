--====================================================
--store sales sql analysis
--====================================================


--====================
--database exploration
--====================

select *
from store_sales


select *
from information_schema.columns
where table_name = 'store_sales'


--total rows

select
count(*) as total_rows
from store_sales


--check duplicate row id

select
row_id,
count(*) as duplicate
from store_sales
group by row_id
having count(*) > 1


--check missing values

select
sum(case when row_id is null then 1 else 0 end) as missing_row_id,
sum(case when order_id is null then 1 else 0 end) as missing_order_id,
sum(case when customer_id is null then 1 else 0 end) as missing_customer_id,
sum(case when product_id is null then 1 else 0 end) as missing_product_id,
sum(case when order_date is null then 1 else 0 end) as missing_order_date,
sum(case when ship_date is null then 1 else 0 end) as missing_ship_date,
sum(case when sales is null then 1 else 0 end) as missing_sales,
sum(case when profit is null then 1 else 0 end) as missing_profit
from store_sales


--check negative or invalid values

select *
from store_sales
where sales < 0
	or quantity <= 0


--check high sales values

select
top 20 *
from store_sales
order by sales desc


--check invalid shipping dates

select *
from store_sales
where order_date > ship_date


--check row id sequence

select
row_id
from store_sales
order by row_id



--====================
--dimension exploration
--====================

select distinct city
from store_sales


select distinct region
from store_sales


select distinct state
from store_sales


select distinct segment
from store_sales


select distinct country
from store_sales


select distinct category
from store_sales


select distinct sub_category
from store_sales


select distinct ship_mode
from store_sales



--====================
--data range exploration
--====================

select
	min(order_date) as first_order_date,
	max(order_date) as last_order_date,
	datediff(
		year,
		min(order_date),
		max(order_date)
	) as data_year_span
from store_sales


select
	min(datediff(day,order_date,ship_date)) as minimum_shipping_days,
	max(datediff(day,order_date,ship_date)) as maximum_shipping_days,
	round(
		avg(datediff(day,order_date,ship_date) * 1.0),
		2
	) as avg_shipping_days
from store_sales


select
	datediff(day,order_date,ship_date) as shipping_days,
	count(distinct order_id) as total_orders
from store_sales
group by datediff(day,order_date,ship_date)
order by shipping_days



--====================
--measures exploration
--====================

select
	format(sum(sales),'n2') as total_sales,
	sum(quantity) as total_quantity,
	format(sum(profit),'n2') as total_profit,
	count(distinct order_id) as total_orders,
	count(distinct customer_id) as total_customers,
	count(distinct product_id) as total_products,
	round(avg(profit),2) as avg_profit
from store_sales



--====================
--magnitude analysis
--====================

--sales by segment

select
segment,
format(sum(sales),'n2') as total_sales,
sum(quantity) as total_quantity,
format(sum(profit),'n2') as total_profit
from store_sales
group by segment
order by sum(sales) desc


--sales by region

select
region,
format(sum(sales),'n2') as total_sales,
sum(quantity) as total_quantity,
format(sum(profit),'n2') as total_profit
from store_sales
group by region
order by sum(sales) desc


--sales by state

select
state,
format(sum(sales),'n2') as total_sales,
format(sum(profit),'n2') as total_profit
from store_sales
group by state
order by sum(sales) desc


--sales by category

select
category,
format(sum(sales),'n2') as total_sales,
sum(quantity) as total_quantity,
format(sum(profit),'n2') as total_profit,
round(avg(profit),2) as avg_profit
from store_sales
group by category
order by sum(sales) desc


--sales by sub category

select
sub_category,
format(sum(sales),'n2') as total_sales,
sum(quantity) as total_quantity,
format(sum(profit),'n2') as total_profit
from store_sales
group by sub_category
order by sum(sales) desc



--====================
--ranking analysis
--====================

--top 10 products by sales

select
top 10
product_id,
product_name,
format(sum(sales),'n2') as total_sales
from store_sales
group by product_id, product_name
order by sum(sales) desc


--top 10 customers by sales

select
top 10
customer_id,
customer_name,
format(sum(sales),'n2') as total_sales
from store_sales
group by customer_id, customer_name
order by sum(sales) desc


--top 10 states by sales

select
top 10
state,
format(sum(sales),'n2') as total_sales
from store_sales
group by state
order by sum(sales) desc


--top 10 states by profit

select
top 10
state,
format(sum(profit),'n2') as total_profit
from store_sales
group by state
order by sum(profit) desc


--bottom 10 products by profit

select
top 10
product_id,
product_name,
format(sum(profit),'n2') as total_profit
from store_sales
group by product_id, product_name
order by sum(profit)


--rank categories by sales

select
category,
format(sum(sales),'n2') as total_sales,
rank() over(
	order by sum(sales) desc
) as sales_rank
from store_sales
group by category


--rank sub categories by profit

select
sub_category,
format(sum(profit),'n2') as total_profit,
rank() over(
	order by sum(profit) desc
) as profit_rank
from store_sales
group by sub_category



--====================
--change over time
--====================

--yearly sales

select
year(order_date) as sales_year,
format(sum(sales),'n2') as total_sales
from store_sales
group by year(order_date)
order by sales_year


--monthly sales

select
datetrunc(month,order_date) as sales_month,
format(sum(sales),'n2') as total_sales
from store_sales
group by datetrunc(month,order_date)
order by sales_month


--monthly profit

select
datetrunc(month,order_date) as sales_month,
format(sum(profit),'n2') as total_profit
from store_sales
group by datetrunc(month,order_date)
order by sales_month


--monthly orders

select
datetrunc(month,order_date) as sales_month,
count(distinct order_id) as total_orders
from store_sales
group by datetrunc(month,order_date)
order by sales_month



--====================
--yoy growth
--====================

with yearly_sales as
(
	select
	year(order_date) as sales_year,
	sum(sales) as total_sales
	from store_sales
	group by year(order_date)
),
yearly_comparison as
(
	select
	sales_year,
	total_sales,
	lag(total_sales) over(
		order by sales_year
	) as prv_year_sales
	from yearly_sales
)

select
sales_year,
format(total_sales,'n2') as total_sales,
format(prv_year_sales,'n2') as prv_year_sales,
round(
	(total_sales - prv_year_sales) * 100.0 /
	nullif(prv_year_sales,0),
	2
) as yoy_growth
from yearly_comparison
order by sales_year



--====================
--mom growth
--====================

with monthly_sales as
(
	select
	datetrunc(month,order_date) as sales_month,
	sum(sales) as total_sales
	from store_sales
	group by datetrunc(month,order_date)
),
monthly_comparison as
(
	select
	sales_month,
	total_sales,
	lag(total_sales) over(
		order by sales_month
	) as prv_month_sales
	from monthly_sales
)

select
sales_month,
format(total_sales,'n2') as total_sales,
format(prv_month_sales,'n2') as prv_month_sales,
format(total_sales - prv_month_sales,'n2') as sales_difference,
round(
	(total_sales - prv_month_sales) * 100.0 /
	nullif(prv_month_sales,0),
	2
) as mom_growth
from monthly_comparison
order by sales_month



--====================
--cumulative analysis
--====================

--running total sales

with monthly_sales as
(
	select
	datetrunc(month,order_date) as sales_month,
	sum(sales) as total_sales
	from store_sales
	group by datetrunc(month,order_date)
)

select
sales_month,
format(total_sales,'n2') as total_sales,
format(
	sum(total_sales) over(
		order by sales_month
	),
	'n2'
) as cumulative_sales
from monthly_sales
order by sales_month


--cumulative profit

with monthly_profit as
(
	select
	datetrunc(month,order_date) as sales_month,
	sum(profit) as total_profit
	from store_sales
	group by datetrunc(month,order_date)
)

select
sales_month,
format(total_profit,'n2') as total_profit,
format(
	sum(total_profit) over(
		order by sales_month
	),
	'n2'
) as cumulative_profit
from monthly_profit
order by sales_month



--====================
--performance analysis
--====================

--compare each product sales with average product sales

with product_sales as
(
	select
	product_id,
	product_name,
	sum(sales) as total_sales
	from store_sales
	group by product_id, product_name
),
product_comparison as
(
	select
	product_id,
	product_name,
	total_sales,
	avg(total_sales) over() as avg_product_sales
	from product_sales
)

select
product_id,
product_name,
format(total_sales,'n2') as total_sales,
format(avg_product_sales,'n2') as avg_product_sales,
case
	when total_sales > avg_product_sales then 'above average'
	when total_sales < avg_product_sales then 'below average'
	else 'average'
end as sales_performance
from product_comparison
order by total_sales desc


--profitable vs loss making products

select
product_id,
product_name,
format(sum(sales),'n2') as total_sales,
format(sum(profit),'n2') as total_profit,
case
	when sum(profit) > 0 then 'profitable'
	when sum(profit) < 0 then 'loss'
	else 'break even'
end as profit_status
from store_sales
group by product_id, product_name
order by sum(profit) desc



--====================
--part to whole analysis
--====================

--percentage of sales by category

with category_sales as
(
	select
	category,
	sum(sales) as total_sales
	from store_sales
	group by category
)

select
category,
format(total_sales,'n2') as total_sales,
round(
	total_sales * 100.0 /
	sum(total_sales) over(),
	2
) as percentage_of_total_sales
from category_sales
order by total_sales desc


--percentage of sales by segment

with segment_sales as
(
	select
	segment,
	sum(sales) as total_sales
	from store_sales
	group by segment
)

select
segment,
format(total_sales,'n2') as total_sales,
round(
	total_sales * 100.0 /
	sum(total_sales) over(),
	2
) as percentage_of_total_sales
from segment_sales
order by total_sales desc


--percentage of profit by region

with region_profit as
(
	select
	region,
	sum(profit) as total_profit
	from store_sales
	group by region
)

select
region,
format(total_profit,'n2') as total_profit,
round(
	total_profit * 100.0 /
	nullif(sum(total_profit) over(),0),
	2
) as percentage_of_total_profit
from region_profit
order by total_profit desc



--====================
--segmentation analysis
--====================

--customer segmentation based on sales

with customer_sales as
(
	select
	customer_id,
	customer_name,
	sum(sales) as total_sales
	from store_sales
	group by customer_id, customer_name
),
customer_segment as
(
	select
	customer_id,
customer_name,
	total_sales,
	ntile(3) over(
		order by total_sales desc
	) as customer_group
	from customer_sales
)

select
customer_id,
customer_name,
format(total_sales,'n2') as total_sales,
case
	when customer_group = 1 then 'high value'
	when customer_group = 2 then 'medium value'
	else 'low value'
end as customer_segment
from customer_segment
order by total_sales desc


--shipping segmentation

select
case
	when datediff(day,order_date,ship_date) <= 2 then 'fast'
	when datediff(day,order_date,ship_date) <= 5 then 'normal'
	else 'slow'
end as shipping_segment,
count(distinct order_id) as total_orders
from store_sales
group by
case
	when datediff(day,order_date,ship_date) <= 2 then 'fast'
	when datediff(day,order_date,ship_date) <= 5 then 'normal'
	else 'slow'
end
order by total_orders desc



--====================
--customer analysis
--====================

select
customer_id,
customer_name,
count(distinct order_id) as total_orders,
format(sum(sales),'n2') as total_sales,
format(sum(profit),'n2') as total_profit,
format(
	sum(sales) /
	nullif(count(distinct order_id),0),
	'n2'
) as avg_order_value,
min(order_date) as first_order_date,
max(order_date) as last_order_date,
datediff(
	day,
	min(order_date),
	max(order_date)
) as customer_lifetime_days,
rank() over(
	order by sum(sales) desc
) as customer_rank
from store_sales
group by customer_id, customer_name
order by sum(sales) desc



--====================
--product analysis
--====================

select
product_id,
product_name,
category,
sub_category,
format(sum(sales),'n2') as total_sales,
format(sum(profit),'n2') as total_profit,
sum(quantity) as total_quantity,
round(
	sum(profit) * 100.0 /
	nullif(sum(sales),0),
	2
) as profit_margin,
rank() over(
	order by sum(sales) desc
) as sales_rank
from store_sales
group by
product_id,
product_name,
category,
sub_category
order by sum(sales) desc



--====================
--shipping analysis
--====================

--average shipping days by ship mode

select
ship_mode,
round(
	avg(datediff(day,order_date,ship_date) * 1.0),
	2
) as avg_shipping_days,
min(datediff(day,order_date,ship_date)) as min_shipping_days,
max(datediff(day,order_date,ship_date)) as max_shipping_days,
count(distinct order_id) as total_orders
from store_sales
group by ship_mode
order by avg_shipping_days


--average shipping days by region

select
region,
round(
	avg(datediff(day,order_date,ship_date) * 1.0),
	2
) as avg_shipping_days
from store_sales
group by region
order by avg_shipping_days



--====================
--discount analysis
--====================

select
discount,
format(sum(sales),'n2') as total_sales,
format(sum(profit),'n2') as total_profit,
count(distinct order_id) as total_orders
from store_sales
group by discount
order by discount



--====================
--final business report
--====================

with customer_report as
(
	select
	customer_id,
	customer_name,
	count(distinct order_id) as total_orders,
	sum(sales) as total_sales,
	sum(profit) as total_profit,
	sum(quantity) as total_quantity,
	min(order_date) as first_order_date,
	max(order_date) as last_order_date
	from store_sales
	group by customer_id, customer_name
)

select
customer_id,
customer_name,
total_orders,
format(total_sales,'n2') as total_sales,
format(total_profit,'n2') as total_profit,
total_quantity,
format(
	total_sales /
	nullif(total_orders,0),
	'n2'
) as avg_order_value,
first_order_date,
last_order_date,
datediff(
	day,
	first_order_date,
	last_order_date
) as customer_lifetime_days,
rank() over(
	order by total_sales desc
) as sales_rank
from customer_report
order by total_sales desc
