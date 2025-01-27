USE Amazon_Data;

-- I am interested in the sub-dataset on purchases of (whole) computers and phones 
-- Find the categories that's replated to computer or phone
SELECT DISTINCT category FROM purchases
WHERE category LIKE '%computer%';
    
-- Extract data to be put into a subtable
DROP TABLE IF EXISTS computer_phone_data;
CREATE TABLE computer_phone_data AS(
SELECT order_date, unit_price, quantity, 
destination_state, item_title, product_Code, 
category, survey_response_id
FROM purchases
Where category = 'PERSONAL_COMPUTER'
	OR category = 'Personal Computers'
	OR category = 'NOTEBOOK_COMPUTER');