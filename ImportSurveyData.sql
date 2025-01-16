-- importing the survey csv into a table


USE Amazon_Data;

DROP TABLE IF EXISTS survey;
CREATE TABLE survey(
	survey_response_id VARCHAR(64) PRIMARY KEY,
    age TEXT NULL,
    is_hispanic TEXT NULL,
    race TEXT NULL,
    education TEXT NULL,
    income TEXT NULL,
    gender TEXT NULL,
    sexual_orientation TEXT NULL,
    residential_state TEXT NULL,
    howmany_use_amazon TEXT NULL,
    household_size TEXT NULL,
    usage_freq TEXT NULL,
    use_cigarettes TEXT NULL,
    use_marijuana TEXT NULL,
    use_alcohol TEXT NULL,
    personal_diabetes TEXT NULL,
    personal_wheelchair TEXT NULL,
    life_changes TEXT NULL,
    q_sell_your_data TEXT NULL,
    q_sell_consumer_data TEXT NULL,
    q_small_biz_use TEXT NULL,
    q_census_use TEXT NULL,
    q_research_use TEXT NULL
);

LOAD DATA INFILE "C:/Users/Jianwei/Desktop/SQL/amazon-sql/survey.csv"
INTO TABLE survey
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(survey_response_id, age, is_hispanic, race, education, income, gender, 
sexual_orientation, residential_state, howmany_use_amazon, household_size, 
usage_freq, use_cigarettes, use_marijuana, use_alcohol, personal_diabetes, 
personal_wheelchair, life_changes, q_sell_your_data, q_sell_consumer_data, 
q_small_biz_use, q_census_use, q_research_use)
SET 
    age = NULLIF(age, ''),
    is_hispanic = NULLIF(is_hispanic, ''),
    race = NULLIF(race, ''),
    education = NULLIF(education, ''),
    income = NULLIF(income, ''),
    gender = NULLIF(gender, ''),
    sexual_orientation = NULLIF(sexual_orientation, ''),
    residential_state = NULLIF(residential_state, ''),
    howmany_use_amazon = NULLIF(howmany_use_amazon, ''),
    household_size = NULLIF(household_size, ''),
    usage_freq = NULLIF(usage_freq, ''),
    use_cigarettes = NULLIF(use_cigarettes, ''),
    use_marijuana = NULLIF(use_marijuana, ''),
    use_alcohol = NULLIF(use_alcohol, ''),
    personal_diabetes = NULLIF(personal_diabetes, ''),
    personal_wheelchair = NULLIF(personal_wheelchair, ''),
    life_changes = NULLIF(life_changes, ''),
    q_sell_your_data = NULLIF(q_sell_your_data, ''),
    q_sell_consumer_data = NULLIF(q_sell_consumer_data, ''),
    q_small_biz_use = NULLIF(q_small_biz_use, ''),
    q_census_use = NULLIF(q_census_use, ''),
    q_research_use = NULLIF(q_research_use, '');
    
    

