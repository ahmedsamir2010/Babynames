-- Active: 1739523225053@@ABOSAMIRSQLEXPRESS@1433@Babynames
use Babynames
CREATE TABLE names (
    State CHAR(2),
    Gender CHAR(1),
    Year INT,
    Name VARCHAR(100),
    Births INT
);

-- ALTER TABLE names
-- ALTER COLUMN Births INT NOT NULL;

-- find top names for F M
-- F
use Babynames
SELECT top 1 name, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'F'
GROUP BY name
ORDER BY TotalBirths DESC;
-- M
SELECT top 1 name, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'M'
GROUP BY name
ORDER BY TotalBirths DESC;
-- Find top Names By year
USE Babynames;
-- F
with girlnames as (
SELECT YEAR, NAME, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'F'
GROUP BY YEAR, NAME
)
SELECT * FROM (
SELECT year,name,
    row_number() over (partition by year order by TotalBirths desc) as rnk
FROM girlnames) as f
WHERE rnk = 1
ORDER BY YEAR ASC

USE Babynames;
-- M
with boyname as (
SELECT YEAR, NAME, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'M'
GROUP BY YEAR, NAME
)
SELECT * FROM (
SELECT year,name,
    row_number() over (partition by year order by TotalBirths desc) as rnk
FROM boyname ) as m
where rnk = 1
ORDER BY YEAR ASC
