USE earthquake;

		-- Viewing the dataset
SELECT 
	*
FROM 
	earthquake_data;
    
		-- Saving a copy of the original dataset
Commit;

		-- Adding an id column
ALTER TABLE earthquake_data
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;


		-- Rounding up depth column
UPDATE earthquake_data 
SET 
    depth = ROUND(depth, 0);

SELECT 
    depth
FROM
    earthquake_data;

		-- splitting location column into town and country columns
SELECT 
    location,
    SUBSTRING_INDEX(location, ',', 1) AS town,
    SUBSTRING_INDEX(location, ',', - 1) AS country
FROM
    earthquake_data;
   
		-- adding town column into the database 
ALTER TABLE earthquake_data
ADD column town VARCHAR(255);

UPDATE earthquake_data 
SET 
    town = SUBSTRING_INDEX(location, ',', 1)
WHERE
    town IS NULL;

		-- updating country column
UPDATE earthquake_data 
SET 
    country = SUBSTRING_INDEX(location, ',', - 1);

UPDATE earthquake_data 
SET 
    country = 'Indonesia'
WHERE
    country = 'Flores sea';
        
        
		-- editing country column
UPDATE earthquake_data 
SET country = REPLACE(country, 'region','')
WHERE country LIKE '%region';

UPDATE earthquake_data 
SET country = REPLACE(country, '- Reunion','')
WHERE country = 'Mauritius - Reunion';

UPDATE earthquake_data 
SET country = REPLACE(country, 'Island','Islands')
WHERE country = 'Bouvet Island';

UPDATE earthquake_data 
SET country = REPLACE(country, 'Sandwich', '') 
WHERE country LIKE '%Sandwich%';

UPDATE earthquake_data 
SET country = REPLACE(country, 'the', '') 
WHERE country LIKE 'the%';

UPDATE earthquake_data 
SET country = 'Netherlands'
WHERE country LIKE 'NV%';

UPDATE earthquake_data 
SET country = 'Norway'
WHERE location LIKE '% Svalbard and Jan Mayen';

UPDATE earthquake_data 
SET country = 'Canada'
WHERE country = 'CA';

UPDATE earthquake_data 
SET country = 'France'
WHERE country LIKE 'Wallis and %';

UPDATE earthquake_data 
SET country = 'Fiji Islands'
WHERE country = 'Fiji';

UPDATE earthquake_data 
SET country = LTRIM(country);

SELECT 
    DISTINCT country
FROM
    earthquake_data;
    
		-- updating missing continents
SELECT 
    country,
    (CASE
        WHEN
            country IN ('Tonga' , 'Vanuatu',
                'Fiji Islands',
                'New Zealand',
                'Solomon Islands',
                'South  Islands',
                'Kermadac Islands',
                'Papua New Guinea',
                'New Caledonia',
                'Australia',
                'Loyalty Islands')
        THEN
            'Oceania'
        WHEN country IN ('Indonesia' , 'Japan', 'Philippines', 'Molucca sea', 'Timor Leste') THEN 'Asia'
        WHEN
            country IN ('Nicaragua' , 'Guatemala',
                'Panama',
                'El Salvador',
                'Alaska',
                'Mexico',
                'Prince Edward Islands',
                'Costa Rica',
                'Honduras',
                'Jamaica',
                'Canada',
                'Central Mid-Atlantic Ridge')
        THEN
            'North america'
        WHEN country = 'Russia' THEN 'Europe/Asia'
        WHEN country = 'Mauritius' THEN 'Africa'
        WHEN country IN ('France' , 'Greece', 'Norway') THEN 'Europe'
        WHEN country IN ('Chile' , 'Venezuela') THEN 'South America'
        WHEN country IN ('Kermadec Islands' , 'Bouvet Islands', 'South Shetland Islands') THEN 'Antartica'
        ELSE continent
    END) AS new_continent
FROM
    earthquake_data;

ALTER TABLE earthquake_data
ADD COLUMN new_continent Text;

UPDATE earthquake_data
SET new_continent =  (CASE
        WHEN
            country IN ('Tonga' , 'Vanuatu',
                'Fiji Islands',
                'New Zealand',
                'Solomon Islands',
                'South  Islands',
                'Kermadac Islands',
                'Papua New Guinea',
                'New Caledonia',
                'Australia',
                'Loyalty Islands')
        THEN
            'Oceania'
        WHEN country IN ('Indonesia' , 'Japan', 'Philippines', 'Molucca sea', 'Timor Leste') THEN 'Asia'
        WHEN
            country IN ('Nicaragua' , 'Guatemala',
                'Panama',
                'El Salvador',
                'Alaska',
                'Mexico',
                'Prince Edward Islands',
                'Costa Rica',
                'Honduras',
                'Jamaica',
                'Canada',
                'Central Mid-Atlantic Ridge')
        THEN
            'North america'
        WHEN country = 'Russia' THEN 'Europe/Asia'
        WHEN country = 'Mauritius' THEN 'Africa'
        WHEN country IN ('France' , 'Greece', 'Norway') THEN 'Europe'
        WHEN country IN ('Chile' , 'Venezuela') THEN 'South America'
        WHEN country IN ('Kermadec Islands' , 'Bouvet Islands', 'South Shetland Islands') THEN 'Antartica'
        ELSE continent
    END);
 
		--  splitting date_time column into date and time columns
SELECT 
    date_time,
    SUBSTRING_INDEX(date_time, ' ', 1) AS date,
    SUBSTRING_INDEX(date_time, ' ', - 1) AS time
FROM
    earthquake_data;

ALTER TABLE earthquake_data
ADD COLUMN new_date date;

ALTER TABLE earthquake_data
MODIFY COLUMN new_date text;

ALTER TABLE earthquake_data
ADD COLUMN new_time time;

UPDATE earthquake_data 
SET 
    new_date = SUBSTRING_INDEX(date_time, ' ', 1)
WHERE
    new_date IS NULL;

UPDATE earthquake_data
SET new_time = SUBSTRING_INDEX(date_time, ' ', -1)
WHERE new_time IS NULL;

		-- updating title column 
DELETE FROM earthquake_data
WHERE  latitude = '-20.0508' AND longitude = '-178.346';

DELETE FROM earthquake_data
WHERE latitude = '-25.5948' AND longitude = '178.278';
 
DELETE FROM earthquake_data
WHERE latitude = '-54.1325' AND longitude = '159.027';

DELETE FROM earthquake_data
WHERE latitude = '38.2296' AND longitude = '141.665';

SELECT title FROM earthquake_data;

		-- deleting unused column 
ALTER TABLE earthquake_data
DROP COLUMN date_time;

ALTER TABLE earthquake_data
DROP COLUMN location;

ALTER TABLE earthquake_data
DROP COLUMN continent;

