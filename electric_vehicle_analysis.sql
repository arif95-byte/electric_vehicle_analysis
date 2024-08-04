-- Inspect the data
SELECT * FROM electric_vehicle.electric_vehicle_population_data;

-- Create a cleaned table
CREATE TABLE Cleaned_EV_Data AS
SELECT DISTINCT
	TRIM(`VIN (1-10)`) AS VIN,
    TRIM(County) AS County,
    TRIM(City) AS City,
    TRIM(State) AS State,
    CAST(TRIM(`Postal Code`) AS CHAR(10)) AS 'Postal Code',
    'Model Year',
    TRIM(Make) AS Make,
    TRIM(Model) AS Model,
    TRIM('Electric Vehicle Type') AS 'Electric Vehicle Type',
    TRIM('CLean Alternative Fuel Vehicle (CAFV) Eligibility') AS 'CAFV Eligibility',
    'Electric Range',
    'Base MSRP',
    'Legislative District',
    'DOL Vehicle ID',
    TRIM('Vehicle Location') AS 'Vehicle Location',
    TRIM('Electric Utility') AS 'Electric Vehicle Type',
    TRIM('Clean Alternative Fuel Vehicle (CAFV) Eligibility') AS 'CAFV Eligibility',
    'Electric Range',
    'Base MSRP',
    'Legislative District',
    'DOL Vehicle ID',
    TRIM('Vehicle Location') AS 'Vehicle Location',
    TRIM('Electric Utillity') AS 'Electric Utility',
    CAST('2020 Census Tract' AS CHAR(20)) AS '2020 Census Tract'
FROM
	`electric_vehicle_population_data`
WHERE
	'VIN (1-10)' IS NOT NULL
    AND County IS NOT NULL
    AND City IS NOT NULL
    AND State IS NOT NULL
    AND 'Postal Code' IS NOT NULL
    AND 'Model Year' IS NOT NULL
    AND Make IS NOT NULL
    AND Model IS NOT NULL
    AND 'Electric Vehicle Type' IS NOT NULL
    AND 'CAFV Eligibility' IS NOT NULL
    AND 'Electric Range' IS NOT NULL
    AND 'Base MSRP' IS NOT NULL
    AND 'Legislative District' IS NOT NULL
    AND 'DOL Vehicle ID' IS NOT NULL
    AND 'Vehicle Location' IS NOT NULL
    AND 'Electric Utility' IS NOT NULL
    AND '2020 Census Tract' IS NOT NULL;
    
-- Standardize State and City values to uppercase
UPDATE Cleaned_EV_Data
SET State = UPPER(State),
	City = UPPER(City);

-- Handle specific corrections for data fields, if any (example given below)
-- Assume there are known corrections that need to be made
UPDATE Cleaned_EV_Data
SET 'Postal Code' = '98112'
WHERE VIN = '5YJSA1E22K'
	AND 'Postal Code' = '98112.0';

-- Distribution of Electric Vehicles by Legislative District
SELECT
	'Legislative District',
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
WHERE
	'Legislative District' IS NOT NULL
GROUP BY
	'Legislative District'
ORDER BY
	Vehicle_Count DESC;

-- Count of Electric Vehicles by Make and Model Year
SELECT
	Make,
    'Model Year',
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
GROUP BY
	Make,
    'Model Year'
ORDER BY
	Make,
    'Model Year';

-- Average Electric Range by Electric Vehicle Type
SELECT
	'Electric Vehicle Type',
    AVG('Electric Range') AS Average_Electric_Range
FROM
	electric_vehicle_population_data
GROUP BY
	'Electric Vehicle Type'
ORDER BY
	'Electric Vehicle Type';

-- Distribution of Electric Vehicles by County
SELECT
	County,
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
GROUP BY
	County
ORDER BY 
	Vehicle_Count DESC;

-- Count of Clean Alternative Fuel Vehicle Eligibility by City
SELECT
	City,
    'CAFV Eligibility',
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
GROUP BY
	City,
    'CAFV Eligibility'
ORDER BY
	City,
    'CAFV Eligibility';
    

-- Summary Statistics
SELECT
	MIN('Model Year') AS Min_Model_Year,
    MAX('Model Year') AS Max_Model_Year,
    AVG('Electric Range') AS Avg_Electric_Range,
    MIN('Electric Range') AS Min_Electric_Range,
    MAX('Electric Range') AS Max_Electric_Range,
    COUNT(DISTINCT 'County') AS Unique_Counties,
    COUNT(DISTINCT 'City') AS Unique_Cities,
    COUNT(DISTINCT 'Make') AS Unique_Makes,
    COUNT(DISTINCT 'Model') AS Unique_Models
FROM
	electric_vehicle_population_data;
    
-- Distribution of Electric Vehicles by Make
SELECT
	Make,
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
GROUP BY
	Make
ORDER BY
	Vehicle_Count DESC;

-- Distribution of Electric Vehicles by Model Year
SELECT
	'Model Year',
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
GROUP BY
	'Model Year'
ORDER BY 
	'Model Year';

-- Distribution of Electric Vehicles by County and City
-- Distribution of Electric Vehicles by County
SELECT
	County,
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
GROUP BY
	County
ORDER BY
	Vehicle_Count DESC;

-- Distribution of Electric Vehicles by City
SELECT
	City,
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
GROUP BY
	City
ORDER BY
	Vehicle_Count DESC;

-- Average Electric Range by Make and Model
SELECT
	Make,
    Model,
    AVG('Electric Range') AS Avg_Electric_Range
FROM
	electric_vehicle_population_data
GROUP BY
	Make,
    Model
ORDER BY
	Make,
    Model;

-- Count of Alternative Fuel Vehicle Eligibility by Make
SELECT
	Make,
    'CAFV Eligibility',
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
GROUP BY
	Make,
    'CAFV Eligibility'
ORDER BY
	Make,
    'CAFV Eligibility';

-- Count of Clean Alternative Fuel Vehicle Eligibility by Model Year
SELECT
	'Model Year',
    'CAFV Eligibility',
    COUNT(*) AS Vehicle_Count
FROM
	electric_vehicle_population_data
GROUP BY
	'Model Year',
    'CAFV Eligibility'
ORDER BY
	'Model Year',
    'CAFV Eligibility';

-- Identify potential outliers in Electric Range
SELECT
    Make,
    Model,
    'Electric Range'
FROM
	electric_vehicle_population_data
WHERE
	'Electric Range' > (SELECT AVG('Electric Range') + 3 * STDDEV('Electric Range') FROM electric_vehicle_population_data)
    OR 'Electric Range' < (SELECT AVG('Electric Range') - 3 * STDDEV('Electric Range') FROM electric_vehicle_population_data)
ORDER BY
	'Electric Range' DESC;
    