# Data cleaning steps ( Create samaple tables and then work on it)
-- 1. Remove duplicates
-- 2. Standardize data(spelling, trim)
-- 3. Null values or blank values(populate)
-- 4. Remove any column(delete if confident and column of no use ahead)   




create table walmart_data(
Invoice_id varchar(50),
Branch varchar(10),
City varchar(100),
Customer_type varchar(100),
Gender varchar(50),
Product_line varchar(250),
Unit_price double,
Quantity int,
Tax_5_percent double,
Total float,
Date text,
Time Time,
Payment varchar(100),
Cogs double,
Gross_margin_percentage double,
Gross_income double,
Rating float);

select * from walmart_data;

insert into walmart_data
select * from walmartsalesdata;

 select *,
 row_number() over(partition by Invoice_id, product_line,unit_price,Quantity, Tax_5_percent,Cogs, Gross_margin_percentage,
 Gross_income,`Date`, `Time` ) as row_num
 from walmart_data;
 
with duplicate_cte as( 
select *,
 row_number() over(partition by Invoice_id, branch, city, gender, product_line,unit_price,Quantity, Tax_5_percent,Cogs, Gross_margin_percentage,
 Gross_income,`Date`, `Time` ) as row_num
 from walmart_data
)
select * from duplicate_cte
where row_num > 1; 

use walmart_sales_data;
select * from walmart_data;

select Tax_5_percent, round(Tax_5_percent,2) as round_value
from walmart_data; 

update walmart_data
set Tax_5_percent = round(Tax_5_percent,2);

select distinct city
from walmart_data
order by 1;
  
select Gross_margin_percentage, round(Gross_margin_percentage,2) as round_value
from walmart_data; 

update walmart_data
set Gross_margin_percentage = round(Gross_margin_percentage,2);

# issue fixing
UPDATE walmart_data wd
JOIN walmartsalesdata ws ON wd.Invoice_id = ws.`Invoice ID`
SET wd.Total = ws.Total;

select * from walmart_data;

select Gross_income, round(Gross_income,2) as round_value
from walmart_data;

update walmart_data
set Gross_income = round(Gross_income,2);

select `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') as prpr_date
from walmart_data;  

update walmart_data
set `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
 
Alter table walmart_data
modify `Date` date; 

SHOW COLUMNS FROM walmart_data;  

create table walmart_staging
like walmart_data;

select * from walmart_staging;

insert into  walmart_staging
select * from walmart_data;

select * from walmart_staging
where branch is null;

# Explore data
select * from walmart_staging;























  
