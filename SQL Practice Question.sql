-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;
use walmartSales;
-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating DECIMAL(3,1)
);


-- upload the csv file to _secure_file_prev location (i.e- C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/) directory.
LOAD DATA  INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/walmart_dataset.csv' INTO TABLE sales FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;


-- Answer the  questions.
   select * from sales;
   
   -- Questions
   
-- Generic Question
-- 1.How many unique cities does the data have?
select distinct(city) from sales;

-- 2.In which city is each branch?
select count(branch) from sales
group by city;

-- Product question
-- 1.How many unique product lines does the data have?
select distinct(product_line) from sales;

-- 2. What is the most common payment method?
select count(payment),payment from sales
group by payment order by count(payment) desc;

-- 3. What is the most selling product line?
select count(product_line),product_line from sales
group by product_line order by count(product_line) desc;

-- 4.What is the total revenue by month?
select sum(total),extract(month from date) from sales
group by extract(month from date);

-- 5. What month had the largest COGS?
select month(date), sum(cogs) from sales 
group by month(date) order by sum(cogs) desc;

-- 6.
-- What product line had the largest revenue?
select sum(total),product_line from sales
group by product_line order by sum(total) desc;

-- 7 What is the city with the largest revenue?
select sum(total),city from sales
group by city order by sum(total) desc;

-- 8 What product line had the largest VAT?
select sum(tax_pct),product_line from sales
group by product_line order by sum(tax_pct) desc;

-- 9.Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select product_line,
case
when total>(select avg(total) from sales) then 'Good'
else 'Bad'
end as sales_behavior
from sales;

-- 10.Which branch sold more products than average product sold?
select * from sales;
select count(total),branch from sales
where count(total)>(select avg(total) from sales)
group by branch;

-- 11 What is the most common product line by gender?
select gender,product_line,count(gender) from sales
group by product_line,gender order by count(gender) desc ;


-- 12 What is the average rating of each product line?
select product_line,avg(rating) from sales
group by product_line;



-- Sales
-- 1 Number of sales made in each time of the day per weekday
select time_of_day, sum(total) from (select * ,
case
when time >'12:00:00' and time < '16:00:00' then 'afternoon'
when time >'16:00:00' and time < '23:59:01' then 'evening'
when time >'01:00:00' and time < '12:00:00' then 'morning'
end as time_of_day
from sales) as new
group by time_of_day;

-- 2 Which of the customer types brings the most revenue?
select sum(total),customer_type  from sales
group by customer_type order by  sum(total) desc;

-- 3.Which city has the largest tax percent/ VAT (Value Added Tax)?
select sum(tax_pct),city from sales 
group by city order by sum(tax_pct) desc;

-- 4. Which customer type pays the most in VAT?
select sum(tax_pct),customer_type from sales 
group by customer_type order by sum(tax_pct) desc;



-- Customer
-- q1. How many unique customer types does the data have?
select count(distinct customer_type) as unique_customer_count from sales;


-- q2. How many unique payment methods does the data have?
select count(distinct payment) as unique_payment_count from sales;

-- q3. What is the most common customer type?
select customer_type,count(customer_type) from sales
group by customer_type order by count(customer_type) desc;

-- q4. Which customer type buys the most?
select * from sales;
select max(buyer_count)from (select customer_type,count(customer_type) as buyer_count from sales
group by customer_type);

-- q5 What is the gender of most of the customers?
select * from sales;
select gender,count(gender) from sales
group by gender order by count(gender) desc;

-- q6 What is the gender distribution per branch?
select branch,gender,count(gender) from sales
group by branch,gender order by branch asc;

-- q7 Which time of the day do customers give most ratings?
select time_of_day, count(rating) from (select * ,
case
when time >'12:00:00' and time < '16:00:00' then 'afternoon'
when time >'16:00:00' and time < '23:59:01' then 'evening'
when time >'01:00:00' and time < '12:00:00' then 'morning'
end as time_of_day
from sales) as new
group by time_of_day;

-- q8. Which time of the day do customers give most ratings per branch?
select branch,time_of_day, count(rating) from (select * ,
case
when time >'12:00:00' and time < '16:00:00' then 'afternoon'
when time >'16:00:00' and time < '23:59:01' then 'evening'
when time >'01:00:00' and time < '12:00:00' then 'morning'
end as time_of_day
from sales) as new
group by time_of_day,branch order by branch asc;

-- q9. Which day fo the week has the best avg ratings?
select dayofweek(date),rating from sales
where rating>(select avg(rating) from sales)
order by rating desc limit 1;


-- q.10 Which day of the week has the best average ratings per branch?
select dayofweek(date),sum(rating),branch from sales
where rating>(select avg(rating) from sales)
group by branch,dayofweek(date);



