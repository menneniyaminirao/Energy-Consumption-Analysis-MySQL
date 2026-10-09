CREATE DATABASE ENERGYDB2;
USE ENERGYDB2;

-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);

SELECT * FROM COUNTRY;

-- 2. emission_3 table
CREATE TABLE emission_3 (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM EMISSION_3;


-- 3. population table
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

SELECT * FROM POPULATION;

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);


SELECT * FROM PRODUCTION;

-- 5. gdp_3 table
CREATE TABLE gdp_3 (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

SELECT * FROM GDP_3;

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM CONSUMPTION;


-- What is the total emission per country for the most recent year available?
select country,sum(emission) as total_emission 
from emission_3 
where year=(select max(year) from emission_3)
group by country 
order by total_emission desc;


-- What are the top 5 countries by GDP in the most recent year?
select country,year,value 
from gdp_3
where year=(select max(year) from gdp_3)
order by value desc 
limit 5;


-- Compare energy production and consumption by country and year. 
select p.country,p.energy,p.year,p.production ,c.consumption
from production p
join consumption c
on p.country=c.country and p.year=c.year and p.energy=c.energy
order by p.country,p.energy,p.year;


-- Which energy types contribute most to emissions across all countries?
select energy_type,sum(emission) as total_emission
from emission_3 
group by energy_type
ORDER BY total_emission desc ;

-- How have global emissions changed year over year?
select year,sum(emission) as global_emission,
sum(emission)-lag(sum(emission)) over(order by year) as yearly_changes_in_emission
from emission_3
group by year
order by year;


-- What is the trend in GDP for each country over the given years?
select country,year,value as GDP
from gdp_3
order by country,year;

-- How has population growth affected total emissions in each country?
select e.country, e.year, p.value AS population,
    SUM(e.emission) AS total_emission,
    p.value - LAG(p.value) OVER ( PARTITION BY e.country ORDER BY e.year) AS population_growth,
    SUM(e.emission) - LAG(SUM(e.emission)) OVER ( PARTITION BY e.country ORDER BY e.year) AS emission_difference
from emission_3  e
join population p
on e.country=p.countries and e.year=p.year
group by e.country,e.year,p.value
order by e.country,e.year;


-- Has energy consumption increased or decreased over the years for major economies?
select c.country,c.year,sum(c.consumption) as total_consumption,g.value as gdp_value,
SUM(c.consumption) - LAG(SUM(c.consumption)) OVER ( PARTITION BY c.country ORDER BY c.year ) AS consumption_change
from consumption c
join gdp_3 g
on c.country=g.country and c.year=g.year
group by c.country,c.year,g.value
order by c.country,c.year;

-- What is the average yearly change in emissions per capita for each country?
select country, year,avg(per_capita_emission) AS avg_per_capita_emission,
avg(per_capita_emission) - lag(avg(per_capita_emission)) over(partition by country order by year) as average_yearly_change
from emission_3
group by country,year
order by country,year;


-- Ratio & Per Capita Analysis
-- What is the emission-to-GDP ratio for each country by year?
select e.country,e.year,SUM(e.emission) AS total_emission,
g.value AS gdp, sum(e.emission)/g.value as emission_to_GDP_ratio
from emission_3 as e
join gdp_3 as g
on e.country=g.country and e.year=g.year
GROUP BY e.country, e.year, g.value
order by e.country,e.year;


-- What is the energy consumption per capita for each country over the last decade?
select p.countries,p.year,sum(c.consumption) as total_consumption,
p.value AS population,
sum(c.consumption) / p.value as energy_consumption_per_capita
from population p
join consumption c
on p.countries=c.country and p.year=c.year
where p.year>=(select max(year) - 9 from population)
group by p.countries,p.year,p.value
order by p.countries,p.year;

-- How does energy production per capita vary across countries?
select p.countries,p.year,sum(pro.production) as total_production,
p.value AS population,
sum(pro.production) / p.value as energy_production_per_capita
from population p
join production pro
on p.countries=pro.country and p.year=pro.year
group by p.countries,p.year,p.value
order by p.countries,p.year;


-- Which countries have the highest energy consumption relative to GDP?
select c.country,c.year,g.value as gdp,max(c.consumption) as highest_consumption,
sum(c.consumption) AS total_consumption,
sum(c.consumption) / g.value as relative_gdp_ratio
from gdp_3 g
join consumption c
on g.country=c.country and g.year=c.year
group by c.country,c.year,g.value
order by relative_gdp_ratio desc;


-- What is the correlation between GDP growth and energy production growth?

WITH yearly_production AS (
    SELECT
        country,
        year,
        SUM(production) AS total_production
    FROM production
    GROUP BY country, year
),
production_growth AS (
    SELECT
        country,
        year,
        total_production,
        LAG(total_production) OVER (
            PARTITION BY country
            ORDER BY year
        ) AS previous_year_production
    FROM yearly_production
)
SELECT
    country,
    year,
    total_production,
    previous_year_production,
    total_production - previous_year_production
        AS production_growth
FROM production_growth
WHERE previous_year_production IS NOT NULL
ORDER BY production_growth DESC
LIMIT 10;



 -- Global Comparisons
-- What are the top 10 countries by population and how do their emissions compare?
select
    p.countries as country,
    p.year,
    p.value as population,
    sum(e.emission) as total_emission
from population p
join emission_3 e
    on p.countries = e.country
    and p.year = e.year
where p.year = (select max(year) from population)
group by p.countries, p.year, p.value
order by population desc
limit 10;

-- Which countries have improved (reduced) their per capita emissions the most over the last decade?
SELECT country,
       year,
       per_capita_emission,
       per_capita_emission - LAG(per_capita_emission) OVER(PARTITION BY country ORDER BY year) AS emission_change
FROM emission_3
WHERE year >= (SELECT MAX(year)-9 FROM emission_3)
ORDER BY country,year;


-- What is the global share (%) of emissions by country?
select country,sum(emission) as total,
(sum(emission) / (select sum(emission) from emission_3))*100 as global_share
from emission_3
group by country
order by  global_share desc;


-- What is the global average GDP, emission, and population by year?

WITH yearly_emissions AS (
    SELECT
        country,
        year,
        SUM(emission) AS total_emission
    FROM emission_3
    GROUP BY country, year
)
SELECT
    g.year,
    AVG(g.value) AS avg_gdp,
    AVG(e.total_emission) AS avg_emission,
    AVG(p.value) AS avg_population
FROM gdp_3 g
JOIN population p
    ON g.country = p.countries
    AND g.year = p.year
JOIN yearly_emissions e
    ON g.country = e.country
    AND g.year = e.year
GROUP BY g.year
ORDER BY g.year;


