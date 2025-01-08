DROP DATABASE IF EXISTS Amazon_Data;
CREATE DATABASE Amazon_Data;
USE Amazon_Data;

DROP TABLE IF EXISTS purchases;
CREATE TABLE purchases(
	order_date Date NULL,
    unit_price DOUBLE NULL,
    quantity DOUBLE NULL,
    destination_state TEXT NULL,
    item_title TEXT NULL,
    product_code TEXT NULL,
    category TEXT NULL,
    survey_response_id TEXT NULL
);

Load Data Infile 'C:/Users/Jianwei/Desktop/SQL/Amazon purchase/amazon-purchases.csv'
Into Table purchases
Fields Terminated By ','
Enclosed By '"'
Lines Terminated By '\n'
Ignore 1 lines
(@order_date, unit_price, quantity, 
destination_state, item_title, product_code, 
category, survey_response_id)
Set 
	order_date = NULLIF(@order_date, ''),
    order_date = STR_TO_DATE(@order_date, '%Y-%m-%d'),
    unit_price = NULLIF(unit_price, ''),
    quantity = NULLIF(quantity, ''),
    destination_state = NULLIF(destination_state, ''),
    item_title = NULLIF(item_title, ''),
    product_code = NULLIF(product_code, ''),
    category = NULLIF(category, ''),
    survey_response_id = NULLIF(survey_response_id, '');
