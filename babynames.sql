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
ORDER BY TotalBirths DESC; -- Jessica
-- M
SELECT top 1 name, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'M'
GROUP BY name
ORDER BY TotalBirths DESC; -- Michael
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

-- Find the names with the biggest jumps in popularity from the first year of the data set to the last year
USE Babynames;
with allnames as (
	SELECT YEAR, NAME, SUM(Births) AS TotalBirths
	FROM names
	GROUP BY YEAR, NAME
),
names1980 as (
	SELECT year,name,
		row_number() over (partition by year order by TotalBirths desc, name desc) as rnk
	FROM allnames
	WHERE YEAR = 1980
),
names2009 as (
	SELECT year,name,
		row_number() over (partition by year order by TotalBirths desc, name desc) as rnk
	FROM allnames
	WHERE YEAR = 2009
)
SELECT TOP 3 t1.Name,t1.Year,t1.rnk,t2.Name,t2.Year,t2.rnk,
       t1.rnk - t2.rnk AS diff
FROM names1980 t1
INNER JOIN names2009 t2 ON t1.NAME = t2.NAME
ORDER BY diff desc;
--For each year, return the 3 most popular girl names and 3 most popular boy names
use Babynames;
with babiesbyyear as (
SELECT year,name, Gender,sum(Births) as totbirth from names
group by year,name,gender
),
topnames as (
	select YEAR , name, Gender ,
			ROW_NUMBER() over(partition by year, Gender order by totbirth desc) as rnk
	from babiesbyyear
)
select * from topnames
where rnk <= 3
--For each decade, return the 3 most popular girl names and 3 most popular boy names
use Babynames;
with nameswithdecade as (
SELECT case when year between 1980 and 1989 then 80
			when year between 1990 and 1999 then 90
			when year between 2000 and 2009 then 2000
			else 'GZ' end as decade,
name, Gender,Births from names
),
babiesbydecade as (
SELECT decade,name,Gender,SUM(births) AS totbirth
    FROM nameswithdecade
    WHERE decade IS NOT NULL
    GROUP BY decade, name, gender
),
topnames as (
	select decade , name, Gender ,
			ROW_NUMBER() over(partition by decade, Gender order by totbirth desc) as rnk
	from babiesbydecade
)
select * from topnames
where rnk <= 3

-- Return the number of babies born in each of the six regions

USE Babynames;
--find miss / null / duplicated data
select distinct n.State,cr.region from names n
left join regions cr
on n.State = cr.State
-- MI is miss state
--New England is duplicated ->> New_England

--clear data
with clean_regin as (
select state,
		case when region = 'New England' then 'New_England' else region end as clean_regi
from regions
union
select 'MI' as state, 'Midwest' as clean_regin
)
-- total births by regi
select cr.clean_regi, sum(n.Births) as totBirths
from names n left join clean_regin cr
on n.State = cr.State
group by clean_regi

-- top 3 rnk by regin
select * from (
	select cr.clean_regi,n.gender,n.name,
	ROW_NUMBER() over(partition by clean_regi,n.gender order by sum(n.Births) desc) as rnk
	from names n left join clean_regin cr
	on n.State = cr.State
	group by clean_regi,Gender,name
	) as regrnk
where rnk <=3


--Find the 10 most popular androgynous names (names given to both females and males)
USE Babynames;
with tbsex as (
	select name,COUNT(distinct gender) as sex, sum(Births) as totbirths,
	ROW_NUMBER() over(order by sum(Births) desc) as rnk
	from names
	group by name 
)
select TOP 10 * from tbsex
where sex > 1
order by totbirths desc

--Find the length of the shortest and longest names, and identify the most popular short names (those with the fewest characters) and long names (those with the most characters)
USE Babynames;

select distinct name, LEN(name) as len  from names
order by len desc, name desc

USE Babynames;
with lenrnk as (
select * from names
	where LEN(name) in(2,15)
)
select * from (
select name, SUM(Births) as totbirths,
ROW_NUMBER() over(partition by len(name) order by sum(Births) desc) as rnk
from lenrnk
group by name
) as rnklen
where rnk <= 3

-- The founder of Maven Analytics is named Chris. Find the state with the lowest percent of babies named "Chris"


USE Babynames;
with rnkchis as (
select State,name, SUM(Births) as totbirths 
from names
where name = 'Chris'
group by state,name
),
allbabys as (
select State, SUM(Births) as allbirths 
from names
group by state
)
select top 1 n.State,n.name,n.totbirths,
a.allbirths,
 cast(1.0 * n.totbirths / a.allbirths * 100  as decimal(5,4)) as perc
from rnkchis n
left join allbabys a on n.state = a.state
order by perc asc
-- WV