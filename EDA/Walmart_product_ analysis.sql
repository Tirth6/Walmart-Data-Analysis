/*-------------- PRODUCT ANALYSIS --------------- */

use walmart_sales_data;

Select * from walmart_staging;

# Highest sales in product line
SELECT 
    product_line, ROUND(SUM(total), 2) AS highest_sales
FROM
    walmart_staging
GROUP BY product_line
ORDER BY highest_sales DESC;

# Avergae unit price per product line
SELECT 
    product_line, ROUND(AVG(unit_price), 2) AS Avg_unit_price
FROM
    walmart_staging
GROUP BY product_line
ORDER BY Avg_unit_price;

# Product_line with highest customer rating
SELECT 
    product_line, AVG(rating) AS highest_rating
FROM
    walmart_staging
GROUP BY product_line
ORDER BY highest_rating DESC;

select * from walmart_staging;

# Significant difference in gross income ** python/Anova 
SELECT 
    product_line, ROUND(AVG(gross_income), 2) AS Avg_income_diff
FROM
    walmart_staging
GROUP BY product_line
ORDER BY Avg_income_diff DESC;

#product which sold highest quantity
SELECT 
    product_line, SUM(quantity) AS Quantity_sold
FROM
    walmart_staging
GROUP BY product_line
ORDER BY Quantity_sold DESC;


#most purchased product_line by gender / use in python
with gender_ranked_product as(

select 
  product_line,
  gender,
  count(*) As Purchase_count,     #counts the no.of times products purchased by gender  
rank() over(partition by gender order by count(*) desc) as rank_by_gender    # Ranks the products from most to least by gender.  
 from walmart_staging
group by product_line, gender) 

SELECT 
    gender, product_line, purchase_count, rank_by_gender
FROM
    gender_ranked_product
ORDER BY gender , rank_by_gender; 

#Price difference between branches for same product line.

with avg_price_per_branch as(
SELECT 
    branch,
    product_line,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM
    walmart_staging
GROUP BY branch , product_line
       ),
       ranked_price as (
SELECT
      branch,
      product_line,
      avg_unit_price,
      rank() over(partition by product_line order by avg_unit_price) as price_rank
FROM
     avg_price_per_branch
)      
    
SELECT 
    *
FROM
    ranked_price
ORDER BY product_line , price_rank;    






