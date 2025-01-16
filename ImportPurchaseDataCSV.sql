-- importing the amazon-purchases csv into a table

USE Amazon_Data;

DROP TABLE IF EXISTS purchases;
CREATE TABLE purchases(
	order_date DATE NULL,
    unit_price DOUBLE NOT NULL,
    quantity DOUBLE NOT NULL,
    destination_state TEXT NULL,
    item_title TEXT NULL,
    product_code TEXT NULL,
    category TEXT NULL,
    survey_response_id VARCHAR(64) NOT NULL
);

LOAD DATA INFILE "C:/Users/Jianwei/Desktop/SQL/amazon-sql/amazon-purchases.csv"
INTO TABLE purchases
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@order_date, unit_price, quantity, 
destination_state, item_title, product_code, 
category, survey_response_id)
SET 
	survey_response_id = NULLIF(survey_response_id,''), -- column have constaint NOT NULL, but this checks if csv file have any NULL inputs that needed to be handled
	order_date = NULLIF(@order_date, ''),
    order_date = STR_TO_DATE(@order_date, '%Y-%m-%d'),
	-- unit_price = NULLIF(unit_price, ''),
    -- quantity = NULLIF(quantity, ''),
    destination_state = NULLIF(destination_state, ''),
    item_title = NULLIF(item_title, ''),
    product_code = NULLIF(product_code, ''),
    category = NULLIF(category, '');