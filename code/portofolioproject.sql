select * 
from covid_death
where continent is NOT NULL
order by 3,4

select *
from covid_vaksin
where continent is NOT NULL
ORDER BY 3,4

-- select data we are going to use
select cd.location,cd.date, cd.total_cases, cd.new_cases, cd.total_deaths, cd.population
from covid_death as cd
where continent is NOT NULL
order by 1,2

-- Looking at total cases vs total deaths
select cd.location,cd.date, cd.total_cases, cd.total_deaths, (cd.total_deaths/cd.total_cases)*100 as deathpercentage
from covid_death as cd
where cd.location ILIKE '%states%' abd continent is NOT NULL
order by 2 desc

-- Looking at total cases vs population
select cd.location, cd.date, cd.total_cases, cd.population, (cd.total_cases/cd.population)*100 as casespercentage
from covid_death as cd
where cd.location = 'Indonesia' and continent is NOT NULL
order by 2 desc

-- Countries with infection rate compared to population
select cd.location, max(cd.total_cases) as maxcases, cd.population, max((cd.total_cases/cd.population))*100 as PERCENTPOPULATIONINFECTED
from covid_death as cd
where continent is NOT NULL
GROUP BY cd.location, cd.population
order by  PERCENTPOPULATIONINFECTED desc

-- show countries country with hoghest death count
SELECT 
    cd.location, 
    MAX(CAST(cd.total_deaths AS BIGINT)) AS maxcdeath, 
    cd.population, 
    MAX(cd.total_deaths) / NULLIF(cd.population, 0) * 100 AS percent_population_in_death
FROM covid_death AS cd
WHERE continent is not NULL
GROUP BY cd.location, cd.population
ORDER BY percent_population_in_death DESC

-- break things down by continent
SELECT  cd.continent, max(CAST(cd. total_deaths as BIGINT)) as totaldeathcount
FROM covid_death as cd
where cd.continent is NOT NULL
GROUP BY cd.continent
ORDER BY totaldeathcount desc

-- showing continents with highest death count per population
SELECT  cd.continent, max(CAST(cd. total_deaths as BIGINT)) as totaldeathcount
FROM covid_death as cd
where cd.continent is NOT NULL
GROUP BY cd.continent
ORDER BY totaldeathcount desc 

-- Global numbers
select cd.date,sum(new_cases) as case, sum(cast(cd.new_deaths as BIGINT)) as death --cd.total_cases, cd.total_deaths, (cd.total_deaths/cd.total_cases)*100 as deathpercentage
from covid_death as cd
where continent is NOT NULL and case is NOT null 
GROUP BY cd.date
order by 2 desc

SELECT *
FROM covid_death cd           
JOIN covid_vaksin cv on cd.location=cv.location
and cd."date" = cv."date";

-- Looking at total population vs vaccinations
select cd. continent, cd.location, cd."date", cd.population, cv.new_vaccinations
from covid_death as cd
join covid_vaksin as cv 
    on cd.location = cv.location
    and cd.date = cv."date"
where cd.continent is not NULL
ORDER BY 2,3