Create database Retail_p1;
Drop table if exists retail_p1;
Create  table Retails_sales
(
 transactions_id INT primary key,
sale_date Date,
sale_time Time,
customer_id	INT,
gender varchar(15),
age	INT,
category varchar(26),	
quantiy	INT,
price_per_unit	float,
cogs float,
total_sale float
);

SELECT * FROM Retails_sales;
-- I dont Want see all data so using 
Select* from Retails_sales
Limit 10;

-- verfiying the Total Number Of rows In the table
select count(*)
from retails_sales;

--- Data Cleaning Process First to Idefintying The Null Value 
Select* from retails_sales
where 
     transactions_id is null
     or
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or 
     gender is null 
     or
     age is null 
     or
     category is null 
     or 
     quantiy is null
     or 
     price_per_unit is null
     or 
     cogs is null 
     or 
     total_sale is null;

--- Delete The Null Values for the table 
delete from	 retails_sales
where 
     transactions_id is null
     or
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or 
     gender is null 
     or
     age is null 
     or
     category is null 
     or 
     quantiy is null
     or 
     price_per_unit is null
     or 
     cogs is null 
     or 
     total_sale is null;
     
-- Data Sales Performance & customer Insights ---
-- 1) How many sales we have
select count(*) as total_sales
from retails_sales;

-- 2) How Many Unique Customers we have  ?

select count(distinct customer_id) as total_customers
from retails_sales;

-- 3) How Many Unique caterogys have ?
Select distinct category 
from retails_sales;

--- 4) What is the tota_sales and avg per sales Transction 
select 
     sum(total_sale) As total_sales,
	 round(avg(total_sale), 2) As avg_per_transction
from retails_sales;

-- 5) what is avg of customers 

Select AVG(age) As avg_Customer
from retails_sales;

-- 6)Genders to total_sales

select gender,
sum(total_sale) As total_sales
from retails_sales
Group by gender ;

-- 7) which gender contribute more to total_sales
Select 
      gender,
      count(*) as number_of_transactions,
	  sum(total_sale) as total_sales,
	  round(sum(total_sale)*100.0/(select sum(total_sale) from retails_sales),2)as Sales_percentage
from retails_sales
group by gender
order by total_sales DESC;

-- sales By Day ---
select 
      sale_date,
	  sum(total_sale) as Day_total_sale
from retails_sales
group by sale_date
order by sale_date Desc
limit 5;

-- sales By month  ---
select 
      Month(sale_date)As Month,
	  sum(total_sale) as Month_total_sale
from retails_sales
group by Month(sale_date)
order by Month Desc
limit 5;

-- Sales By Category --
select * from retails_sales;
select 
      category,
      sum(total_sale) as total_sales,
      sum(quantiy) as total_quantiy
from retails_sales
group by category 
order by total_sales Desc;

-- total Profit ( Revenue)
select
      sum(total_sale) as total_profit
from retails_sales;

-- sales by Age Group--

Select
 case 
  when age <20 Then 'under 20'
  when age between 20 AND 29 Then '20s'
  when age between 29 AND 39 Then '30s'
  when age between 39 AND 49 Then '40s'
  Else '50s'
END as age_group,
count(*) as transactions,
sum(total_sale) as total_sales 
from retails_sales 
group by age_group
order by total_sales Desc;

-- sales by shift (morning,afternoon,Evening)--

with shiftData as(
select*,
case
    when hour(sale_time) <12 Then 'Morning'
    when hour(sale_time) between 12 AND 17 Then 'Afternoon'
    Else 'Evening'
    End as Shift
    from retails_sales
)
select 
 shift,
 count(*) as transactions,
 sum(total_sale) as total_sales
from shiftData
group by shift;

-- what is the total cost of Goods sold (cogs)
select 
round(sum(cogs),2) as total_cogs
from retails_sales;

-- what is the total profit (total_sales -cogs)

select 
round(sum(total_sale - cogs),2) as total_profit
from retails_sales;

-- Which categories  Are Most sold by Quantity and by revenue 

select	 
    category,
    sum(quantiy) as total_quantity_sold,
    sum(total_sale) as total_Revenue
    from retails_sales
    group by category
    order by total_quantity_sold DESC, total_Revenue DESC;
    
-- what is the average price per unit for each category 
select 
      category,
      round(AVG(price_per_unit),2) as avg_price_per_unit
      from retails_sales
      group by category
      order by avg_price_per_unit DESC;
    