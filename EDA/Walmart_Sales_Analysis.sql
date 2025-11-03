/*---------------- SALES ANALYSIS ---------------*/

Use walmart_sales_data;

# Which brand generates most revenue
SELECT 
    product_line, ROUND(SUM(total), 2) AS total_revenue
FROM
    walmart_staging
GROUP BY product_line
ORDER BY total_revenue DESC;

select * from walmart_staging;

# Daily average sales accross dataset 
SELECT 
     `Date`,
    product_line, ROUND(AVG(total), 2) AS Avg_daily_sales
FROM
    walmart_staging
GROUP BY `Date`, product_line
ORDER BY `Date` DESC;

/* My approach to calculate sales by (morning, Afternoon and evening).
With Morning_sales as( 
select time, product_line, round(sum(total),2) as total_sales from walmart_staging
Where time between '06:00:00' and '12:00:00' 
Group by time, product_line
),

After_noon_sales as (
select time, product_line, round(sum(total),2) as total_sales from walmart_staging
Where time between '12:00:00' and '17:00:00' 
Group by time, product_line
),

Evening_sales as(
select time, product_line, round(sum(total),2) as total_sales from walmart_staging
Where time between '17:00:00' and '21:00:00' 
Group by time, product_line
)
SELECT 
    M.product_line,
    ROUND(SUM(M.total_sales), 2) AS morning_sales,
    ROUND(SUM(A.total_sales), 2) AS After_noon_sales,
    ROUND(SUM(E.total_sales), 2) AS Evening_sales
FROM
    morning_sales M
        JOIN
    After_noon_sales A ON M.product_line = A.product_line
        JOIN
    Evening_sales E ON A.product_line = E.product_line
GROUP BY M.product_line
ORDER BY morning_sales , After_noon_sales , Evening_sales DESC; */

#  What time of day are most sales made 
# Alternate approach 
With sales_time as(
   select product_line,
     Case
         when time between '06:00:00' and '12:00:00' Then 'morning'
         when time between '12:00:00' and '17:00:00' Then 'After_noon'
         when time between '17:00:00' and '21:00:00' Then 'Evening'
     End Time_of_day,
     total
     from walmart_staging
)
select 
     product_line,
     Round(sum(case when time_of_day = 'morning' then total else 0 End),2) as morning_sales,
     Round(sum(case when time_of_day = 'After_noon' then total else 0 End),2) as After_noon_sales,
     Round(sum(case when time_of_day = 'Evening' then total else 0 End),2) as Evening_sales
from sales_time     
Group by product_line
order by morning_sales desc, After_noon_sales desc, Evening_sales desc;

select * from Walmart_staging;

# Average gross income per transaction.
select Round(Avg(gross_income),2) As Avg_gross_income from walmart_staging;

# Tax collected on average per product_line 
Select product_line, Round(avg(Tax_5_percent),2) as Avg_Tax from walmart_staging
Group by product_line
order by Avg_Tax desc;

# specific days when sales spike 
WITH sales_by_day AS (
    SELECT 
        Product_line,
        DAYNAME(Date) AS day_of_week,
        ROUND(SUM(Total), 2) AS total_sales
    FROM walmart_staging
    GROUP BY Product_line,day_of_week
)
SELECT *
FROM sales_by_day
ORDER BY total_sales DESC;

select * from walmart_staging;

# payment method used most frequently.
select payment, Count(payment) as Most_used_payment  from walmart_staging
group by payment
order by Most_used_payment desc;




     
     

