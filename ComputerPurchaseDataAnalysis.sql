USE Amazon_Data;

-- Check for duplicated data
With rowed_cte AS(
	Select *,
	ROW_NUMBER() OVER( 
		PARTITION BY order_date, unit_price, quantity, 
		destination_state, item_title, product_Code, 
		category, survey_response_id) AS row_num
	FROM computer_purchases
)

-- There is a duplicated row, but unsure if it's actual duplicated row or repeated purchase so I'll keep it
Select * FROM rowed_cte
Where row_num > 1;

-- Check for rows with null values
-- There is rows with null in destination state column
Select * FROM computer_purchases
WHERE order_date IS NULL OR unit_price IS NULL OR quantity IS NULL
	OR destination_state IS NULL OR item_title IS NULL OR product_Code IS NULL
	OR category IS NULL OR survey_response_id IS NULL;

-- Check relationship between revenue and how many uses amazon in a household
SELECT 
	howmany_use_amazon,
    SUM(unit_price * quantity) AS revenue
    FROM computer_purchases
    INNER JOIN household_info
		ON computer_purchases.survey_response_id = household_info.id
	GROUP BY howmany_use_amazon;
    
-- Get items purchased and the revenue from each year-month
-- Rank each month's sales in their respective years
With sales_yearmonth AS(
	SELECT DATE_FORMAT(order_date, '%Y-%m-01') as order_month_year,
		SUM(quantity) AS purchases,
		SUM(unit_price * quantity) AS revenue
	FROM computer_purchases 
	GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')),

sales_ranked AS(
	SELECT order_month_year, purchases, revenue,
		DENSE_RANK() OVER (PARTITION BY EXTRACT(YEAR FROM order_month_year) ORDER BY revenue DESC) AS sales_rank,
        SUM(revenue) OVER (PARTITION BY EXTRACT(YEAR FROM order_month_year) ORDER BY EXTRACT(MONTH FROM order_month_year)) AS revenue_over_time
	FROM sales_yearmonth
)
    
Select DATE_FORMAT(order_month_year, '%Y-%m') as order_time, 
	purchases, revenue, sales_rank, revenue_over_time
    FROM sales_ranked
ORDER BY order_month_year;

-- Get the item purchased and revenue of specific different company
SELECT purchases, revenue, company FROM(
	SELECT SUM(quantity) AS purchases, SUM(unit_price * quantity) AS revenue, 'HP' AS company
	FROM computer_purchases
	WHERE item_title LIKE '%HP %'
	UNION
	SELECT SUM(quantity) AS purchases, SUM(unit_price * quantity) AS revenue, 'Lenovo' AS company
	FROM computer_purchases
	WHERE item_title LIKE '%Lenovo%'
	UNION
	Select SUM(quantity) AS purchases, SUM(unit_price * quantity) AS revenue, 'Acer' AS company
	FROM computer_purchases
	WHERE item_title LIKE '%Acer%'
) AS company_sales;


