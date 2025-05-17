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

| Year | Name     | Rank |
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
```sql
-- Results: Most Popular Male Names by Year (1980-2009)
```
<details>
  <summary>📊 Show Results</summary>

| Year | Name    | Rank |
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

## 📊 Output Format
Results will be displayed in organized tables containing:
- Baby name
- Year of record
- Gender
- rank
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
