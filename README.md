# 🌍 Energy Consumption Analysis Using MySQL

## 📌 Project Overview

This project analyzes global energy consumption, energy production, carbon emissions, GDP, and population data using **MySQL**. The goal is to explore relationships between energy usage, economic growth, population changes, and environmental impact through SQL queries.

The project uses multiple datasets to perform data analysis and generate insights into global energy and emission trends.

## 🎯 Project Objectives

* Analyze total carbon emissions across countries.
* Identify countries with the highest GDP and population.
* Compare energy production and consumption.
* Examine emissions by energy type.
* Track global emissions trends over time.
* Analyze GDP and population trends alongside emissions.
* Calculate per-capita energy consumption and emissions.
* Explore emissions relative to GDP.
* Compare countries' contributions to global emissions.

## 🛠️ Tools and Technologies

* **Database:** MySQL
* **Query Language:** SQL
* **Database Tool:** MySQL Workbench
* **Data Format:** CSV
* **Visualization:** Screenshots of query results and analysis

## 📂 Project Structure

```text
Energy-Consumption-Analysis-MySQL/
│
├── Dataset/
│   ├── consum_3.csv
│   ├── country_3.csv
│   ├── emission_3.csv
│   ├── gdp_3.csv
│   ├── population_3.csv
│   └── production_3.csv
│
├── ER-Diagram/
│   └── ER.jpeg
│
├── Screenshots/
│   ├── Emissions relative to GDP.jpg
│   ├── Energy consumption per capita.jpg
│   ├── Energy production vs consumption.jpg
│   ├── Global emissions trend.jpg
│   ├── Global share of emissions.jpeg
│   ├── Highest-emission countries.jpg
│   ├── Population and emissions.jpg
│   └── Top 5 countries by GDP.jpg
│
└── energy_consumption_analysis.sql
```

## 🗃️ Database Design

The project uses six tables:

| Table         | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| `country`     | Stores country identifiers and country names                |
| `emission_3`  | Stores emissions by country, energy type, and year          |
| `population`  | Stores population values by country and year                |
| `production`  | Stores energy production by country, energy type, and year  |
| `gdp_3`       | Stores GDP values by country and year                       |
| `consumption` | Stores energy consumption by country, energy type, and year |

The country table serves as a reference for linking the other tables through foreign keys.

### Entity Relationship Diagram

The ER diagram illustrates the database tables and their relationships.

![ER Diagram](ER-Diagram/ER.jpeg)

## 📊 Key Analysis Areas

### 1. Emissions Analysis

* Identify countries with the highest emissions.
* Analyze emissions by energy type.
* Track global emissions changes across years.
* Calculate each country's share of global emissions.

### 2. Energy Production and Consumption

* Compare energy production with consumption.
* Analyze energy consumption per capita.
* Examine production per capita.
* Identify changes in energy production over time.

### 3. Economic Analysis

* Identify countries with the highest GDP.
* Analyze GDP trends across years.
* Evaluate emissions relative to GDP.
* Explore energy consumption in relation to GDP.

### 4. Population Analysis

* Compare population and emissions trends.
* Examine per-capita emissions.
* Analyze energy consumption in relation to population.

## 🧠 SQL Concepts Used

* Database creation and table design
* Primary keys and foreign keys
* `SELECT`, `WHERE`, and `ORDER BY`
* Aggregate functions such as `SUM()` and `AVG()`
* `GROUP BY` and `HAVING`
* Joins and subqueries
* Common Table Expressions (CTEs)
* Window functions such as `LAG()`
* Year-over-year comparisons
* Calculations and ranking using SQL

## 🖼️ Project Screenshots

The `Screenshots` folder contains visual outputs from selected analyses, including:

* Highest-emission countries
* Global emissions trends
* Energy production versus consumption
* Energy consumption per capita
* Emissions relative to GDP
* Population and emissions
* Top countries by GDP
* Global share of emissions

## ⚙️ How to Run the Project

1. Install **MySQL Server** and **MySQL Workbench**.
2. Clone or download this repository.
3. Open `energy_consumption_analysis.sql` in MySQL Workbench.
4. Execute the database and table creation statements.
5. Import the CSV files from the `Dataset` folder into their corresponding tables.
6. Ensure country names and column data types are consistent with the database schema.
7. Execute the analysis queries in the SQL file.
8. Review the query results and screenshots in the `Screenshots` folder.

**Note:** Import the data into the tables before running the analysis queries. Follow the table structure and foreign-key relationships when loading the datasets.

## 💡 Learning Outcomes

This project demonstrates practical SQL skills in relational database design, data aggregation, multi-table analysis, time-based comparisons, and extracting insights from energy and economic datasets.

It also provides experience organizing a data analysis project with datasets, SQL scripts, an ER diagram, and result screenshots.

## 👩‍💻 Author

**Menneni Yamini Rao**

* GitHub: [menneniyaminirao](https://github.com/menneniyaminirao)
* LinkedIn: [Connect with me](https://www.linkedin.com/in/menneni-yamini-rao-742153326/)

---

⭐ If you find this project useful, consider giving the repository a star.
