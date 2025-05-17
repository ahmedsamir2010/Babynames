-- Active: 1745213386476@@127.0.0.1@5432@babynames
DROP TABLE IF EXISTS names;
CREATE TABLE names (
    Name VARCHAR(100),
    Year INT,
    Gender CHAR(1),
    State CHAR(2),
    Births INT
);
COPY names(State,Gender,Year,Name, Births)
FROM 'C:/Users/AboSamir/Desktop/names_data.csv'
WITH (
    FORMAT csv,
    HEADER false,
    DELIMITER ','
);
-- find top names for F M
SELECT name, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'F'
GROUP BY name
ORDER BY TotalBirths DESC
LIMIT 1;

SELECT name, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'M'
GROUP BY name
ORDER BY TotalBirths DESC
LIMIT 1;

WITH girlnames as (
SELECT YEAR, NAME, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'F'
GROUP BY YEAR, NAME
ORDER BY YEAR ASC
)
SELECT * FROM (
  SELECT YEAR, NAME,
  ROW_NUMBER() OVER (PARTITION BY YEAR ORDER BY TotalBirths DESC) AS Rank 
  FROM girlnames
)
WHERE Rank = 1
ORDER BY YEAR ASC;