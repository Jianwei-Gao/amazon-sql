USE amazon_data;

-- Convert howmany_use_amazon and household_size column from string to integer
-- Integer 4 indicates either 4 or more person as per the original value 4+
DROP TABLE IF EXISTS household_info;
CREATE TABLE household_info AS(
	SELECT survey_response_id AS id,
		CASE 
			WHEN howmany_use_amazon LIKE '1 (just me!)' THEN 1
			WHEN howmany_use_amazon LIKE '2' THEN 2
			WHEN howmany_use_amazon LIKE '3' THEN 3
            ELSE 4
		END AS howmany_use_amazon,
        CASE 
			WHEN household_size LIKE '1 (just me!)' THEN 1
			WHEN household_size LIKE '2' THEN 2
			WHEN household_size LIKE '3' THEN 3
            ELSE 4
		END AS household_size
    FROM survey
);

SELECT * FROM household_info; 

-- pivot the life_changes column into its individual value columns 
DROP TABLE IF EXISTS life_changes_pivoted;
CREATE TABLE life_changes_pivoted AS(
	SELECT survey_response_id AS id,
		CASE
			WHEN life_changes IS NULL THEN 1
            ELSE 0
		END AS noLifeChanges,
		CASE
			WHEN life_changes like '%Became pregnant%' THEN 1
			ELSE 0
		END AS pregnant,
        CASE
			WHEN life_changes like '%Divorce%' THEN 1
			ELSE 0
		END AS divorce,
        CASE
			WHEN life_changes like '%Had a child%' THEN 1
			ELSE 0
		END AS hadChild,
        CASE
			WHEN life_changes like '%Lost a job%' THEN 1
			ELSE 0
		END AS lostJob,
        CASE
			WHEN life_changes like '%Moved place of residence%' THEN 1
			ELSE 0
		END AS moved
	FROM survey
);

SELECT * FROM life_changes_pivoted;