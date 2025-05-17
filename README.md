# US Baby Names Data Analysis with SQL

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📊 Overview
This project analyzes US baby names data using SQL queries. It provides comprehensive analysis of baby naming trends over time, including popularity rankings, gender distribution, and historical patterns.

## 🗂 Project Structure
- `babynames.sql`: Main SQL file containing analysis queries
- `names_data.csv`: Raw data file containing baby names information
- `Babynames.xlsx`: Excel version of the dataset for easy viewing
- `post.sql`: Additional SQL queries for advanced analysis

## 🚀 Getting Started

### Prerequisites
1. MySQL Database Management System
2. CSV file viewer (e.g., Excel, Google Sheets)
3. Basic SQL knowledge

### Installation Steps
1. Clone this repository:
```bash
git clone https://github.com/yourusername/us-baby-names-analysis.git
```

2. Create a new MySQL database
3. Import the `names_data.csv` file into your database
4. Run the queries from `babynames.sql`

### Viewing Results
- View query results directly in your MySQL interface
- Export results to Excel for additional analysis
- Use data visualization tools for creating charts and graphs

## 📝 Query Examples

```sql
-- Example: Find most popular names
SELECT 
    name,
    COUNT(*) as frequency,
    gender
FROM names
GROUP BY name, gender
ORDER BY frequency DESC
LIMIT 10;

-- Example: Analyze name trends over time
SELECT 
    year,
    name,
    COUNT(*) as count
FROM names
WHERE name = 'John'
GROUP BY year, name
ORDER BY year;
```

## 📊 Output Format
Results will be displayed in organized tables containing:
- Baby name
- Frequency count
- Year of record
- Gender
- Additional relevant statistics

## 🔄 Updating Data
To update the analysis with new data:
1. Update the CSV file with new records
2. Re-import the data into your MySQL database
3. Re-run the analysis queries

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
