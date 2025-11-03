/* ---------------- Customer Analysis -----------------*/

Select * from walmart_staging;

select Distinct Customer_type from walmart_staging;

# Do members spend more than non-members on average
select customer_type, Round(Avg(total),2) as Avg_spend from walmart_staging
Group by customer_type; 

# Significant difference in total spening in male and female.  ## python analysis
select Gender, Round(avg(total),2) as total_spending from walmart_staging
Group by gender;  

# Which city has most highest number of customers
select city, count(invoice_id) as number_of_customers from walmart_staging
Group by city; 

select * from walmart_staging;

# Do customer types prefer different payments menthod.
select distinct Customer_type, payment, Count(payment) as payment_method  from walmart_staging
Group by Customer_type, payment
order by Customer_type;

# Avg rating given by male and female customers.
select gender, Round(avg(rating),2)  as Avg_rating from walmart_staging
group by gender
order by Avg_rating desc;

# Do customer types prefer different product lines 
select customer_type, product_line, Count(product_line) as Product_preference from walmart_staging
group by  customer_type, product_line
order by customer_type;

# Which gender gives higher average ratings
select Gender, Round(Avg(rating),2) as Higher_rating from walmart_staging
group by gender
order by higher_rating desc; 








