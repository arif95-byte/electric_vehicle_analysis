# electric_vehicle_analysis

# Introduction
* Analysis on electric vehicle
* Data Cleaning:
  1. Remove duplicates.
  2. Handle missing values.
  3. Standardize data formats.
  4. Correct data types.

** SQL script:
-- Create a cleaned table
CREATE TABLE Cleaned_EV_Data AS
SELECT DISTINCT
  TRIM('VIN(1-10)') AS VIN,
  TRIM(County) AS County,
  TRIM(City) AS CIty,
  TRIM(State) AS State,
  CAST(TRIM('Postal Code') AS VARCHAR) AS 'Postal Code',
  'Model Year',
  TRIM(Make) AS Make,
  TRIM(Model) AS Model,
  TRIM('Electric Vehicle Type') AS 'Electric Vehicle Type',
  TRIM('Clean Alternative Fuel Vehicle (CAFV) Eligibility') AS 'CAFV Eligibility',
  'Electric Range',
  'Base MSRP',
  'Legislative District',
  'DOL Vehicle ID',
  TRIM('Vehicle Location') AS 'Vehicle Location',
  TRIM('Electric Utility') AS 'Electric Utility',
  '2020 Census Tract'
FROM
  Electrci_Vehicle_Population_Data
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

-- Update data types
ALTER TABLE Cleaned_EV_Data
ALTER COLUMN 'Postal Code' SET DATA TYPE VARCHAR(10),
ALTER COLUMN '2020 Census Tract' SET DATA TYPE VARCHAR(20);

-- Standarsize State and City values to uppercase
UPDATE Cleaned_EV_Data
SET State = UPPER(State),
    City = UPPER(City);

-- Handle specific corrections for data fields, if any (example given below)
-- Assume there are known corrections that need to be made
UPDATE Cleaned_EV_Data
SET 'Postal Code' = '98112'
WHERE VIN = '5YJSA1E22K'
  AND 'Postal Code' = '98112.0';

## Explanation:
1. Remove duplicates: 'SELECT DISTINCT' is used to ensure all rows are unique.
2. Trim white spaces: 'TRIM()' function is used to remove leading and trailing spaces.
3. Standardize data formats: For example, 'UPPER()' function ensures city and state names are in uppercase.
4. Convert data types: 'ALTER COLUMN' ensures columns have appropriate data types.
5. Handle missing values: The 'WHERE' clause excludes rows with any null values.

This scripy clreates a cleaned version of the data, ensuring consistency and removing any unnecessary whitesapces or duplicates.

