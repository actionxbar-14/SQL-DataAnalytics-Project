

USE
DataWarehouseAnalytics



/* ======================================================
-- :: Database Exploration : 
====================================================== */



-- ## Identify Columns As Dimensions & Measures : 



SELECT 
     DISTINCT category   -- Dimension
FROM gold.dim_products



SELECT 
     DISTINCT sales_amount  -- Measure
FROM gold.fact_sales





-- Explore All Objects in the Database :



USE
DataWarehouse


SELECT * FROM INFORMATION_SCHEMA.TABLES








-- Explore All Columns in the Database : 

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'


--------------------------------------------------------------------------------------------------------------------------------------

/*
======================================================
-- :: Dimensions Exploration : 
======================================================
*/

-- Explore all the countries our customers come from :

SELECT
     DISTINCT country 
FROM gold.dim_customers



-- Explore All Categories "The major Divisions" : 

SELECT 
     DISTINCT category  ,
     subcategory,
     product_name
FROM gold.dim_products
ORDER BY 1 ,2 ,3








--------------------------------------------------------------------------------------------------------------------------------------

/*
======================================================
-- :: Date Exploration : 
======================================================
*/



-- Find the date of the first and last order. 
-- How many years of sales are available. 
SELECT 
     MIN(order_date) As first_order_date,
     MAX(order_date) As last_order_date ,
     DATEDIFF( year , MIN(order_date) , MAX(order_date) ) As order_range_years 
FROM gold.fact_sales


-- Find the youngest and the oldest customer. 

SELECT 
     MIN(birthdate) As oldest_birthdate,
     DATEDIFF(year , MIN(birthdate), GETDATE() ) As oldest_age , 
     MAX(birthdate) As youngest_birthdate ,
     DATEDIFF(year , MAX(birthdate) , GETDATE() ) As youngest_age
FROM gold.dim_customers











--------------------------------------------------------------------------------------------------------------------------------------

/*
======================================================
-- :: Measure Exploration : 
======================================================
*/

-- Find the Total sales. 

SELECT 
     SUM(sales_amount) AS total_Sales 
FROM gold.fact_sales



-- Find how many items are sold.

SELECT 
     SUM(quantity) AS total_quantity 
FROM gold.fact_sales



-- Find the average selling price. 

SELECT 
     AVG(price) AS AVG_price
FROM gold.fact_sales





-- Find the Total number of Orders.

SELECT 
     COUNT(order_number) AS total_orders
FROM gold.fact_sales


-- Find the Total number of Unique Orders.
SELECT 
     COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales



-- Find the Total number of Products. 

SELECT 
     COUNT(product_key) AS total_products 
FROM gold.dim_products


-- Find the Total number of Unique Products. 

SELECT 
     COUNT(DISTINCT product_key) AS total_products 
FROM gold.dim_products





-- Find the Total number of customers. 

SELECT 
     COUNT(customer_key) AS total_customers 
FROM gold.dim_customers 





-- Find the total number of customers that has placed an order.

SELECT 
     COUNT(customer_key) AS total_customers 
FROM gold.fact_sales 


-- Find the total number of Unique customers that has placed an order.


SELECT 
     COUNT(DISTINCT customer_key) AS total_customers 
FROM gold.fact_sales 








-- Generate a Report that shows all key metrices of the business. 



SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;











--------------------------------------------------------------------------------------------------------------------------------------





/*
======================================================
-- :: Magnitude Analysis : 
======================================================
*/



-- Find total Customers by countries.

SELECT 
     country,
     COUNT(customer_key) AS total_customers 
FROM gold.dim_customers 
GROUP BY country
ORDER BY total_customers DESC



-- Find total customers by gender. 


SELECT 
     gender,
     COUNT(customer_key) AS total_customers 
FROM gold.dim_customers 
GROUP BY gender
ORDER BY total_customers DESC




-- Find total products by category. 

SELECT 
     category,
     COUNT(product_key) AS total_products 
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC





-- What is the average costs in each category ?

SELECT 
     category,
     AVG(cost) AS avg_cost
FROM gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC







-- What is the total revenue generated for each cactegory ?

SELECT 
     p.category,
     SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales as f
LEFT JOIN 
gold.dim_products as p
ON
f.product_key = p.product_key
GROUP BY category
ORDER BY total_revenue DESC





-- Find the total revenue that is generated by each customer. 


SELECT 
     c.customer_key,
     c.first_name,
     c.last_name,
     SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales as f
LEFT JOIN 
gold.dim_customers as c
ON
f.customer_key = c.customer_key
GROUP BY c.customer_key , c.first_name , c.last_name
ORDER BY total_revenue DESC




-- What is the distribution of sold items across countries ?




SELECT 
     c.country,
     SUM(f.quantity) AS total_sold_itmes
FROM gold.fact_sales as f
LEFT JOIN 
gold.dim_customers as c
ON
f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_sold_itmes DESC









--------------------------------------------------------------------------------------------------------------------------------------





/*
======================================================
-- :: Ranking Analysis : 
======================================================
*/






-- Which 5 Product generate the highest revenue ?


SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN 
gold.dim_products p
ON 
p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;




-- What are the 5 worst-performing products in terms of sales?

SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN 
gold.dim_products p
ON
p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue;






-- Complex but Flexibly Ranking Using Window Functions : 

SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
    FROM gold.fact_sales f
    LEFT JOIN 
    gold.dim_products p
    ON
    p.product_key = f.product_key
    GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;





--------------------------------------------------------------------------------------------------------------------------------------



/*
======================================================
-- :: Change Over Time Analysis : 
======================================================
*/


-- Analyze Sales Performance Over Time : 

-- Year
SELECT 
     YEAR(order_date) As order_year,
     SUM(sales_amount) As Total_Sales,
     COUNT( DISTINCT customer_key ) As total_customers,
     SUM(quantity) As total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)



-- Year + Month
SELECT 
     YEAR(order_date) As order_year,
     DATENAME(MONTH , order_date) As month_name,
     SUM(sales_amount) As Total_Sales,
     COUNT( DISTINCT customer_key ) As total_customers,
     SUM(quantity) As total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date) , DATENAME(MONTH , order_date)
ORDER BY YEAR(order_date)





-- Combined Date Using DATETRUNC : 

SELECT 
     DATETRUNC(month , order_date) As order_date,
     SUM(sales_amount) As Total_Sales,
     COUNT( DISTINCT customer_key ) As total_customers,
     SUM(quantity) As total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month , order_date)
ORDER BY DATETRUNC(month , order_date)







--------------------------------------------------------------------------------------------------------------------------------------



/*
======================================================
-- :: Cumulative Analysis : 
======================================================
*/



-- Calculate the total sales per month and the running total of sales over time. [ Running Total ] 

SELECT
     order_date,
     total_sales,
     SUM(total_sales) OVER(ORDER BY order_date) As running_total_sales
FROM(
SELECT 
     DATETRUNC(year , order_date) As order_date,
     SUM(sales_amount) As Total_Sales,
     COUNT( DISTINCT customer_key ) As total_customers,
     SUM(quantity) As total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year , order_date)
)t






-- Calculate the total sales per month and the running total of sales over time. [ Moving Average ] 


SELECT
     order_date,
     total_sales,
     SUM(total_sales) OVER(ORDER BY order_date) As running_total_sales,
     AVG(total_sales) OVER(ORDER BY order_date) As moving_avarage_price 
FROM(
SELECT 
     DATETRUNC(year , order_date) As order_date,
     SUM(sales_amount) As Total_Sales,
     COUNT( DISTINCT customer_key ) As total_customers,
     SUM(quantity) As total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year , order_date)
)t








--------------------------------------------------------------------------------------------------------------------------------------



/*
======================================================
-- :: Performance Analysis : 
======================================================
*/


/*
Analyze the yearly performance of products by comparing each product's sales to both its average sales performance 
and the previous year's sales. [ YoY Analysis ]

*/



WITH yearly_product_sales As (
SELECT 
     YEAR(f.order_date) As order_year,
     p.product_name,
     SUM(f.sales_amount) As current_sales
FROM gold.fact_sales As f 
LEFT JOIN 
gold.dim_products AS p 
ON 
f.product_key = p.product_key  
WHERE f.order_date IS NOT NULL
GROUP BY YEAR(f.order_date), p.product_name
) 

SELECT 
     order_year,
     product_name,
     LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) As Py_sales,
     current_sales,
     AVG(current_sales) OVER(PARTITION BY product_name) As avg_sales,
     current_sales - AVG(current_sales) OVER(PARTITION BY product_name) As diff_py, 
     CASE 
        WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No change'
    END As py_change,
     current_sales - AVG(current_sales) OVER(PARTITION BY product_name) As diff_avg,
     CASE 
        WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above AVG'
        WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below AVG'
        ELSE 'Avg'
    END As avg_change
FROM yearly_product_sales
ORDER BY product_name , order_year









--------------------------------------------------------------------------------------------------------------------------------------



/*
======================================================
-- :: Part-to-Whole Analysis : 
======================================================
*/




-- Which categories contribute the most to overall sales ?


WITH category_sales AS (
SELECT 
     category,
     SUM(sales_amount) As total_sales
FROM gold.fact_sales As f  
LEFT JOIN 
gold.dim_products AS p 
ON 
p.product_key = f.product_key
GROUP BY category
)

SELECT
     category,
     total_sales,
     SUM(total_sales) OVER() As Overall_Sales,
     CONCAT(ROUND((CAST (total_sales AS FLOAT) / SUM(total_sales) OVER()) * 100 , 2) , '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC








--------------------------------------------------------------------------------------------------------------------------------------



/*
======================================================
-- :: Data Segmentation Analysis : 
======================================================
*/


-- Segment products into cost ranges and count how many products fall into each segment. 


WITH product_segments AS (
SELECT 
     product_key,
     product_name,
     cost,
     CASE 
        WHEN cost < 100 THEN 'Below 100' 
        WHEN cost BETWEEN 100 AND 500 THEN '100 - 500'
        WHEN cost BETWEEN 500 AND 1000 THEN '500 - 1000'
        ELSE 'Above 1000'
    END AS cost_range
FROM gold.dim_products
)


SELECT 
     cost_range,
     COUNT(product_key) As total_products
FROM product_segments 
GROUP BY cost_range
ORDER BY total_products DESC








/*

--> Group customers into three segments based on their spending behavior :
 1. VIP : At least 12 months of history and spending( Sales ) more than $5000.
 2. Regular : At least 12 months of history but spending( Sales ) $5000 or less. 
 3. New : lifespan less than 12 months. 

 - And find the total number of custommers by each group. 

 */


WITH customer_spending AS (
SELECT 
     c.customer_key,
     SUM(f.sales_amount) AS total_Spending,  
     MIN(order_date) AS first_order,
     MAX(order_date) AS last_order,
     DATEDIFF(month , MIN(order_Date) , MAX(order_date)) AS lifespan
FROM gold.fact_sales AS f 
LEFT JOIN 
gold.dim_customers AS c 
ON 
f.customer_key = c.customer_key
GROUP BY c.customer_key
)


SELECT 
     customer_segment,
     COUNT(customer_key) As total_customers 
FROM (
    SELECT 
         customer_key,
         total_spending,
         lifespan,
         CASE 
            WHEN lifespan > 12 AND total_Spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_Spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
)t
GROUP BY customer_segment
ORDER BY total_customers DESC









--------------------------------------------------------------------------------------------------------------------------------------



/*
======================================================
-- :: Customer Report : 
======================================================
*/








/*
===============================================================================
:: Customer Report
===============================================================================

:: Purpose:
    - This report consolidates key customer metrics and behaviors

:: Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
       - total orders
       - total sales
       - total quantity purchased
       - total products
       - lifespan (in months)
    4. Calculates valuable KPIs:
        - recency (months since last order)
        - average order value
        - average monthly spend

===============================================================================
*/








----------------------------------------------------

IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS





WITH base_query AS(

/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
SELECT
    f.order_number,
    f.product_key,
    f.order_date,
    f.sales_amount,
    f.quantity,
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    DATEDIFF(year, c.birthdate, GETDATE()) age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
WHERE order_date IS NOT NULL)








, customer_aggregation AS (

/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    COUNT(DISTINCT order_number)                      AS total_orders,
    SUM(sales_amount)                                 AS total_sales,
    SUM(quantity)                                     AS total_quantity,
    COUNT(DISTINCT product_key)                       AS total_products,
    MAX(order_date)                                   AS last_order_date,
    DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query
GROUP BY
    customer_key,
    customer_number,
    customer_name,
    age
)
SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    CASE
        WHEN age IS NULL THEN 'n/a'
        WHEN age < 20 THEN 'Under 20'
        WHEN age between 20 and 29 THEN '20-29'
        WHEN age between 30 and 39 THEN '30-39'
        WHEN age between 40 and 49 THEN '40-49'
        ELSE '50 and above'
    END                                         AS age_group,
    CASE
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END                                         AS customer_segment,
    last_order_date,
    DATEDIFF(month, last_order_date, GETDATE()) AS recency,
    total_orders,
    total_sales,
    total_quantity,
    total_products,
    lifespan,
    -- Compute average order value (AOV)
    CASE WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_value,
    -- Compute average monthly spend
    CASE WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_spend
FROM customer_aggregation




------> Data segmentation on customer report :


SELECT 
     age_group ,
     COUNT(customer_number) As total_customers,
     SUM(total_sales) As total_sales
FROM gold.report_customers
GROUP BY age_group








--------------------------------------------------------------------------------------------------------------------------------------




/*
===============================================================================
:: Product Report
===============================================================================



Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/





/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO






CREATE VIEW gold.report_products AS



WITH base_query AS(
    SELECT
         f.order_number,
         f.order_date,
         f.customer_key,
         f.sales_amount,
         f.quantity,
         p.product_key,
         p.product_name,
         p.category,
         p.subcategory,
         p.cost
    FROM gold.fact_sales As f
    LEFT JOIN 
    gold.dim_products As p 
    ON 
    f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
)




, product_aggregations AS (


/*---------------------------------------------------------------------------
2) Product Aggregations: Summarizes key metrics at the product level
---------------------------------------------------------------------------*/
SELECT 
     product_key,
     product_name,
     category,
     subcategory,
     cost,
     DATEDIFF(MONTH , MIN(order_date) , MAX(order_date)) AS lifespan,
     MAX(order_date) AS last_sale_date,
     COUNT(DISTINCT order_number) AS total_orders,
     COUNT(DISTINCT customer_key) AS total_customers,
     SUM(sales_amount) As total_sales,
     SUM(quantity) As total_quantity,
     ROUND(AVG( CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)) , 1) AS avg_selling_price
     -- ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)),1) AS avg_selling_price
FROM base_query
GROUP BY 
product_key,
product_name,
category,
subcategory,
cost

)






/*---------------------------------------------------------------------------
  3) Final Query: Combines all product results into one output
---------------------------------------------------------------------------*/


SELECT 
     product_key,
     product_name,
     category,
     subcategory,
     cost,
     last_sale_date,
     DATEDIFF(MONTH , last_sale_date , GETDATE()) AS recency_in_months,
     CASE 
        WHEN total_sales > 50000 THEN 'High-Performer'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,
    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,

    -- Average Order Revenue ( AOR )
    CASE 
       WHEN total_sales = 0 THEN 0 
       ELSE total_sales / total_orders
    END AS avg_order_revenue,

    -- Average Monthly Revenue 
    CASE 
       WHEN lifespan = 0 Then total_sales
       ELSE total_sales / lifespan 
    END AS avg_monthly_revenue

FROM product_aggregations





SELECT 
     * 
FROM gold.report_products



