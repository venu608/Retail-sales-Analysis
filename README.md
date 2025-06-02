# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `p1_retail_db`

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **How many sales we have**:
```sql
select count(*) as total_sales
from retails_sales;
```

2. **How Many Unique Customers we have  ?**:
```sql
select count(distinct customer_id) as total_customers
from retails_sales;
```

3. **How Many Unique caterogys have ?.**:
```sql
Select distinct category 
from retails_sales;
```

4. **What is the tota_sales and avg per sales Transction.**:
```sql
select 
     sum(total_sale) As total_sales,
	 round(avg(total_sale), 2) As avg_per_transction
from retails_sales;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **what is avg of customers .**:
```sql
Select AVG(age) As avg_Customer
from retails_sales;
```

7. **Genders to total_sales**:
```sql
select gender,
sum(total_sale) As total_sales
from retails_sales
Group by gender ;
```

8. **which gender contribute more to total_sales **:
```sql
Select 
      gender,
      count(*) as number_of_transactions,
	  sum(total_sale) as total_sales,
	  round(sum(total_sale)*100.0/(select sum(total_sale) from retails_sales),2)as Sales_percentage
from retails_sales
group by gender
order by total_sales DESC;
```

9. ** sales By Day .**:
```sql
select 
      sale_date,
	  sum(total_sale) as Day_total_sale
from retails_sales
group by sale_date
order by sale_date Desc
limit 5;
```
10. ** sales By Month  .**:
```sql
select 
      Month(sale_date)As Month,
	  sum(total_sale) as Month_total_sale
from retails_sales
group by Month(sale_date)
order by Month Desc
limit 5;
```

11. ** Sales By Category  .**:
```sql
select * from retails_sales;
select 
      category,
      sum(total_sale) as total_sales,
      sum(quantiy) as total_quantiy
from retails_sales
group by category 
order by total_sales Desc;
```

12. ** total Profit ( Revenue)  .**:
```sql
select
      sum(total_sale) as total_profit
from retails_sales;
```

13. ** sales by Age Group  .**:
```sql
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
```

14. **sales by shift (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

15. **what is the total cost of Goods sold (cogs)**:
```sql
select 
round(sum(cogs),2) as total_cogs
from retails_sales;
```
16. ** what is the total profit (total_sales -cogs)**:
```sql
select 
round(sum(total_sale - cogs),2) as total_profit
from retails_sales;
```


17. **Which categories  Are Most sold by Quantity and by revenue**:
```sql
select	 
    category,
    sum(quantiy) as total_quantity_sold,
    sum(total_sale) as total_Revenue
    from retails_sales
    group by category
    order by total_quantity_sold DESC, total_Revenue DESC;
```
18. **what is the average price per unit for each category**:
```sql
select 
      category,
      round(AVG(price_per_unit),2) as avg_price_per_unit
      from retails_sales
      group by category
      order by avg_price_per_unit DESC;
```
## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


