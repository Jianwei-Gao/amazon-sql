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

-- There is a duplicated row, but unsure if it's actual duplicated row or repeated purchase
Select * FROM rowed_cte
Where row_num > 1;

-- Get items purchased and the revenue from each year-month
SELECT EXTRACT(YEAR_MONTH FROM order_date) as order_month_year,
	SUM(quantity) AS purchases,
	SUM(unit_price * quantity) AS revenue 
FROM computer_purchases 
GROUP BY EXTRACT(YEAR_MONTH FROM order_date)
ORDER BY order_month_year;

Select Distinct item_title From computer_purchases
order by item_title


