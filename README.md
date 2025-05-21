# US Baby Names Data Analysis with SQL

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📊 Overview
This project analyzes US baby names data using SQL queries. It provides comprehensive analysis of baby naming trends over time, including popularity rankings, gender distribution, and historical patterns.

## 🗂 Project Structure
- `babynames.sql`: Main SQL file containing analysis queries
- `names_data.csv`: Raw data file containing baby names information
- `Babynames.xlsx`: Excel version of the analysis for easy viewing

## 🚀 Getting Started

### Prerequisites
1. SQL Server Database Management System
2. CSV file viewer 
3. Basic SQL knowledge

### Installation Steps
1. Clone this repository:
```bash
git clone https://github.com/yourusername/us-baby-names-analysis.git
```

2. Create a new SQL Server database
3. Import the `names_data.csv` file into your database
4. Run the queries from `babynames.sql`

### Viewing Results
- View query results directly in your SQL Server interface
- Export results to Excel for additional analysis
- Use data visualization tools for creating charts and graphs

## 📝 Query Examples

```sql
-- Example: Find the overall most popular girl and boy names
-- for male names
SELECT TOP 1 name, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'M'
GROUP BY name
ORDER BY TotalBirths DESC;
```
<details>
  <summary>📊 Show Results</summary>

|    | name    | TotalBirths |
|----|---------|-------------|
| 1  | Michael |   1376418   |

</details>

```sql
-- for female names
SELECT top 1 name, SUM(Births) AS TotalBirths
FROM names
WHERE Gender = 'F'
GROUP BY name
ORDER BY TotalBirths DESC;
```
<details>
  <summary>📊 Show Results</summary>

|    | name    | TotalBirths |
|----|---------|-------------|
| 1  | Jessica |    863121   |

</details>

```sql
-- Example: Find the most popular names by year
-- Find top Names By year
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
```
<details>
  <summary>📊 Show Results</summary>

| Year | Name     | rnk |
|------|----------|------|
| 1980 | Jennifer | 1    |
| 1981 | Jennifer | 1    |
| 1982 | Jennifer | 1    |
| 1983 | Jennifer | 1    |
| 1984 | Jennifer | 1    |
| 1985 | Jessica  | 1    |
| 1986 | Jessica  | 1    |
| 1987 | Jessica  | 1    |
| 1988 | Jessica  | 1    |
| 1989 | Jessica  | 1    |
| 1990 | Jessica  | 1    |
| 1991 | Ashley   | 1    |
| 1992 | Ashley   | 1    |
| 1993 | Jessica  | 1    |
| 1994 | Jessica  | 1    |
| 1995 | Jessica  | 1    |
| 1996 | Emily    | 1    |
| 1997 | Emily    | 1    |
| 1998 | Emily    | 1    |
| 1999 | Emily    | 1    |
| 2000 | Emily    | 1    |
| 2001 | Emily    | 1    |
| 2002 | Emily    | 1    |
| 2003 | Emily    | 1    |
| 2004 | Emily    | 1    |
| 2005 | Emily    | 1    |
| 2006 | Emily    | 1    |
| 2007 | Emily    | 1    |
| 2008 | Emma     | 1    |
| 2009 | Isabella | 1    |

</details>

```sql
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
```
<details>
  <summary>📊 Show Results</summary>

| Year | Name    | rnk |
|------|---------|------|
| 1980 | Michael | 1    |
| 1981 | Michael | 1    |
| 1982 | Michael | 1    |
| 1983 | Michael | 1    |
| 1984 | Michael | 1    |
| 1985 | Michael | 1    |
| 1986 | Michael | 1    |
| 1987 | Michael | 1    |
| 1988 | Michael | 1    |
| 1989 | Michael | 1    |
| 1990 | Michael | 1    |
| 1991 | Michael | 1    |
| 1992 | Michael | 1    |
| 1993 | Michael | 1    |
| 1994 | Michael | 1    |
| 1995 | Michael | 1    |
| 1996 | Michael | 1    |
| 1997 | Michael | 1    |
| 1998 | Michael | 1    |
| 1999 | Jacob   | 1    |
| 2000 | Jacob   | 1    |
| 2001 | Jacob   | 1    |
| 2002 | Jacob   | 1    |
| 2003 | Jacob   | 1    |
| 2004 | Jacob   | 1    |
| 2005 | Jacob   | 1    |
| 2006 | Jacob   | 1    |
| 2007 | Jacob   | 1    |
| 2008 | Jacob   | 1    |
| 2009 | Jacob   | 1    |

</details>


```sql
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
SELECT Top 3 t1.Name,t1.Year,t1.rnk,t2.Name,t2.Year,t2.rnk,
       t1.rnk - t2.rnk AS diff
FROM names1980 t1
INNER JOIN names2009 t2 ON t1.NAME = t2.NAME
ORDER BY diff desc;
```
<details>
  <summary>📊 Show Results</summary>

| Name   | Year | rnk | Name    | Year | rnk  | diff |
|--------|------|-----|---------|------|------|------|
| Aidan  | 1980 | 5780 | Aidan  | 2009 | 109  | 5671 |
| Colton | 1980 | 5672 | Colton | 2009 | 149  | 5523 |
| Aliyah | 1980 | 5770 | Aliyah | 2009 | 351  | 5419 |

</details>

```sql
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
```
<details>
  <summary>📊 Show Results</summary>

| year | name        | Gender | rnk |
|------|-------------|--------|------|
| 1980 | Jennifer    | F      | 1    |
| 1980 | Amanda      | F      | 2    |
| 1980 | Jessica     | F      | 3    |
| 1980 | Michael     | M      | 1    |
| 1980 | Christopher | M      | 2    |
| 1980 | Jason       | M      | 3    |
<!-- ... abbreviated for readability ... -->
| 2009 | Isabella    | F      | 1    |
| 2009 | Emma        | F      | 2    |
| 2009 | Olivia      | F      | 3    |
| 2009 | Jacob       | M      | 1    |
| 2009 | Ethan       | M      | 2    |
| 2009 | Michael     | M      | 3    |

Key Observations:
- Michael dominated male names from 1980-1998
- Jacob took over from 1999-2009
- Female names showed more variety with Jennifer, Jessica, Ashley, and Emily taking turns as #1
</details>

```sql
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
```
```sql
// ...existing code...
```
<details>
  <summary>📊 Show Results</summary>

| decade | name        | Gender | rnk |
|--------|-------------|--------|------|
| 80     | Jessica     | F      | 1    |
| 80     | Jennifer    | F      | 2    |
| 80     | Amanda      | F      | 3    |
| 80     | Michael     | M      | 1    |
| 80     | Christopher | M      | 2    |
| 80     | Matthew     | M      | 3    |
| 90     | Jessica     | F      | 1    |
| 90     | Ashley      | F      | 2    |
| 90     | Emily       | F      | 3    |
| 90     | Michael     | M      | 1    |
| 90     | Christopher | M      | 2    |
| 90     | Matthew     | M      | 3    |
| 2000   | Emily       | F      | 1    |
| 2000   | Madison     | F      | 2    |
| 2000   | Emma        | F      | 3    |
| 2000   | Jacob       | M      | 1    |
| 2000   | Michael     | M      | 2    |
| 2000   | Joshua      | M      | 3    |
</details>

## 📊 Output Format
Results will be displayed in organized tables containing:
- Baby name
- Year of record
- Gender
- rnk
- Total births

## 📈 Sample Visualizations
The query results can be visualized using various charts:
- Time series graphs for name popularity
- Gender distribution pie charts
- Top names bar charts
- Regional distribution maps

## 🤝 Contributing
Contributions are welcome! Here's how you can help:
- Add new analysis queries
- Improve existing queries
- Document results and findings
- Add new visualization examples

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

## 📧 Contact
For questions or feedback, please open an issue in this repository.
