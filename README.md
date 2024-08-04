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
CREATE TABLE Cleaned_EV_Data AS<br>
SELECT DISTINCT<br>
  TRIM('VIN(1-10)') AS VIN,<br>
  TRIM(County) AS County,<br>
  TRIM(City) AS CIty,<br>
  TRIM(State) AS State,<br>
  CAST(TRIM('Postal Code') AS VARCHAR) AS 'Postal Code',<br>
  'Model Year',<br>
  TRIM(Make) AS Make,<br>
  TRIM(Model) AS Model,<br>
  TRIM('Electric Vehicle Type') AS 'Electric Vehicle Type',<br>
  TRIM('Clean Alternative Fuel Vehicle (CAFV) Eligibility') AS 'CAFV Eligibility',<br>
  'Electric Range',<br>
  'Base MSRP',<br>
  'Legislative District',<br>
  'DOL Vehicle ID',<br>
  TRIM('Vehicle Location') AS 'Vehicle Location',<br>
  TRIM('Electric Utility') AS 'Electric Utility',<br>
  '2020 Census Tract'<br>
FROM<br>
  Electrci_Vehicle_Population_Data<br>
WHERE<br>
  'VIN (1-10)' IS NOT NULL<br>
  AND County IS NOT NULL<br>
  AND City IS NOT NULL<br>
  AND State IS NOT NULL<br>
  AND 'Postal Code' IS NOT NULL<br>
  AND 'Model Year' IS NOT NULL<br>
  AND Make IS NOT NULL<br>
  AND Model IS NOT NULL<br>
  AND 'Electric Vehicle Type' IS NOT NULL<br>
  AND 'CAFV Eligibility' IS NOT NULL<br>
  AND 'Electric Range' IS NOT NULL<br>
  AND 'Base MSRP' IS NOT NULL<br>
  AND 'Legislative District' IS NOT NULL<br>
  AND 'DOL Vehicle ID' IS NOT NULL<br>
  AND 'Vehicle Location' IS NOT NULL<br>
  AND 'Electric Utility' IS NOT NULL<br>
  AND '2020 Census Tract' IS NOT NULL;<br>

-- Update data types
ALTER TABLE Cleaned_EV_Data<br>
ALTER COLUMN 'Postal Code' SET DATA TYPE VARCHAR(10),<br>
ALTER COLUMN '2020 Census Tract' SET DATA TYPE VARCHAR(20);<br>

-- Standarsize State and City values to uppercase
UPDATE Cleaned_EV_Data<br>
SET State = UPPER(State),<br>
    City = UPPER(City);<br>

-- Handle specific corrections for data fields, if any (example given below)
-- Assume there are known corrections that need to be made
UPDATE Cleaned_EV_Data<br>
SET 'Postal Code' = '98112'<br>
WHERE VIN = '5YJSA1E22K'<br>
  AND 'Postal Code' = '98112.0';<br>

## Explanation:
1. Remove duplicates: 'SELECT DISTINCT' is used to ensure all rows are unique.
2. Trim white spaces: 'TRIM()' function is used to remove leading and trailing spaces.
3. Standardize data formats: For example, 'UPPER()' function ensures city and state names are in uppercase.
4. Convert data types: 'ALTER COLUMN' ensures columns have appropriate data types.
5. Handle missing values: The 'WHERE' clause excludes rows with any null values.

This scripy clreates a cleaned version of the data, ensuring consistency and removing any unnecessary whitesapces or duplicates.

